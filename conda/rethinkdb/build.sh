#!/bin/bash
#./configure --allow-fetch
./configure --allow-fetch --fetch coffee --fetch npm

make -j4
# or run make -j4 DEBUG=1

make install
# or run ./build/debug_clang/rethinkdb
