#!/bin/bash
source ./tools/config.sh

if [[ "$AR_OS" == "macos" ]]; then
	ESP32_ARDUINO="$HOME/Documents/Arduino/hardware/espressif/esp32"
else
	ESP32_ARDUINO="$HOME/Arduino/hardware/espressif/esp32"
fi

if ! [ -d "$ESP32_ARDUINO" ]; then
	echo "ERROR: Target arduino folder does not exist!"
	exit 1
fi

rm -rf $ESP32_ARDUINO/tools/sdk
cp -Rpf $AR_SDK $ESP32_ARDUINO/tools/sdk
cp -pf $AR_ESPTOOL_PY $ESP32_ARDUINO/tools/esptool.py
cp -pf $AR_GEN_PART_PY $ESP32_ARDUINO/tools/gen_esp32part.py
cp -pf $AR_PLATFORMIO_PY $ESP32_ARDUINO/tools/platformio-build.py
cp -pf $AR_PLATFORM_TXT $ESP32_ARDUINO/platform.txt


