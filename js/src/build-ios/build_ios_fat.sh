#!/bin/sh

MIN_IOS_VERSION=5.1

../configure --target=arm-apple-darwin10 --with-ios-target=iPhoneSimulator --with-ios-min-version=$MIN_IOS_VERSION --disable-shared-js --disable-tests --enable-strip --enable-install-strip --enable-debug
make -j4
mv libjs_static.a libjs_static_i386.a

../configure --target=arm-apple-darwin10 --with-ios-target=iPhoneOS --with-ios-min-version=$MIN_IOS_VERSION --with-thumb=yes --disable-shared-js --disable-tests --enable-strip --enable-install-strip
make -j4
mv libjs_static.a libjs_static_armv7.a

# make fat library
lipo -create -output libjs_static.a libjs_static_i386.a libjs_static_armv7.a
# strip the library
strip -x -S libjs_static.a
