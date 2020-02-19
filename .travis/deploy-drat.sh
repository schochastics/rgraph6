#!/usr/bin/env sh

# Usage: deploy-drat.sh [pkg.tarball | pkg.zip | pkg.tgz]

set -o errexit -o verbose -o nounset

PKG=$1
PKG_REPO=$PWD
DRAT=../drat

mkdir $DRAT

## Set up Repo parameters
git -C $DRAT init
git -C $DRAT config user.name "Build Pusher"
git -C $DRAT config user.email "michal2992@gmail.com"
git -C $DRAT config --global push.default simple

## Get drat repo
git -C $DRAT remote add upstream "https://$GH_TOKEN@github.com/mbojan/drat.git"
git -C $DRAT fetch upstream 2>err.txt
git -C $DRAT checkout gh-pages

echo "PWD=$PWD"
echo "PKG=$PKG"
echo "PKG_NAME=$PKG_NAME"
echo "PKG_VERSION=$PKG_VERSION"
echo "PKG_ZIP=$PKG_ZIP"

Rscript.exe -e "drat::insertPackage('$PKG', repodir = '$DRAT', commit='Travis update: build $TRAVIS_BUILD_NUMBER of $PKG_NAME: $PKG')"
git -C $DRAT push 2>err.txt

