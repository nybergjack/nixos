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


security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };


  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;


  #Walpapper as ~/.background-image
  services.xserver.desktopManager.wallpaper.combineScreens = false;
  services.xserver.desktopManager.wallpaper.mode = "scale";

services.xserver.displayManager.setupCommands = ''
    LEFT='DP-0'
    CENTER='DP-2'
    RIGHT='HDMI-0'
    ${pkgs.xorg.xrandr}/bin/xrandr --output $CENTER --output $LEFT --left-of $CENTER --output $RIGHT --right-of $CENTER 
'';

  # Nvidia support
  services.xserver.videoDrivers = [ "nvidia" ];
  services.picom.vSync = true;
  hardware.enableAllFirmware = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.nvidiaPersistenced = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  # hardware.nvidia.forceFullCompositionPipeline = true;

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
   ripgrep
   fd
   direnv
   openssl
   mongodb-compass
   dbeaver
   postgresql
   insomnia
   vscode
	 gnumake
	 gcc
	 git
   lazygit
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
   libverto
   xclip
   gimp
	 xfce.thunar
	 xorg.libX11
	 xorg.libX11.dev
	 xorg.libxcb
	 xorg.libXft
	 xorg.libXinerama
	 xorg.xinit
   xorg.xinput
   #Game
   steam
   steam-run
   lutris
   mangohud
   (lutris.override {
        extraPkgs = pkgs: [
          # List package dependencies here
          winetricks
        ];
      })
  ];

  #Enable zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # postgres
  services.postgresql.enable = true;
  services.postgresql.enableTCPIP = true;
  services.postgresql.ensureDatabases = [ "mydatabase" ];
  services.postgresql.package = pkgs.postgresql;
  services.postgresql.authentication = lib.mkForce ''
    # Generated file; do not edit!
    # TYPE  DATABASE        USER            ADDRESS                 METHOD
    local   all             all                                     trust
    host    all             all             127.0.0.1/32            trust
    host    all             all             ::1/128                 trust
    '';
  services.postgresql.initialScript = pkgs.writeText "backend-initScript" ''
    CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
    CREATE DATABASE nixcloud;
    GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
  '';


  #Install nerdfonts
  fonts.packages = with pkgs; [
  nerdfonts
];

   nixpkgs.overlays = [
	(final: prev: {
		dwm = prev.dwm.overrideAttrs (old: { src = /home/jack/suckless/dwm ;});
	})
  ];

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  system.stateVersion = "23.11"; 
}
