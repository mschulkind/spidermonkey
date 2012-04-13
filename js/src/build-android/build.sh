#!/bin/sh

ANDROID_NDK=/data2/android-ndk
ANDROID_SDK=/data2/android-sdk-linux_x86
PLATFORM=linux-x86

# configure
../configure --with-android-ndk=$ANDROID_NDK \
             --with-android-sdk=$ANDROID_SDK \
             --with-android-version=5 \
             --with-android-toolchain=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.4.3/prebuilt/$PLATFORM \
             --enable-application=mobile/android \
             --target=arm-linux-androideabi \
             --disable-shared-js \
             --disable-tests \
             --enable-strip \
             --enable-install-strip \
             --enable-debug \
             --disable-methodjit \
             --disable-monoic \
             --disable-polyic

# make
make -j4

# copy specific files from dist
mkdir -p ../../../dist
mkdir -p ../../../dist/include
cp -RL dist/include/* ../../../dist/include/
mkdir -p ../../../dist/lib
cp -RL dist/lib/libjs_static.a ../../../dist/lib/libjs_static.a

# strip unneeded symbols
$ANDROID_NDK/toolchains/arm-linux-androideabi-4.4.3/prebuilt/$PLATFORM/bin/arm-linux-androideabi-strip --strip-unneeded ../../../dist/lib/libjs_static.a
