{ config, pkgs, ... }:

{

  programs.home-manager.enable = true;

  home = { 
    username = "mudrii";
    homeDirectory = "/home/mudrii";
    packages = with pkgs; [
      sshfs
      tmux
      google-cloud-sdk-gce
      pulumi-bin
      gitAndTools.gitFull
      gitAndTools.git-hub
      gitAndTools.gh
      git-crypt
      git-lfs   
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
      nodejs
      python38Full
      python38Packages.poetry
      python38Packages.pip
      python38Packages.powerline
      python38Packages.pygments
      python38Packages.pygments-markdown-lexer
      python38Packages.xstatic-pygments
      python38Packages.pylint
      python38Packages.numpy
      python38Packages.pynvim
      aspell
      aspellDicts.en
      asciinema
      highlight
      jq 
      bat
      ripgrep-all
      tldr 
      procs
      fd    
      nodejs
  ];
  
  stateVersion = "21.03";
  };
}
