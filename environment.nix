{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

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
    podman
    podman-desktop
    libgcc
    jetbrains.idea-community-bin
    just
    colorls
    gcc
    helix
    asdf-vm
    podman-compose
    inputs.nixvim.packages.x86_64-linux.default # neovim config from github
  ];

  environment.variables.EDITOR = "nvim";
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
