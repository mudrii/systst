#!/bin/sh

pushd ~/systst
nix flake update
sudo nixos-rebuild switch --flake .#
popd
