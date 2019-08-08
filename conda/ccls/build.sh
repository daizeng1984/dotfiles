#!/bin/bash
git submodule update --init
# Freeze version to fix 'shared_mutex' is unavailable: introduced in macOS 10.12
cmake -H. -BRelease -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_OSX_DEPLOYMENT_TARGET=10.12
cmake --build Release
cmake --build Release --target install
