#!/bin/sh

pushd ~/systst
sudo nix-channel --update
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd
