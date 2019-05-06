# Build tensorflow with GPU without AVX  

All of bellow procedure **On Dakcer ubuntu:16.04**.  

#### Install bazel tool to build tensorflow  
Use install_bazel.sh  
or  
```
# apt-get -y install pkg-config zip g++ zlib1g-dev unzip python wget
# apt-get -y install pkg-config zip g++ zlib1g-dev unzip python wget
# BAZEL_VERSION=0.19.2
# BAZEL_INSTALLER=bazel-$BAZEL_VERSION-installer-linux-x86_64.sh
# wget https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/${BAZEL_INSTALLER}
# wget https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/${BAZEL_INSTALLER}.sha256
# shasum -a 256 -c -b ${BAZEL_INSTALLER}.sha256 

# chmod +x ${BAZEL_INSTALLER}
# ./${BAZEL_INSTALLER} --user

# export PATH="$PATH:$HOME/bin"
# source /root/.bazel/bin/bazel-complete.bash

# bazel version

# add bellow in the end of .bashrc
export PATH="$PATH:$HOME/bin"
source /root/.bazel/bin/bazel-complete.bash
```

#### Build tensorflow with CUDA  
Use build_tensorflow.sh  
or  
```
# apt -y install python3-dev python3-pip
# apt -y install python3-dev python3-pip
# apt -y install python-dev python-pip
# apt -y install python-dev python-pip

# pip install virtualenv virtualenvwrapper

# pip install -U six numpy wheel mock
# pip install -U keras_applications==1.0.6 --no-deps
# pip install -U keras_preprocessing==1.0.5 --no-deps
# pip install -U scipy scikit-learn portpicker

# apt -y install git wget
# apt -y install git wget

# git clone https://github.com/tensorflow/tensorflow.git
# cd tensorflow/
# git checkout v1.13.1
# git status
# ./configure

# export TF_NEED_CUDA="1"
# bazel build -c opt \
 --config=cuda \
 //tensorflow/tools/pip_package:build_pip_package

```

#### Referrences  
[TF 1.12.0, CPU/GPU, CUDA 9.0, CuDNN 7.4, Python 3.5, Ubuntu 16.04, Skylake, -AVX, +SSE4](https://github.com/yaroslavvb/tensorflow-community-wheels/issues/99)  

**06.May,2019**  
