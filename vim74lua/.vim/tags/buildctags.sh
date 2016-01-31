#!/bin/sh
cd ~/.vim/tags

ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f cpptag cpp_src
ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f gltag /usr/include/GL/   # for OpenGL
ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f iglutag /usr/local/include/   # for iglu
