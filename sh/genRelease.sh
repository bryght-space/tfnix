#!/bin/bash

branch="release"
current_branch=`git rev-parse --abbrev-ref HEAD`
current_hash=`git rev-parse --verify HEAD`

tmp_dir=$(mktemp -d -t qs1-XXXXXXXXXX)

cp -Rf src/* $tmp_dir


git fetch

if (git rev-parse --verify $branch)
then
  echo "checkout existing version of the branch"
  git checkout $branch
else
  echo "initial version of the branch"
  git checkout --orphan $branch
fi

git rm --ignore-unmatch -rf .
git clean -f

cp -Rf $tmp_dir/* .

git add .
git commit --allow-empty -m "[skip actions] Add new release"

version=`git rev-parse --verify HEAD`

git push --set-upstream origin $branch
git checkout $current_branch

git reset --hard origin/$current_branch
git clean -f



mkdir -p example

echo "{ pkgs ? import <nixpkgs> {} }:

let
  tfnix = import (fetchTarball \"https://github.com/bryght-space/tfnix/archive/${version}.tar.gz\");
  terraform = tfnix ./.;
in
  pkgs.mkShell {
    buildInputs = [
      terraform
    ];
  }

" > example/shell.nix

git add .
git commit --allow-empty -m "[skip actions] Update example"
git push
