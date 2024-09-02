default:
just --list
  
hello:
echo "hello world"

#[group('nix')]
#gc:
# garbage collect all unused nix store entries (system-wide)
#@sudo nix-collect-garbage --delete-older-than 7d

deploy:
nixos-rebuild switch --flake . --use-remote-sudo

debug:
nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose

up:
nix flake update
