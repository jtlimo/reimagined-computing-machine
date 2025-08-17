{
  description = "Avell Notebook Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixvim.url = "github:daniloraisi/nixvim";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: let
    system = "x86_64-linux";  # Explicitly define system architecture
  in {
    nixosConfigurations.jessicafileto = nixpkgs.lib.nixosSystem {
      inherit system;  # Pass the system explicitly
      
      modules = [
        ./configuration.nix
        {
          nixpkgs.config.allowUnfree = true;
          _module.args = {
            inherit inputs;
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        }
      ];
    };
  };
}
