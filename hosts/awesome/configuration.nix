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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:pa/200ssword@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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



  services = {

    xserver = {
      enable = true;
      layout = "se";
      xkbVariant = "";

      displayManager = {
        autoLogin = {
          enable = false;
          user = "jack";
        };

        setupCommands = ''
        LEFT='DP-2'
        CENTER='DP-1'
        RIGHT='HDMI-2'
        ${pkgs.xorg.xrandr}/bin/xrandr --output $CENTER --output $LEFT --left-of $CENTER --output $RIGHT --right-of $CENTER 
        '';

        defaultSession = "none+awesome";

        lightdm = {
          enable = true;
          greeters.gtk.enable = true;
        };
      };

      windowManager = {
        awesome = {
          enable = true;

          luaModules = lib.attrValues {
            inherit (pkgs.luajitPackages) lgi ldbus luadbi-mysql luaposix;
          };
        };
      };
    };

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
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
        xclip
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


#   nixpkgs.overlays = [
#	(final: prev: {
#		awesome = prev.awesome .overrideAttrs (old: { src = /home/jack/.config/awesome/;});
#	})
#  ];

  system.stateVersion = "23.11"; # Did you read the comment?

}
