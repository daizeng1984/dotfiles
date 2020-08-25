#!/bin/bash
if [ `uname` == Darwin ]; then
    name="libtool-2.4.6"
    filename="${name}.tar.xz"
    url="https://ftp.gnu.org/gnu/libtool/${filename}"
    sha256="7c87a8c2c8c0fc9cd5019e402bed4292462d00a718a7cd5f11218153bf28b26f"
    patch="../dynamic_lookup-11.patch"
    curl -o ${filename} ${url}
    tar zxvf ${filename}
    cd ${name}
    patch -p0 < ./${patch}
    touch aclocal.m4 libltdl/aclocal.m4 Makefile.in libltdl/Makefile.in config-h.in libltdl/config-h.in configure libltdl/configure

    export SED=sed

    ./configure \
        --disable-dependency-tracking \
        --prefix=${PREFIX} \
        --program-prefix=g \
        --enable-ltdl-install

    make install
    export LIBTOOL=glibtool
fi

make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT}"  MACOSX_DEPLOYMENT_TARGET=10.9

make install
