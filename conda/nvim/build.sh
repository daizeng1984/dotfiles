#!/bin/bash

make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX"
make install
