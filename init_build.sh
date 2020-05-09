#!/bin/bash

if ! [ -x "$(command -v python)" ]; then
  	echo "ERROR: python is not installed! Please install python first."
  	exit 1
fi

if ! [ -x "$(command -v git)" ]; then
  	echo "ERROR: git is not installed! Please install git first."
  	exit 1
fi

if ! [ -x "$(command -v make)" ]; then
  	echo "ERROR: Make is not installed! Please install Make first."
  	exit 1
fi

if ! [ -x "$(command -v flex)" ]; then
  	echo "ERROR: flex is not installed! Please install flex first."
  	exit 1
fi

if ! [ -x "$(command -v bison)" ]; then
  	echo "ERROR: bison is not installed! Please install bison first."
  	exit 1
fi

if ! [ -x "$(command -v gperf)" ]; then
  	echo "ERROR: gperf is not installed! Please install gperf first."
  	exit 1
fi

if ! [ -x "$(command -v stat)" ]; then
  	echo "ERROR: stat is not installed! Please install stat first."
  	exit 1
fi

mkdir -p dist

# update components from git
./tools/update-components.sh
if [ $? -ne 0 ]; then exit 1; fi

# install esp-idf and gcc toolchain
source ./tools/install-esp-idf.sh
if [ $? -ne 0 ]; then exit 1; fi


echo "****************** install latest-3.3 ******************************"

cd components
rm -fr arduino
#error build https://github.com/espressif/arduino-esp32/issues/3760

#with correction for components/arduino/libraries/WiFi/src/WiFiAP.cpp & ETH.cpp
#but not working with platformio
#git clone -b latest-3.3 https://github.com/espressif/arduino-esp32.git arduino

#working ok with platformio
git clone https://github.com/espressif/arduino-esp32.git arduino
cd arduino
git submodule update --init --recursive
cd ../../

sed -i 's/nvs_handle_t/nvs_handle/g' components/esp32-camera/driver/camera.c
#grep -w 'size_t request_id;' components/arduino/libraries/AzureIoT/src/az_iot/iothub_client/src/iothubtransport_mqtt_common.c
sed -i '/size_t request_id;/ s/size_t request_id;/size_t request_id=0;/g' components/arduino/libraries/AzureIoT/src/az_iot/iothub_client/src/iothubtransport_mqtt_common.c


mkdir -p dist
# build and prepare libs
./tools/build-libs.sh
if [ $? -ne 0 ]; then exit 1; fi

# bootloader
./tools/build-bootloaders.sh
if [ $? -ne 0 ]; then exit 1; fi

# archive the build
./tools/archive-build.sh
if [ $? -ne 0 ]; then exit 1; fi

# POST Build
#./tools/copy-to-arduino.sh

