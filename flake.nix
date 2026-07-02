{
  description = "Avell Notebook Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixvim.url = "github:daniloraisi/nixvim";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
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
        pkgs.ocenaudio
        pkgs.easyeffects
      ];

      shellHook = ''
        export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH

        echo "🎧 Ambiente de transcrição pronto"
      '';
    };
  };
}
