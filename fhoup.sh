#!/bin/sh

pushd ~/systst
nix build .#homeManagerConfiguration.mudrii.activationPackage
./result/activate
popd
