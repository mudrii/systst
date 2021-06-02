#!/bin/sh

pushd ~/dotfiles
sudo nix-channel --update
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd
