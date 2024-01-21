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


security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};

  # Configure keymap in X11
  services.xserver = {
    layout = "se";
    xkbVariant = "";
  };


  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;


  #Walpapper as ~/.background-image
  services.xserver.desktopManager.wallpaper.combineScreens = false;
  services.xserver.desktopManager.wallpaper.mode = "scale";

services.xserver.displayManager.setupCommands = ''
    LEFT='DP-2'
    CENTER='DP-1'
    RIGHT='HDMI-2'
    ${pkgs.xorg.xrandr}/bin/xrandr --output $CENTER --output $LEFT --left-of $CENTER --output $RIGHT --right-of $CENTER 
'';

  # Nvidia support
#  services.xserver.videoDrivers = [ "nvidia" ];
#  services.picom.vSync = true;
#  hardware.enableAllFirmware = true;
#  hardware.nvidia.nvidiaSettings = true;
#  hardware.nvidia.nvidiaPersistenced = true;
#  hardware.nvidia.modesetting.enable = true;
#  hardware.opengl.enable = true;
#  hardware.opengl.driSupport = true;
#  hardware.opengl.driSupport32Bit = true;

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jack = {
    isNormalUser = true;
    description = "Jack Nyberg";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  #Home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jack" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
   fzf
   mongodb-compass
   insomnia
   vscode
	 gnumake
	 gcc
	 git
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
   python3
	 xfce.thunar
	 xorg.libX11
	 xorg.libX11.dev
	 xorg.libxcb
	 xorg.libXft
	 xorg.libXinerama
	 xorg.xinit
   xorg.xinput
  ];

  #Enable zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  
  #Install nerdfonts
  fonts.packages = with pkgs; [
  nerdfonts
];

   nixpkgs.overlays = [
	(final: prev: {
		dwm = prev.dwm.overrideAttrs (old: { src = /home/jack/suckless/dwm ;});
	})
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?


}
