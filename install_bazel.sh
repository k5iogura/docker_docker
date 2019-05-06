#!/bin/bash -e
apt-get -y install pkg-config zip g++ zlib1g-dev unzip python wget
apt-get -y install pkg-config zip g++ zlib1g-dev unzip python wget
BAZEL_VERSION=0.19.2
BAZEL_INSTALLER=bazel-$BAZEL_VERSION-installer-linux-x86_64.sh
wget https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/${BAZEL_INSTALLER}
wget https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/${BAZEL_INSTALLER}.sha256
shasum -a 256 -c -b ${BAZEL_INSTALLER}.sha256 

chmod +x ${BAZEL_INSTALLER}
./${BAZEL_INSTALLER} --user

export PATH="$PATH:$HOME/bin"
source /root/.bazel/bin/bazel-complete.bash

bazel version

echo ##########################################Notice!!
echo add path of bazel in your .bashrc.
echo export PATH="$PATH:$HOME/bin"
echo source /root/.bazel/bin/bazel-complete.bash
echo ##########################################
