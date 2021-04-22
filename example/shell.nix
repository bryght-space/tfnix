{ pkgs ? import <nixpkgs> {} }:

let
  tfnix = import (fetchTarball "https://github.com/bryght-space/tfnix/archive/bd832dcd385f062bac1b4f91de1ef312755b4fe5.tar.gz");
  terraform = tfnix ./.;
in
  pkgs.mkShell {
    buildInputs = [
      terraform
    ];
  }


