{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Neovim plugins that does not have a nix plugin

    plugin-auto-session.url = "github:rmagatti/auto-session";
    plugin-auto-session.flake = false;

    plugin-nvim-tree.url = "github:nvim-tree/nvim-tree.lua";
    plugin-nvim-tree.flake = false;
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ 
            ./hosts/default/configuration.nix
             inputs.home-manager.nixosModules.default
          ];
        };
    };
}
