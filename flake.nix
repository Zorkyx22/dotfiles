{
  description = "Worker system configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs @ { nixpkgs,  home-manager, stylix, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    overlay = final: prev: {
      pi-coding-agent = final.callPackage ./nix/packages/pi-coding-agent.nix {};
    };
    pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlay ];
    };
  in {
    nixosConfigurations = {
      worker = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs stylix; };
        modules = [
          { nixpkgs.overlays = [ overlay ]; }
          ./nix/system/configuration.nix
          inputs.stylix.nixosModules.stylix
        ];
      };
    };

    homeConfigurations = {
      sire-n1chaulas = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
        extraSpecialArgs = { inherit inputs stylix ; };
        modules = [
          inputs.stylix.homeModules.stylix
          ./nix/home/home.nix
       ];
      };
    };
  };
}
