{ config, pkgs, ... }:

{

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
      unstable.kind
      kube3d
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
#      direnv
#      nix-direnv
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

}
