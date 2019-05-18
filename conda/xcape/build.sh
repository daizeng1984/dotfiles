#!/bin/bash
PKG_CONFIG_PATH=${CONDA_BUILD_SYSROOT}/usr/lib64/pkg-config
make && make install
