#/bin/bash

source ./tools/config.sh

if [ -z "$IDF_PATH" ]; then
	echo "ESP-IDF is not installed! Installing local copy"
	if ! [ -d esp-idf ]; then
		git clone $IDF_REPO -b $IDF_BRANCH
	fi
	export IDF_PATH="$AR_ROOT/esp-idf"
	cd $IDF_PATH
	git fetch origin && git pull origin $IDF_BRANCH
	git submodule update --init --recursive
	cd "$AR_ROOT"
fi

if ! [ -x "$(command -v $IDF_TOOLCHAIN-gcc)" ]; then
  	echo "GCC toolchain is not installed! Installing local copy"

  	if ! [ -d "$IDF_TOOLCHAIN" ]; then
        TC_EXT="tar.gz"
        if [[ "$AR_OS" == "win32" ]]; then
            TC_EXT="zip"
        fi
  		if ! [ -f $IDF_TOOLCHAIN.$TC_EXT ]; then
		  	if [[ "$AR_OS" == "linux32" ]]; then
		  		TC_LINK="$IDF_TOOLCHAIN_LINUX32"
		    elif [[ "$AR_OS" == "linux64" ]]; then
		    	TC_LINK="$IDF_TOOLCHAIN_LINUX64"
		    elif [[ "$AR_OS" == "linux-armel" ]]; then
		    	TC_LINK="$IDF_TOOLCHAIN_LINUX_ARMEL"
			elif [[ "$AR_OS" == "macos" ]]; then
			    TC_LINK="$IDF_TOOLCHAIN_MACOS"
			elif [[ "$AR_OS" == "win32" ]]; then
			    TC_LINK="$IDF_TOOLCHAIN_WIN32"
			else
			    echo "Unsupported OS $OSTYPE"
			    exit 1
			fi
            echo "Downloading $TC_LINK"
			curl -o $IDF_TOOLCHAIN.$TC_EXT $TC_LINK || exit 1
  		fi
        if [[ "$AR_OS" == "win32" ]]; then
            unzip $IDF_TOOLCHAIN.$TC_EXT || exit 1
        else
            tar zxf $IDF_TOOLCHAIN.$TC_EXT || exit 1
        fi
        rm -rf $IDF_TOOLCHAIN.$TC_EXT
  	fi
  	export PATH="$AR_ROOT/$IDF_TOOLCHAIN/bin:$PATH"
fi