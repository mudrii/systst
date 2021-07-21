{ config, pkgs, ... }:
{

  programs.home-manager.enable = true;

  home = {
    username = "mudrii";
    homeDirectory = "/home/mudrii";

    packages = with pkgs; [
       tmux
       sshfs
       asciinema
       highlight
       nodejs
       aspell
       aspellDicts.en
       bat
       ripgrep-all
       tldr
       procs
       fd
       gitAndTools.gh
       git-crypt
       git-lfs
  ];

  stateVersion = "21.05";
  };
}
