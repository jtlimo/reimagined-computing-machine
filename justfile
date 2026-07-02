default:
    just --list

gc:
    sudo nix-collect-garbage --delete-older-than 7d

deploy:
    nixos-rebuild switch --flake ~/Documents/nixos-config/.#jessicafileto --sudo

debug:
    nixos-rebuild switch --flake ~/Documents/nixos-config/.#jessicafileto --sudo --show-trace --verbose

switch:
    NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild switch --flake ~/Documents/nixos-config/.#jessicafileto --impure --sudo

up:
    nix flake update
