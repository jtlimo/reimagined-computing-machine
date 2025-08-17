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
      
      # Import the packages with unfree allowed
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      # Similarly configure unstable packages
      specialArgs = {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs;
      };

      modules = [
        ./configuration.nix
      ];
    };
  };
}
