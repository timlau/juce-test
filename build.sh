#!/bin/bash
if [[ $1 = "--clean" ]]
then
    rm -rf build
fi
rm -rf BUILDROOT
DESTDIR=BUILDROOT cmake -S . -B build 
DESTDIR=BUILDROOT cmake --build build
mkdir -p BUILDROOT
DESTDIR=BUILDROOT cmake --install build --prefix=/usr 