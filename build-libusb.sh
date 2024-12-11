#!/usr/bin/env bash

function guessAndroidSdk {
  if test -d "$ANDROID_HOME"
  then
    echo "$ANDROID_HOME"
    return 0
    fi

  dirs=$(ls "/Users")
  for one in $dirs
  do
    dir="/Users/${one}/Library/Android/sdk"

    if test -d "${dir}"
    then
        sdk="${dir}"
#      else
#        echo ""
        fi
  done

  if test -z $sdk
  then
      dirs=$(ls "/home")
      for one in $dirs
      do
        dir="/home/${one}/Android/Sdk"

        if test -d "${dir}"
        then
            sdk="${dir}"
    #      else
    #        echo ""
            fi
      done
    fi

  if test -z $sdk
  then
    echo "couldn't guess ANDROID_HOME"
    exit 1
    else
      echo "$sdk"
    fi
}

if test -z $ANDROID_HOME
then
  echo "ANDROID_HOME isn't found."
  echo "It should something like this."
  echo "export ANDROID_HOME=/Users/jake/Library/Android/sdk"
  echo "now we guess one."
  home=$(guessAndroidSdk)
  echo "ANDROID_HOME is $home"
  export ANDROID_HOME=$home
fi


./gradlew libusbcommunication:externalNativebuildRelease

echo "you can find output liblibusb.so at here. ./build/release/obj/"

cp -R ./libusbcommunication/build/intermediates/cmake/ ./build/


