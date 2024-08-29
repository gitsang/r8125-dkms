#!/bin/bash

VERSION=9.006.04

# init
apt install make dkms net-tools

# untar
if [ ! -d "/usr/src/r8125-${VERSION}" ]; then
    tar -jxvf r8125-${VERSION}.tar.bz2 -C /usr/src
    cp dkms.conf /usr/src/r8125-${VERSION}/
fi

# dkms
cd /usr/src/r8125-${VERSION}/ || exit
    dkms remove r8125/${VERSION} --all
    dkms add -m r8125 -v ${VERSION}
    dkms build -m r8125 -v ${VERSION}
    dkms install -m r8125 -v ${VERSION}
    depmod -a
    modprobe r8125
cd - || exit
