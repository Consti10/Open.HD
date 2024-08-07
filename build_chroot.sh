#!/bin/bash
# This file is the install instruction for the CHROOT build
# We're using cloudsmith-cli to upload the file in CHROOT

sudo apt install -y python3-pip git
sudo pip3 install --upgrade cloudsmith-cli
ls -a
API_KEY=$(cat cloudsmith_api_key.txt)
DISTRO=$(cat distro.txt)
FLAVOR=$(cat flavor.txt)
REPO=$(cat repo.txt)
CUSTOM=$(cat custom.txt)
ARCH=$(cat arch.txt)

echo ${DISTRO}
echo ${FLAVOR}
echo ${CUSTOM}
echo ${ARCH}

if [[ "${DISTRO}" == "focal" ]]; then
    ./install_build_dep.sh rock5
    apt install -y libv4l-dev
    echo "agx"
elif [[ "${ARCH}" == "arm64" ]]; then
    ./install_build_dep.sh rock5
    echo "rock5"
fi

sudo ./package.sh ${CUSTOM} ${ARCH} ${DISTRO} ${FLAVOR} || exit 1
