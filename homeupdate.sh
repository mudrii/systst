#!/bin/sh

pushd ~/systst
nix-channel --update
home-manager switch -f ./users/mudrii/home.nix
popd
