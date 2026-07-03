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

  devShells.${system}.audio = (pkgs.buildFHSUserEnv {
      name = "audio-env";
      
      targetPkgs = pkgs: [
        pythonEnv
        pkgs.stdenv.cc.cc.lib
        pkgs.ffmpeg
        pkgs-unstable.ocenaudio        
        pkgs.easyeffects
        
        # Dependências de sistema que o ocenaudio precisa para GTK e Schemas
        pkgs.glib
        pkgs.gtk3
        pkgs.gsettings-desktop-schemas
        pkgs.dconf                      # Necessário para salvar configurações
      ];

      # Comandos executados ao entrar no ambiente
      profile = ''
        export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
        
        # Vincula os esquemas do host para dentro do FHS
        export GSETTINGS_SCHEMAS_PATH=/usr/share/gsettings-desktop-schemas/$(basename ${pkgs.gsettings-desktop-schemas.name})
        
        echo "🎧 Ambiente FHS de transcrição pronto (Ocenaudio corrigido)"
      '';
    }).env; 
  };
}
