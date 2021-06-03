#!/bin/sh

pushd ~/systst
sudo nix-channel --update
sudo nixos-rebuild test -I nixos-config=./system/configuration.nix
popd
