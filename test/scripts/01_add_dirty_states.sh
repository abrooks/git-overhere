#!/usr/bin/env bash

set -e
. $(dirname $0)/library.sh

mkdir test_repo
cd test_repo
git init
mkdir -p path/to
echo "content" > path/to/afile
git add .
git commit -m "First commit"

git overhere

if git overhere add REPO REF path/to/afile; then
   die "Didn't catch file collision"
fi

if git overhere add REPO REF path/to; then
   die "Didn't catch directory collision"
fi

echo "new content" > path/to/afile

if git overhere add REPO REF path/to/nocollision; then
   die "Didn't catch dirty repo"
fi
