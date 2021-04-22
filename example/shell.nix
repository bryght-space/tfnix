{ pkgs ? import <nixpkgs> {} }:

let
  tfnix = import (fetchTarball "https://github.com/bryght-space/tfnix/archive/1a60d1a3001dba0b84f269d41066be0a60c24d7d.tar.gz");
  terraform = tfnix ./.;
in
  pkgs.mkShell {
    buildInputs = [
      terraform
    ];
  }


