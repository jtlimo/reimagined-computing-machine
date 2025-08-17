{
  description = "Avell Notebook Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixvim.url = "github:daniloraisi/nixvim";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {
    nixosConfigurations.jessicafileto = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Special arguments for modules
      specialArgs = { inherit inputs; };
      
      modules = [
        ./configuration.nix
        ({ config, pkgs, ... }: {
          # Allow unfree packages system-wide
          nixpkgs.config.allowUnfree = true;
          
          # Configure unstable channel with unfree allowed
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            })
          ];
        })
      ];
    };
  };
}
