{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }: {
    nixosConfigurations = {
      nixtst = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }:
            let
              overlay-unstable = final: prev: {
                unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
              };
            in
            {
              imports =
                [
                  ./hardware-configuration.nix
                  ./users/admin_users.nix
                  ./users/dev_users.nix
                  ./packages.nix
                ];

              fileSystems."/" = { options = [ "noatime" "nodiratime" ]; };

              boot = {
                kernelPackages = pkgs.linuxPackages_latest;
                loader = {
                  efi.canTouchEfiVariables = true;
                  grub = {
                    enable = true;
                    version = 2;
                    efiSupport = true;
                    enableCryptodisk = true;
                    device = "nodev";
                  };
                };
                initrd.luks.devices = {
                  crypt = {
                    device = "/dev/vda2";
                    preLVM = true;
                  };
                };
              };

              time.timeZone = "Asia/Singapore";

              networking = {
                useDHCP = false;
                interfaces.enp1s0.useDHCP = true;
                hostName = "nixtst"; # Define your hostname.
              };

              security = {
                sudo = {
                  enable = true;
                  wheelNeedsPassword = false;
                };
              };

              i18n = {
                defaultLocale = "en_US.UTF-8";
                supportedLocales = [ "en_US.UTF-8/UTF-8" ];
              };

              console = {
                font = "Lat2-Terminus16";
                keyMap = "us";
              };

              fonts = {
                fontDir.enable = true;
                enableGhostscriptFonts = true;
                fonts = with pkgs; [
                  powerline-fonts
                  nerdfonts
                ];
              };

              services = {
                lorri.enable = true;
                openssh = {
                  enable = true;
                  permitRootLogin = "no";
                  passwordAuthentication = false;
                };
              };

              nixpkgs = {
                overlays = [ overlay-unstable ];
                config = {
                  allowBroken = true;
                  allowUnfree = true;
                };
              };

              nix = {
                package = pkgs.nixFlakes;
                useSandbox = true;
                autoOptimiseStore = true;
                readOnlyStore = false;
                allowedUsers = [ "@wheel" ];
                trustedUsers = [ "@wheel" ];
                extraOptions = ''
                  experimental-features = nix-command flakes
                '';
                gc = {
                  automatic = true;
                  dates = "weekly";
                  options = "--delete-older-than 7d --max-freed $((64 * 1024**3))";
                };
                optimise = {
                  automatic = true;
                  dates = [ "weekly" ];
                };
              };
              system.stateVersion = "21.05"; # Did you read the comment?
            }
          )
        ];
      };
    };
  };
}
