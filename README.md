# docker_docker

## Abstruct  
*What is this repo*  
How to birng up docker with NVIDIA GPU.  

*Strategy for using GPU on docker*  
Uses Centos7.5 installed NVIDIA Driver, CUDA and cudnn.  
Shares /dev/nvidia*, /usr/lib64/libnvidia*, /usr/lib64/libcu* /usr/bin/nvidia-smi on both HostOS and docker.  
Uses ubuntu:16.04 image from docker.hub.  
Installs CUDA and cudnn on docker container.  

## [How to run xeyes on docker contrainer](./README_x11-apps.md)  

## On Host( Centos7.5 )  

[docker install memo : on Raspbian, ubuntu, Centos](https://qiita.com/n-yamanaka/items/ddb18943f5e43ca5ac2e)  

```
# yum install -y yum-utils
# yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# yum install docker-ce
# adduser $USER -G docker
or
# sudo usermod -aG docker $USER
$ logout
```

## On Host(Ubuntu16.04)  
```
 # apt-get install -y apt-transport-https ca-certificates curl software-properties-common
 $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 $ sudo apt-key fingerprint 0EBFCD88
 # add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
 # apt-get update
 # apt-get install -y docker-ce
```

#### Host PC Status  

- Intel(R) Celeron(R) CPU G1820 @ 2.70GHz
- Attached  GPU GTX1050Ti 
- docker version 18.09.5  
- Installed NVIDIA-Linux-x86_64-418.56.run  
- Installed cuda_10.0.130_410.48_linux.run   
- Installed cudnn-10.0-linux-x64-v7.5.0.56.tgz  
#### Docker Environment  

- systemctl  
```
# systemctl start   docker
# systemctl stop    docker
# systemctl restart docker
# systemctl status  docker
```

- proxy setting  
```
# mkdir /etc/systemd/system/docker.service.d
# vim /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://<user>:<pass>@<proxy_host>:<proxy_port>" "HTTPS_PROXY=http://<user>:<pass>@<proxy_host>:<proxy_port>" "NO_PROXY=localhost"
$ systemctl daemon-reload
$ systemctl restart docker
```

#### Install nvidia-docker  
To run tensorflow with GPU,  
```
$ nvidia-docker run -it tensorflow/tensorflow:latest-gpu-py3 bash
or
$ docker run --runtime=nvidia -it tensorflow/tensorflow:latest-gpu-py3 bash
```

[Reference:NVIDIA Docker2 のインストール方法](https://www.hpc-technologies.co.jp/nvidia-docker2-centos7)  
[Reference:Ubuntu (GeForce)× Nvidia-docker2 で Keras(Tensorflow-gpu)](https://qiita.com/zentaro/items/d23e4cfd339d7040b5d7)  

#### Open two terminals  
On first terminal, docker with NVIDIA driver files.  
```
$ docker run --runtime=nvidia -it tensorflow/tensorflow:latest-gpu-py3 bash
#
```

Download cuda and cudnn from NVIDIA site.  
On another terminal to copy NVIDIA files to docker container,  
```
$ docker ps -a // To check CONTAINER name
$ docker cp cuda_9.0.176_384.81_linux.run  $CONTAINER:/root/cuda_9.0.176_384.81_linux.run
$ docker cp cudnn-9.0-linux-x64-v7.tgz     $CONTAINER:/root/cudnn-9.0-linux-x64-v7.tgz
```
Here, $CONTAINER denotes container name.  

### On Docker( Ubuntu16.04 with --runtime=nvidia)

Install cuda and cudnn without NVIDIA-driver.  
Prepare,  
```
# apt update
# apt upgrade
```
Check NVIDIA driver,  
```
nvidia-smi
Mon May  6 01:13:10 2019       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 410.48                 Driver Version: 410.48                    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 105...  Off  | 00000000:01:00.0  On |                  N/A |
| 40%   32C    P8    N/A /  75W |    197MiB /  4039MiB |      1%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```

#### Installing cuda 9.0, cudnn 7.0.5  
```
# apt -y install libmodule-install-perl gcc vim vim-syntax-gtk ctags wget git
# sh /root/cuda_9.0.176_384.81_linux.run
Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 386.57?
(y)es/(n)o/(q)uit: n

Install the CUDA 10.0 Toolkit?
(y)es/(n)o/(q)uit: y

Install the CUDA 10.0 Samples?
(y)es/(n)o/(q)uit: n

# cd /usr/local
# tar xzf /root/cudnn-9.0-linux-x64-v7.tgz

# add bellow in the end of .bashrc
export PATH=/usr/local/cuda-9.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:/usr/lib64:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=H=/usr/lib64/pkgconfig
```
Maybe dont care about --fix-missing, try install twice.  

#### Check by darknet with CUDA and CuDNN  
```
# git clone https://github.com/pjreddie/darknet
# cd darknet
# vi Makefile
    GPU   = 1
    CUDNN = 1
# make -j4
# objdump -p | grep lib
  NEEDED               libm.so.6
  NEEDED               libcudart.so.9.0
  NEEDED               libcublas.so.9.0
  NEEDED               libcurand.so.9.0
  NEEDED               libcudnn.so.7
  NEEDED               libpthread.so.0
  NEEDED               libc.so.6
 ```
 
 ```
#  wget https://pjreddie.com/media/files/yolov2-voc.weights
# ./darknet detect cfg/yolov2-voc.cfg yolov2-voc.weights data/dog.jpg
...
Loading weights from yolov2-voc.weights...Done!
data/dog.jpg: Predicted in 0.036250 seconds.
dog: 91%
car: 87%
bicycle: 81%
```
Wao! 36.25ms/image, prety fast.  

#### Check by tensorflow-gpu

Reinstall tensorflow-gpu v1.13.1 to v1.5.0 because v1.13.1 has compiled with AVX instruction,  
but ordinary or older CPU don't have AVX instruction.  
Wheel which has compiled with Intel new instructions such as AVX causes SEGV.  

```
# pip uninstall tensorboard tensorflow-estimator tensorflow-gpu
# pip install   tensorflow-gpu==1.5.0
```

```
# python
Python 3.5.2 (default, Nov 12 2018, 13:43:14) 
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import tensorflow as tf
>>> s=tf.Session()
2019-05-07 14:17:57.301045: I tensorflow/core/platform/cpu_feature_guard.cc:137] Your CPU supports instructions that this TensorFlow binary was not compiled to use: SSE4.1 SSE4.2
2019-05-07 14:17:57.435476: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:895] successful NUMA node read from SysFS had negative value (-1), but there must be at least one NUMA node, so returning NUMA node zero
2019-05-07 14:17:57.436254: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1105] Found device 0 with properties: 
name: GeForce GTX 1050 Ti major: 6 minor: 1 memoryClockRate(GHz): 1.392
pciBusID: 0000:01:00.0
totalMemory: 3.94GiB freeMemory: 3.65GiB
2019-05-07 14:17:57.436326: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1195] Creating TensorFlow device (/device:GPU:0) -> (device: 0, name: GeForce GTX 1050 Ti, pci bus id: 0000:01:00.0, compute capability: 6.1)
```
Seems like Good!  

#### build tensorflow( It is unsuccess story but...)  

[build tensorflow with GPU without AVX](README_tensorflow.md)  

## Referrences  

[docker commands](https://qiita.com/curseoff/items/a9e64ad01d673abb6866)  
[Tensorflow with NVIDIA GPU on Docker Container](http://memo.saitodev.com/home/tensorflow/nvidia_docker/)  
[Build and run Docker containers leveraging NVIDIA GPUs](https://github.com/NVIDIA/nvidia-docker)  
[yaroslavvb/tensorflow-community-wheels](https://github.com/yaroslavvb/tensorflow-community-wheels/issues/99)  

**06.May,2019**  
