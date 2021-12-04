{ config, pkgs, ... }:

{

  imports = [
    ./services/nixos-auto-update.nix
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

  networking = {
    useDHCP = false;
    interfaces.enp1s0.useDHCP = true;
    hostName = "nixtst"; # Define your hostname.
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 2022 ];
      allowedUDPPorts = [ 53 ];
      allowPing = true;
    };
  };

  time.timeZone = "Asia/Singapore";

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
    nixos-auto-update.enable = true;
    logrotate = {
      enable = true;
      extraConfig = ''
        compress
        create
        daily
        dateext
        delaycompress
        missingok
        notifempty
        rotate 31
      '';
    };
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
      forwardX11 = true;
      ports = [ 2022 ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  users = {
    mutableUsers = false;
    users.mudrii = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      shell = pkgs.fish;
      # mkpasswd -m sha-512 password
      hashedPassword = "$6$ewXNcoQRNG$czTic9vE8CGH.eo4mabZsHVRdmTjtJF4SdDnIK0O/4STgzB5T2nD3Co.dRpVS3/uDD24YUxWrTDy2KRv7m/3N1";
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8/tE2+oIwLnCnfzPSTqiZaeW++wUPNW5fOi124eGzWfcnOQGrjuwir3sZDKMS9DLqSTDNtvJ3/EZf6z/MLN/uxUE8lA+aKaSs0yopE7csQ89Aqkvp5fvCpz3BJuZgpxtwebPZyTc7QRGQWE4lM3fix3aJhfj827bdxA+sCiq8OnNiwYSXrIag1cQigafhLy6tYtCKdWcxzJq2ebGJF2wu2LU0zArb1SAOanhEOXxz0dG1I/7yMDBDC92R287nWpL+BwxuQcDv0xh/sWnViKixKv+B9ewJnz98iQPcg3WmYWe9BYAcaqkbgMqbwfUPqOHhFXmiQWUpOjsni2O6VoiN mudrii@nixos" ];
      packages = with pkgs; [
        python39Full
      ];
    };
  };

  programs = {
    ssh.startAgent = false;
    vim.defaultEditor = true;
    fish.enable = true;
    nano.nanorc = ''
      unset backup
      set nonewlines
      set nowrap
      set tabstospaces
      set tabsize 4
      set constantshow
    '';
  };

  environment = {
    systemPackages = with pkgs; [
      google-cloud-sdk-gce
      git
      gh
      pulumi-bin
      #unstable.pulumi-bin
      inotify-tools
      nodejs
      kubernetes
      kubernetes-helm
      kubeseal
      helmfile
      helmsman
      unstable.kind
      unstable.kube3d
      argo
      argocd
      kustomize
      k9s
      kubectx
      binutils
      gnutls
      wget
      curl
      bind
      mkpasswd
      cachix
    ];

    shellAliases = {
      cp = "cp -i";
      diff = "diff --color=auto";
      dmesg = "dmesg --color=always | lless";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      grep = "grep --color=auto";
      mv = "mv -i";
      ping = "ping -c3";
      ps = "ps -ef";
      sudo = "sudo -i";
      vdir = "vdir --color=auto";
    };
  };

  nixpkgs = {
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
      keep-outputs = true
      keep-derivations = true
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
    /*    binaryCaches = [
      "https://matrix.cachix.org"
      ];
      binaryCachePublicKeys = [
      "matrix.cachix.org-1:h2ZM1LtvJBQhCb7a2Z/UpO8PKKIUlIvifvrFKfnHkro="
      ];*/
  };
  system = {
    stateVersion = "21.11"; # Did you read the comment?
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      flake = "github:mudrii/systst";
      flags = [
        "--recreate-lock-file"
        "--no-write-lock-file"
        "-L" # print build logs
      ];
      dates = "daily";
    };
  };
}
