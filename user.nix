{ config, pkgs, ... }: {
# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jessicafileto = {
    isNormalUser = true;
    description = "Jessica de Lima Fileto";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
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
      telegram-desktop
      discord
      yarr
      librewolf
    ];
  };
}
