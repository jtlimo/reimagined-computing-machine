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
        pkgs.glib
        pkgs.gsettings-desktop-schemas
        pkgs.gtk3
      ];

      shellHook = ''
        export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH

        # Garante que o shell herda os schemas de dados e ícones do sistema e do nixpkgs
        export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share:${pkgs.gtk3}/share:$XDG_DATA_DIRS"
        
        # Define explicitamente onde procurar os schemas do GTK
        export GSETTINGS_SCHEMAS_PATH="${pkgs.gsettings-desktop-schemas}/share/gsettings-desktop-schemas/${pkgs.gsettings-desktop-schemas.name}"

        echo "🎧 Ambiente de transcrição pronto"
      '';
    };
  };
}
