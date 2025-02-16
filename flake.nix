{
  description = "Worker system configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url="github:ghostty-org/ghostty";
  };
  
  outputs = { nixpkgs, ghostty,  home-manager, ... } @ inputs:
  let 
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
        inherit system;
    };
  in {
    nixosConfigurations = {
      worker = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./nix/system/configuration.nix
          inputs.stylix.nixosModules.stylix
          { environment.systemPackages = [ inputs.ghostty.packages.x86_64-linux.default ]; }
        ];
      };
    };

    homeConfigurations = {
      sire-n1chaulas = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./nix/home/home.nix ];
      };
    };
  };
}
