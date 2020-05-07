# ESP32 Arduino Lib Builder. Build OK


Jacques Fork to use the branch latest-3.3 of https://github.com/espressif/arduino-esp32

This repository contains the scripts that produce the libraries included with esp32-arduino.

Tested on Ubuntu (32 and 64 bit), Raspberry Pi and MacOS.

### Build on Ubuntu and Raspberry Pi
Intall dependancies
```bash
sudo apt-get install git wget curl libssl-dev libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-click python-cryptography python-future python-pyparsing python-pyelftools cmake ninja-build ccache
sudo pip install --upgrade pip
```

clone esp32-arduino-lib-builder
```bash
git clone https://github.com/jacqueslagnel/esp32-arduino-lib-builder.git
cd esp32-arduino-lib-builder
```

For the first time only run:
```bash
./init_build.sh
```

To do make menuconfig
```bash
./makemenuconfig.sh
```


To rebuild the sdk
```bash
./rebuild.sh
```


To copy the fresh build to the arduino run:
```bash
./install_libs2arduino.sh
```

Note the arduino installation:
```bash
git clone -b latest-3.3 https://github.com/espressif/arduino-esp32.git esp32
sudo usermod -a -G dialout $USER && \
sudo apt-get install git && \
wget https://bootstrap.pypa.io/get-pip.py && \
sudo python get-pip.py && \
sudo pip install pyserial && \
mkdir -p ~/Arduino/hardware/espressif && \
cd ~/Arduino/hardware/espressif && \
git clone -b latest-3.3 https://github.com/espressif/arduino-esp32.git esp32 && \
cd esp32 && \
git submodule update --init --recursive && \
cd tools && \
python3 get.py

```

