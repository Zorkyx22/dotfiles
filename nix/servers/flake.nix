{
  description = "My servers";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = { self, nixpkgs, nix-minecraft, ... }@inputs:
    let 
    system = "x86_64-linux";
    in {
    nixosConfigurations = {
      minecraftIso = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
          modules = [./minecraft/configuration.nix];
      };
    };
  };
}
