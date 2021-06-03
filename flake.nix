{
  description = "My flakes copnfig";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-20.09";
    home-manager.url = "github:nix-community/home-manager/release-20.09";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    lib = nixpkgs.lib;

  in {
    homeManagerConfigurations = {
      mudrii = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "mudrii";
        homeDirectory = "/home/mudrii";
        configuration = {
          imports = [
            /home/mudrii/.config/nixpkgs/home.nix
          ];
        };
      };
    };
    nixosConfigurations = {
      nixtst = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      }; 
    };
  };
}
