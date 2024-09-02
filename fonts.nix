{ config, pkgs, ... }: {
  # Define nerdfonts packages to download

  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
 ];
 
}