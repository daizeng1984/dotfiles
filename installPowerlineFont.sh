#!/bin/bash
tmpdir="/tmp"
[ ! -z $TMPDIR ] && tmpdir=$TMPDIR
[ ! -d $tmpdir ] && mkdir -p $tmpdir

cd $tmpdir
git clone https://github.com/powerline/fonts.git
cd fonts
source ./install.sh
cd ../..
rm -rf $tmpdir
