{ config, pkgs, ... }: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # Enable wakeOnLan
  networking.interfaces.enp3s0.wakeOnLan.enable = true;
}