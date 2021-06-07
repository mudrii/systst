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
                [ ./hardware-configuration.nix ];

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

              users = {
                mutableUsers = false;
                users.mudrii = {
                  isNormalUser = true;
                  extraGroups = [ "wheel" "docker" ];
                  # mkpasswd -m sha-512 password
                  hashedPassword = "$6$ewXNcoQRNG$czTic9vE8CGH.eo4mabZsHVRdmTjtJF4SdDnIK0O/4STgzB5T2nD3Co.dRpVS3/uDD24YUxWrTDy2KRv7m/3N1";
                  openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8/tE2+oIwLnCnfzPSTqiZaeW++wUPNW5fOi124eGzWfcnOQGrjuwir3sZDKMS9DLqSTDNtvJ3/EZf6z/MLN/uxUE8lA+aKaSs0yopE7csQ89Aqkvp5fvCpz3BJuZgpxtwebPZyTc7QRGQWE4lM3fix3aJhfj827bdxA+sCiq8OnNiwYSXrIag1cQigafhLy6tYtCKdWcxzJq2ebGJF2wu2LU0zArb1SAOanhEOXxz0dG1I/7yMDBDC92R287nWpL+BwxuQcDv0xh/sWnViKixKv+B9ewJnz98iQPcg3WmYWe9BYAcaqkbgMqbwfUPqOHhFXmiQWUpOjsni2O6VoiN mudrii@nixos" ];

                  packages = with pkgs; [
                    python38Full
                    (
                      python3.withPackages (
                        ps: with ps; [
                          #poetry
                          pip
                          powerline
                          pygments
                          pygments-markdown-lexer
                          xstatic-pygments
                          pylint
                          numpy
                          pynvim
                        ]
                      )
                    )
                  ];
                };
              };

              environment = {
                systemPackages = with pkgs; [
                  gitAndTools.gitFull
                  google-cloud-sdk-gce
                  pulumi-bin
                  kubernetes
                  kubernetes-helm
                  kubeseal
                  helmfile
                  helmsman
                  kind
                  kube3d
                  argo
                  argocd
                  kustomize
                  k9s
                  kubectx
                  unstable.jq
                  binutils
                  gnutls
                  wget
                  curl
                  neovim
                  htop
                  bind
                  mkpasswd
                  trash-cli
                  exa
                ];

                shellAliases = {
                  cp = "cp -i";
                  diff = "diff --color=auto";
                  dmesg = "dmesg --color=always | lless";
                  egrep = "egrep --color=auto";
                  fgrep = "fgrep --color=auto";
                  grep = "grep --color=auto";
                  la = "exa -alg --group-directories-first -s=type --icons";
                  lless = "set -gx LESSOPEN '|pygmentize -f terminal256 -g -P style=monokai %s' && set -gx LESS '-R' && less -m -g -i -J -u -Q";
                  ll = "exa -la";
                  ls = "exa";
                  mv = "mv -i";
                  ping = "ping -c3";
                  ps = "ps -ef";
                  rm = "trash-put";
                  unrm = "trash-restore";
                  rmcl = "trash-empty";
                  rml = "trash-list";
                  sudo = "sudo -i";
                  vdir = "vdir --color=auto";
                  vim = "nvim";
                };
              };

              programs = {
                gnupg.agent = {
                  enable = true;
                  enableSSHSupport = true;
                };
              };

              services = {
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
                  # dates = "Mon *-*-* 06:00:00";
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
