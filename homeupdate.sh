#!/bin/sh

pushd ~/dotfiles
nix-channel --update
home-manager switch -f ./users/mudrii/home.nix
popd
