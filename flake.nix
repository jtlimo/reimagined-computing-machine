{
  description = "Avell Notebook Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {
    nixosConfigurations.jessicafileto = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix

        {
          # Habilita unfree globalmente
          nixpkgs.config.allowUnfree = true;

          # Overlay para acessar pkgs.unstable
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;  # <- aqui garante para unstable
              };
            })
          ];
        }
      ];
    };
  };
}
