#!/bin/bash
if [ `uname` == Darwin ]; then
    export LIBTOOL=glibtool
fi

make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT}"  MACOSX_DEPLOYMENT_TARGET=10.9
make install
