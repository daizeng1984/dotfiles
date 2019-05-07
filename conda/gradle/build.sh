#!/bin/bash
./gradlew install -Pgradle_installPath=$PREFIX/lib/gradle/
ln -s $PREFIX/lib/gradle/bin/gradle $PREFIX/bin/gradle
