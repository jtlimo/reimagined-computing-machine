{ config, pkgs, ... }: {
  programs.firefox.enable = true;
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