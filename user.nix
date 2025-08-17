{ config, pkgs, lib, ... }: {
# Define a user account. Don't forget to set a password with ‘passwd’.
  
  users.users.jessicafileto = {  
    isNormalUser = true;
    description = "Jessica de Lima Fileto";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      bruno
      dbeaver-bin
      zsh
      brave
      zoom-us
      telegram-desktop
      discord
      yarr
      librewolf
      spotify
      onlyoffice-desktopeditors
      standardnotes
      kdePackages.okular
    ];
  };
}
