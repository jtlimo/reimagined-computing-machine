{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Enable wakeOnLan
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "jessicafileto";
  };
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define nerdfonts packages to download
  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
 ];

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
 users.defaultUserShell = pkgs.zsh;

 programs.zsh = {
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true; 
  syntaxHighlighting.enable = true;
       shellAliases = {
       cl = "colorls";
       cls = "clear";
       ls = "eza --color=always --long --git --no-filesize --icons=always --no-time";
       lg = "lazygit";
       cat = "bat";
     };
    oh-my-zsh = {
    enable = true;
    plugins = [ "autojump" "asdf" "git" "thefuck" "fzf"];
    theme = "obraun";
  };
};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
