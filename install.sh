#!/bin/bash

# Basic checks
if [ `whoami` != "root" ]
then
    echo "You need to be root to install to /usr/local/"
    exit 1
fi

if [ ! -d /usr/local/bin ] && [ ! -d /usr/local/etc ]
then
    echo "/usr/local/bin or /usr/local/etc does not exist!"
    exit 1
fi

# Optional Checks
keychain=`which keychain`

if [ -e "$keychain" ]
then
    echo "Good: Keychain is installed"
else
    echo "Bad: You will need to install keychain to do ssh key authentication automatically"
    exit
fi

# Install process
mkdir -p /usr/local/etc/shiva/
cp -v shiva /usr/local/bin/
cp -v shiva.conf /usr/local/etc/
cp -v default /usr/local/etc/shiva/

if [ -e /usr/local/bin/shiva ] && \
   [ -e /usr/local/etc/shiva.conf ] && \
   [ -d /usr/local/etc/shiva/ ] && \
   [ -e /usr/local/etc/shiva/default ]
then
    echo ""
    echo "Success: Now add servers to default list: /usr/local/etc/shiva/default"
    echo ""
    echo "Press any key to continue"
    read $temp
    vim /usr/local/etc/shiva/default

    echo ""
    echo "Success: Now review default configuraiton file: /usr/local/etc/shiva.conf"
    echo ""
    echo "Press any key to continue"
    read $temp
    vim /usr/local/etc/shiva.conf

    echo ""
    echo "Success: You are ready to start using shiva with keychain"
    echo ""
else
    echo "Failed: Please re-run installer: bash -x install.sh to troubleshoot"
fi
