#!/usr/bin/env bash

set -e

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

mkdir to_graft
cd to_graft
git init
mkdir -p p1/p2/
echo "content" > p1/p2/file
git add .
git commit -m "First commit"
cd ..

mkdir test_repo
cd test_repo
git init
echo "content" > afile
git add .
git commit -m "First commit"
git overhere
cd ..
