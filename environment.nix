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
    wezterm
    autojump
    asdf
    wget
    tcpdump
    podman-desktop
    libgcc
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
    unstable.dive
    ctop
    btop
    ktop
    doggo
    asciinema
    unstable.atac
    k9s
    ghostty
    neovim
    # inputs.nixvim.packages.x86_64-linux.default # neovim config from github #removing to waiting fix
    krita
    aseprite
    unstable.zotero
    unstable.vlc
  ];

  environment.variables.EDITOR = "nvim";

  virtualisation.docker.enable = true;
}
