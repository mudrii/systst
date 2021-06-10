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
#      jq
      binutils
      gnutls
      wget
      curl
#      htop
      bind
      mkpasswd
#      trash-cli
#      exa
      direnv
      nix-direnv
    ];

    shellAliases = {
      cp = "cp -i";
      diff = "diff --color=auto";
      dmesg = "dmesg --color=always | lless";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      grep = "grep --color=auto";
#      la = "exa -alg --group-directories-first -s=type --icons";
      lless = "set -gx LESSOPEN '|pygmentize -f terminal256 -g -P style=monokai %s' && set -gx LESS '-R' && less -m -g -i -J -u -Q";
#      ll = "exa -la";
#      ls = "exa";
      mv = "mv -i";
      ping = "ping -c3";
      ps = "ps -ef";
#      rm = "trash-put";
#      unrm = "trash-restore";
#      rmcl = "trash-empty";
#      rml = "trash-list";
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
