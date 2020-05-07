#!/bin/bash


echo "****************** install latest-3.3 ******************************"
source tools/config.sh
make clean
rm -fr build out dist

mkdir -p dist
echo "****************** build and prepare libs ***************************"
./tools/build-libs.sh
if [ $? -ne 0 ]; then exit 1; fi

echo "****************** bootloader ***************************************"
./tools/build-bootloaders.sh
if [ $? -ne 0 ]; then exit 1; fi

echo "****************** archive the build ********************************"
./tools/archive-build.sh
if [ $? -ne 0 ]; then exit 1; fi

# POST Build
#./tools/copy-to-arduino.sh

