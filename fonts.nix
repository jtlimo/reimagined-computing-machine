{ config, pkgs, ... }: {
  # Define nerdfonts packages to download

 fonts.packages = [
           pkgs.nerd-fonts.jetbrains-mono
           pkgs.nerd-fonts.droid-sans-mono
           pkgs.nerd-fonts.fira-code
         ];
}
