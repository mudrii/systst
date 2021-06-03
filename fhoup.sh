#!/bin/sh

pushd ~/systst
nix build .#homeManagerConfigurations.mudrii.activationPackage
./result/activate
popd
