{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      #---------------  DWM -------------------------#
      nixosConfigurations.dwm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ 
            #./hosts/dwm/configuration.nix
            ./hosts/dwm/configuration.nix
             inputs.home-manager.nixosModules.default
          ];
        };
        
      #---------------  Awesome  -------------------------#
        nixosConfigurations.awesome= nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
          modules = [ 
            ./hosts/awesome/configuration.nix
             inputs.home-manager.nixosModules.default
          ];
        };

      #---------------  Hyprland  -------------------------#
        nixosConfigurations.hyprland= nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
          modules = [ 
            ./hosts/hyprland/configuration.nix
             inputs.home-manager.nixosModules.default
          ];
        };
    };
}
