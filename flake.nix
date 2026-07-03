{
  description = "Avell Notebook Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixvim.url = "github:daniloraisi/nixvim";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    pythonEnv = pkgs.python3.withPackages (ps: with ps; [
      numpy
      sounddevice
      websockets
    ]);
  in
  {
    nixosConfigurations.jessicafileto = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix
        {
          _module.args = { inherit inputs; };

          nixpkgs.config.allowUnfree = true;
          nixpkgs.config.permittedInsecurePackages = [
            "pnpm-10.29.2"
          ];
        }
      ];
    };

  devShells.${system}.audio = pkgs.mkShell {
      packages = [
        pythonEnv

        pkgs.stdenv.cc.cc.lib
        pkgs.ffmpeg
        pkgs-unstable.ocenaudio
        pkgs.easyeffects
        
        # Garante que os pacotes de ambiente estão acessíveis
        pkgs.gsettings-desktop-schemas
        pkgs.gtk3
        pkgs.dconf
      ];

      shellHook = ''
        export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH

        # A chave de ouro: força o GIO a carregar o dconf e os backends de settings
        export GIO_EXTRA_MODULES="${pkgs.dconf}/lib/gio/modules"

        # Aponta o XDG direto para as pastas de share onde moram os schemas compilados
        export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share:${pkgs.gtk3}/share:$XDG_DATA_DIRS"
        
        # Alvo direto no schema do FileChooser do GTK3
        export GSETTINGS_SCHEMAS_PATH="${pkgs.gsettings-desktop-schemas}/share/gsettings-desktop-schemas/gsettings-desktop-schemas:${pkgs.gtk3}/share/gsettings-desktop-schemas/gtk+3.0"

        echo "🎧 Ambiente de transcrição pronto"
      '';
    };
  };
}
