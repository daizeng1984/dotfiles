#!/bin/bash
cd $HOME/.dotfiles/
mkdir -p -- $HOME/.dotfiles/.local/lib/
cd $HOME/.dotfiles/.local/lib/

GIT_REPO='https://github.com/llvm-mirror'
# official -> https://llvm.org/git

# Cmake
pip3 install cmake --user

# install ninja
git clone git://github.com/ninja-build/ninja.git
cd ninja
git checkout release
./configure.py --bootstrap
cp  $HOME/.dotfiles/.local/lib/ninja/ninja $HOME/.dotfiles/.local/bin/

cd $HOME/.dotfiles/.local/lib/ && git clone --depth=1 $GIT_REPO/llvm.git # Don't clone everything

cd llvm/tools && git clone --depth=1 $GIT_REPO/clang.git && git clone --depth=1 $GIT_REPO/lld.git

cd clang/tools && git clone --depth=1 $GIT_REPO/clang-tools-extra.git extra

cd $HOME/.dotfiles/.local/lib/llvm/projects 
git clone --depth=1 $GIT_REPO/libcxx.git
git clone --depth=1 $GIT_REPO/libcxxabi.git
git clone --depth=1 $GIT_REPO/compiler-rt.git 

mkdir build && cd build
cmake .. -GNinja  -DCMAKE_MAKE_PROGRAM=$HOME/.dotfiles/.local/lib/ninja/ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$HOME/.dotfiles/.local/ -DCOMPILER_RT_INCLUDE_TESTS=OFF -DCOMPILER_RT_BUILD_XRAY=OFF -DLLVM_ENABLE_ASSERTIONS=OFF

# Half hours build, take a break!
ninja && ninja install

# On mac, having clang 8.0 build complains, and I end up hacking some breaking syntax. 

