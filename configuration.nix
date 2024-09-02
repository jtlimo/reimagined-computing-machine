{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./shell.nix
      ./network.nix
      ./system.nix
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jessicafileto = {
    isNormalUser = true;
    description = "Jessica de Lima Fileto";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      tidal-hifi
      vscode
      bruno
      dbeaver-bin
      zsh
      brave
      zoom-us
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Define nerdfonts packages to download
  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
 ];

  environment.systemPackages = with pkgs; [
     vim
     zsh
     htop
     git
     fzf
     bat
     eza
     tlrc
     thefuck
     lazygit
     oh-my-zsh
     fd
     fzf-git-sh
     delta
     neovim
     zsh-autosuggestions
     zsh-syntax-highlighting
     gh
     ethtool
     ripgrep
     vscode
     wezterm
     autojump
     asdf
     wget
     tcpdump
     podman
     podman-desktop
     libgcc
     jetbrains.idea-community-bin
     just
     colorls
     gcc
     helix
  ];

 environment.variables.EDITOR = "nvim";
}
