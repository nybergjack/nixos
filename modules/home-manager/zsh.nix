{ config, inputs , pkgs, ...}:



let
  myAliases = {
   vim="nvim";
   vi="nvim";
   cddwm="cd nixos/hosts/dwm/";
   cdawesome="cd nixos/hosts/awesome/";
   cdhypr="cd nixos/hosts/hyprland/";
   cdhome="cd nixos/modules/home-manager/";
   cd2="cd ../..";
   rebdwm="sudo nixos-rebuild switch --flake ~/nixos/#dwm";
   rebawesome="sudo nixos-rebuild switch --flake ~/nixos/#awesome";
   rebhypr="sudo nixos-rebuild switch --flake ~/nixos/#hyprland";
   vihome="vi home.nix";
   vinix="vi configuration.nix";
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
      plugins = [ "git" "tmux"];
      theme = "intheloop";
      };
  };
}

