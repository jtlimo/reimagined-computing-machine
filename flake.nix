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

  devShells.${system}.audio = (pkgs.buildFHSEnv {
      name = "audio-env";
      targetPkgs = pkgs: [
        pythonEnv
        pkgs.stdenv.cc.cc.lib
        pkgs.ffmpeg
        pkgs-unstable.ocenaudio
        pkgs.easyeffects
        
        # Bibliotecas que fornecem os esquemas globais do GTK de forma nativa na estrutura FHS
        pkgs.glib
        pkgs.gtk3
        pkgs.gsettings-desktop-schemas
      ];
      profile = ''
        export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
        echo "🎧 Ambiente FHS pronto. Rode 'ocenaudio' para testar."
      '';
    }).env;
  };
}
