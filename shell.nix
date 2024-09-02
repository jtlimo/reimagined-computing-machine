{ config, pkgs, ... }: {

users.defaultUserShell = pkgs.zsh;

 programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true; 
  syntaxHighlighting.enable = true;
       shellAliases = {
       cl = "colorls";
       cls = "clear";
       ls = "eza --color=always --long --git --no-filesize --icons=always --no-time";
       lg = "lazygit";
       cat = "bat";
     };
    ohMyZsh = {
    enable = true;
    plugins = [ "autojump" "asdf" "git" "thefuck" "fzf"];
    theme = "obraun";
  };
};
}
