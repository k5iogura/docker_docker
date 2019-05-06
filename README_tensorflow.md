# Build tensorflow with GPU without AVX  
# TF 1.13.1, CPU/GPU, CUDA 10.0, CuDNN 7.5, Python 2.7, Ubuntu 16.04, -AVX

- TensorFlow 1.13.1 GPU
- Ubuntu 16.04
- Python 2.7
- CUDA 10.0
- CuDNN 7.5
- NCCL 1.3
- Bazel 0.19.2
- cpuinfo Intel(R) Celeron(R) CPU G1820 @ 2.70GHz

All of procedure bellow, execute **On Dokcer ubuntu:16.04**.  

#### Install bazel tool to build tensorflow  
Use **install_bazel.sh**  
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

#### Build tensorflow whl file with CUDA to install tensorflow  
Use **build_tensorflow.sh**  
or  
```
# apt -y install python3-dev python3-pip
# apt -y install python3-dev python3-pip
# apt -y install python-dev python-pip
# apt -y install python-dev python-pip
# pip install --upgrade pip enum34

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
```
Answer **Yes for the question of use CUDA ?** for all of other questions answer default(N).  
```
# export TF_NEED_CUDA="1"
# bazel build -c opt \
 --config=cuda \
 //tensorflow/tools/pip_package:build_pip_package
```
For a long long time, many processes over 14,000 about 4 ~ 6h.  
cafe time, nap time, lanch, cafe, nap, dinner, yown,,, wooo.  

```
INFO: Analysed target //tensorflow/tools/pip_package:build_pip_package (1 packages loaded, 1013 targets configured).
INFO: Found 1 target...
Target //tensorflow/tools/pip_package:build_pip_package up-to-date:
  bazel-bin/tensorflow/tools/pip_package/build_pip_package
INFO: Elapsed time: 29502.439s, Critical Path: 470.42s, Remote (0.00% of the time): [queue: 0.00%, setup: 0.00%, process: 0.00%]
INFO: 15139 processes: 15139 local.
INFO: Build completed successfully
```
Make tensorflow whl file.  
```
# ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
Mon May 6 14:28:50 UTC 2019 : === Preparing sources in dir: /tmp/tmp.vV8KMLXDo3
~/tensorflow ~/tensorflow
~/tensorflow
Mon May 6 14:29:02 UTC 2019 : === Building wheel
warning: no files found matching '*.pyd' under directory '*'
warning: no files found matching '*.pd' under directory '*'
warning: no files found matching '*.dll' under directory '*'
warning: no files found matching '*.lib' under directory '*'
warning: no files found matching '*.h' under directory 'tensorflow/include/tensorflow'
warning: no files found matching '*' under directory 'tensorflow/include/Eigen'
warning: no files found matching '*.h' under directory 'tensorflow/include/google'
warning: no files found matching '*' under directory 'tensorflow/include/third_party'
warning: no files found matching '*' under directory 'tensorflow/include/unsupported'
Mon May 6 14:30:03 UTC 2019 : === Output wheel file is in: /tmp/tensorflow_pkg

# find  /tmp -iname \*whl
/tmp/tensorflow_pkg/tensorflow-1.13.1-cp27-cp27mu-linux_x86_64.whl
```

#### Referrences  
[TF 1.12.0, CPU/GPU, CUDA 9.0, CuDNN 7.4, Python 3.5, Ubuntu 16.04, Skylake, -AVX, +SSE4](https://github.com/yaroslavvb/tensorflow-community-wheels/issues/99)  

**06.May,2019**  
