default: 
 just --list

gc:
 sudo nix-collect-garbage --delete-older-than 7d

deploy: 
 nixos-rebuild switch --flake ~/Documents/nixos-config.#jessicafileto --use-remote-sudo

debug: 
 nixos-rebuild switch --flake ~/Documents/nixos-config.#jessicafileto --use-remote-sudo --show-trace --verbose

up: 
 nix flake update
