{
  description = "Root nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    mkHost = hostname: extraModules:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules =
          [
            ./configuration.nix
            ./hosts/${hostname}
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations = {
      fixe = mkHost "fixe" [];
      omen = mkHost "omen" [];
    };
  };
}
