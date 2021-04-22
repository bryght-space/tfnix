{ pkgs ? import <nixpkgs> {} }:

let
  tfnix = import (fetchTarball "https://github.com/bryght-space/tfnix/archive/dfcdb18247382683dba9a47ccfa5af9939b65ed1.tar.gz");
  terraform = tfnix ./.;
in
  pkgs.mkShell {
    buildInputs = [
      terraform
    ];
  }


