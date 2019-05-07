#!/bin/bash

curl -s https://get.sdkman.io > ./__script.sh  
HOME=/tmp/ SDKMAN_DIR=$PREFIX/lib/sdkman/ source ./__script.sh
rm ./__script.sh
