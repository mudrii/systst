{ config, pkgs, ... }:
/*
let
  unstable = import inputs.nixpkgs-unstable {
    config = nixpkgs.config;
    localSystem = "x86_64-linux";
  };
in
*/
{

  programs.home-manager.enable = true;

  home = {
    username = "mudrii";
    homeDirectory = "/home/mudrii";

    packages = with pkgs; [
       tmux
       sshfs
       #unstable.asciinema
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
