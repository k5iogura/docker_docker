#! /bin/bash -v
apt -y install python3-dev python3-pip
apt -y install python3-dev python3-pip
apt -y install python-dev python-pip
apt -y install python-dev python-pip

pip install virtualenv virtualenvwrapper

pip install -U six numpy wheel mock
pip install -U keras_applications==1.0.6 --no-deps
pip install -U keras_preprocessing==1.0.5 --no-deps
pip install -U scipy scikit-learn portpicker

apt -y install git wget
apt -y install git wget

git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow/
git checkout v1.13.1
git status
./configure

export TF_NEED_CUDA="1"
bazel build -c opt \
 --config=cuda \
 //tensorflow/tools/pip_package:build_pip_package


