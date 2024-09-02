{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./shell.nix
      ./network.nix
      ./system.nix
      ./user.nix
      ./fonts.nix
      ./environment.nix
    ];
}
