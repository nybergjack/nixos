{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.


  imports = [
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/git.nix
    # does not work propeply
    # ../../modules/home-manager/nvim.nix 
  ];

  home.username = "jack";
  home.homeDirectory = "/home/jack";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    kitty
    picom
    git
    tmux
    rofi
    dmenu
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };
    
  home.sessionVariables = {
    EDITOR = "nvim";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
