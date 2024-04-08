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
   updatenix="sudo nix flake update";
   listnix="nix profile history --profile /nix/var/nix/profiles/system";
   delnix="sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d";
   vihome="vi home.nix";
   vinix="vi configuration.nix";
   gc="git clone";
   createreacttype="npx create-react-app . --template typescript";
  };
in
{
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      initExtra = ''
      # Costom command
      neofetch
      eval "$(direnv hook zsh)"
      eval "$(zoxide init zsh)"

      # Autoload zsh shell functions defined in the function path 
      FPATH="$HOME/.zsh_autoload_functions:$FPATH"
      autoload -Uz load_open_ai
      '';
      oh-my-zsh = {
      enable = true;
      plugins = [ "git"];
      theme = "intheloop";
      };
  };
}

