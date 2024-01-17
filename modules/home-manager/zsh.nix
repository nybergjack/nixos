{ config, inputs , pkgs, ...}:



let
  myAliases = {
   vim="nvim";
   vi="nvim";
   cdnix="cd nixos/hosts/default/";
   cdhome="cd nixos/modules/home-manager/";
   cd2="cd ../..";
   rebnix="sudo nixos-rebuild switch --flake ~/nixos/#default";
   vihome="sudo -e home.nix";
   vinix="sudo -e configuration.nix";
   gc="git clone";
  };
in

{
  programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      initExtra = ''
      # Costom command
      neofetch
      '';
      oh-my-zsh = {
      enable = true;
      plugins = [ "git" "autojump" ];
      theme = "intheloop";
      };
  };
}

