#!/bin/sh

pushd ~/systst
sudo nixos-rebuild switch --flake .#
popd
