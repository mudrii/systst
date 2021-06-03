#!/bin/sh

pushd ~/systst
nix flake update
popd
