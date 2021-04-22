{ pkgs ? import <nixpkgs> {} }:

let
  tfnix = import (fetchTarball "https://github.com/bryght-space/tfnix/archive/2330a36d737d3eda0a06f4b135da99c718a536ab.tar.gz");
  terraform = tfnix ./.;
in
  pkgs.mkShell {
    buildInputs = [
      terraform
    ];
  }


