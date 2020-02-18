#!/usr/bin/env sh
PKG_REPO=$PWD

mkdir ../drat

## Set up Repo parameters
git -C ../drat init
git -C ../drat config user.name "Build Pusher"
git -C ../drat config user.email "michal2992@example.com"
git -C ../drat config --global push.default simple

## Get drat repo
git -C ../drat remote add upstream "https://$GH_TOKEN@github.com/mbojan/drat.git"
git -C ../drat fetch upstream 2>err.txt
git -C ../drat checkout gh-pages

echo "PWD=$PWD"
echo "PKG_NAME=$PKG_NAME"
echo "PKG_VERSION=$PKG_VERSION"
echo "PKG_ZIP=$PKG_NAME"

Rscript.exe -e "drat::insertPackage('$PKG_ZIP', repodir = '../drat', commit='Travis update: build $TRAVIS_BUILD_NUMBER of $PKG_NAME on Windows')"
git -C ../drat push 2> /tmp/err.txt

