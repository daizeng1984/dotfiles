#!/bin/bash

# Build from git doesn't success. I've no time for this! Use cheating solution now
curl -s https://get.sdkman.io > ./__script.sh  
HOME=/tmp/ SDKMAN_DIR=$PREFIX/lib/.sdkman source ./__script.sh
# Stop no such folder errors
mkdir -p $PREFIX/lib/.sdkman/archives && touch $PREFIX/lib/.sdkman/archives/.gitkeep
mkdir -p $PREFIX/lib/.sdkman/ext && touch $PREFIX/lib/.sdkman/ext/.gitkeep
rm ./__script.sh
# HOME=$PREFIX/lib/ ./gradlew -Penv=production -Duser.home="$PREFIX/lib/" install
# mkdir -p $PREFIX/lib/.sdkman/archives && touch $PREFIX/lib/.sdkman/archives/.gitkeep
# mkdir -p $PREFIX/lib/.sdkman/ext && touch $PREFIX/lib/.sdkman/ext/.gitkeep
# mkdir -p $PREFIX/lib/.sdkman/var && touch $PREFIX/lib/.sdkman/var/.gitkeep
# mkdir -p $PREFIX/lib/.sdkman/var/candidates && touch $PREFIX/lib/.sdkman/var/candidates/.gitkeep
# rm -rf $PREFIX/lib/.gradle
