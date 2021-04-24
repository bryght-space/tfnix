{ pkgs ? import <nixpkgs> {} }:

let
  tfnix = import (fetchTarball "https://github.com/bryght-space/tfnix/archive/de6a229f1a9099d0f3d2453a4e3096a725b7bb07.tar.gz");
  terraform = tfnix ./.;
in
  pkgs.mkShell {
    buildInputs = [
      terraform
    ];
  }


