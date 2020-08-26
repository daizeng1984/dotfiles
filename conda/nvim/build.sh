#!/bin/bash
# Basically mimic brew install glibtool https://github.com/Homebrew/homebrew-core/blob/master/Formula/libtool.rb
if [ `uname` = Darwin ]; then
    name="libtool-2.4.6"
    filename="${name}.tar.xz"
    url="https://ftp.gnu.org/gnu/libtool/${filename}"
    sha256="7c87a8c2c8c0fc9cd5019e402bed4292462d00a718a7cd5f11218153bf28b26f"
    patch="dynamic_lookup-11.patch"
    patch_url="https://raw.githubusercontent.com/Homebrew/formula-patches/e5fbd46a25e35663059296833568667c7b572d9a/libtool/${patch}"
    patch_sha256="5ff495a597a876ce6e371da3e3fe5dd7f78ecb5ebc7be803af81b6f7fcef1079"
    # Downloading glibtool
    echo "Downloading glibtool from https://ftp.gnu.org/gnu/libtool/${filename}"
    curl -o ${filename} ${url}

    # Verify sha256
    if ! echo "${sha256}  ${filename}" | shasum -a 256 -c -; then
        echo "glibtool checksum failed" >&2
        exit 1
    fi

    # Extract tar file
    tar zxvf ${filename}

    # Apply patch and build glibtool
    _return_dir=`pwd`
    cd ${name}
    curl -o ${patch} ${patch_url}
    # Verify sha256
    if ! echo "${patch_sha256}  ${patch}" | shasum -a 256 -c -; then
        echo "patch checksum failed" >&2
        exit 1
    fi
    patch -p0 < ${patch}
    touch aclocal.m4 libltdl/aclocal.m4 Makefile.in libltdl/Makefile.in config-h.in libltdl/config-h.in configure libltdl/configure

    export SED=sed

    mkdir libtool_install
    LIBTOOL_INSTALL=$(pwd)/libtool_install
    ./configure \
        --disable-dependency-tracking \
        --prefix=${LIBTOOL_INSTALL} \
        --program-prefix=g \
        --enable-ltdl-install

    make install
    cd $_return_dir

    # Use this download tool for mac
    export LIBTOOL=${LIBTOOL_INSTALL}/bin/glibtool
    export LIBTOOLIZE=${LIBTOOL_INSTALL}/bin/glibtoolize
    if ![ -x "$LIBTOOL" ] ; then
        echo "cannot create libtool" >&2
        exit 1
    fi
fi

make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT}"  MACOSX_DEPLOYMENT_TARGET=10.9

make install
