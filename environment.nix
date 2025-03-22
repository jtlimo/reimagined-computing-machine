{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
in {
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
    podman-desktop
    libgcc
    jetbrains.idea-community-bin
    just
    colorls
    gcc
    asdf-vm
    unstable.lazydocker
    gnomeExtensions.appindicator
    adwaita-icon-theme
    gnome-tweaks
    zed-editor
    pulsar
    unstable.docker
    # inputs.nixvim.packages.x86_64-linux.default # neovim config from github #removing to waiting fix
  ];

  environment.variables.EDITOR = "nvim";

  virtualisation.docker.enable = true;
}
