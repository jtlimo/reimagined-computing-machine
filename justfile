NIXOS := "~/Documents/nixos-config"
    
deploy:
    sudo nixos-rebuild switch --flake {{NIXOS}}#jessicafileto

debug:
    sudo nixos-rebuild switch --flake {{NIXOS}}#jessicafileto --show-trace --verbose

switch:
    sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild switch --flake {{NIXOS}}#jessicafileto --impure

up:
    nix flake update --flake {{NIXOS}}

gc:
    sudo nix-collect-garbage --delete-older-than 7d

audio:
    nix develop {{NIXOS}}#audio
