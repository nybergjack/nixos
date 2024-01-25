 # Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  
  # Add nix flakes
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "sv_SE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

users.users.jack = {
	isNormalUser = true;
	description = "Jack Nyberg";
	extraGroups = [ "wheel" ];
};

users.defaultUserShell = pkgs.zsh;

security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};

 home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jack" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Install nerdfonts
  fonts.packages = with pkgs; [
  nerdfonts
];

services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

environment = {
    systemPackages = lib.attrValues {
      inherit (pkgs)
        dmenu
        kitty
        oh-my-zsh
        zsh
        zsh-completions
        zsh-powerlevel10k
        zsh-syntax-highlighting
        zsh-history-substring-search
        st
        picom
        mongodb-compass
        insomnia
        vscode
        btop
        git
        wget
        lazygit
        gcc
        ripgrep
        fd
        firefox
        tmux
        neofetch
        nodejs
        rofi
        wlogout
        neovim
        spotify
        unzip
        teams-for-linux
        discord
        python3;
    };
  };

   programs = {
    
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    zsh = {
      enable = true;
    };

    thunar = {
      enable = true;

      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}
