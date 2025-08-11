{ config, pkgs, ... }: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Enable GNOME Desktop environment.
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
};

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "jessicafileto";

  # Not suspend when close the notebook lid
  services.logind.extraConfig = "HandleLidSwitch=ignore";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable systemd-resolved
  # This is necessary because of mullvad vpn
  services.resolved.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow unsupported system
  nixpkgs.config.allowUnsupportedSystem = true;

  # Allow insecure packages
  nixpkgs.config.permittedInsecurePackages = ["pulsar-1.128.0"];

  # Enable the Flakes feature and the new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # FIXME: Workaround for crashes when autologin in gnome
  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Enable gnome-settings daemon to get systray icons
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  system.stateVersion = "24.05";
}
