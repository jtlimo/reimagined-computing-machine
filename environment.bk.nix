{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox.enable = true;

  let
    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  in {
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
      # podman
      podman-desktop
      libgcc
      jetbrains.idea-community-bin
      just
      colorls
      gcc
      asdf-vm
      podman-compose
      # inputs.nixvim.packages.x86_64-linux.default # neovim config from github #removing to waiting fix
      lazydocker
      gnomeExtensions.appindicator
      adwaita-icon-theme
      gnome-tweaks
      zed-editor
      pulsar
      unstable.podman
    ];

  # environment.systemPackages = with pkgs; [
  
  # ];

    environment.variables.EDITOR = "nvim";
    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
