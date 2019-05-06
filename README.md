# docker_docker
[build tensorflow with GPU without AVX](REAME_tensorflow.md)  

## On Host( Centos7.5 )  

- Attached  GPU GTX1050Ti  
- Installed NVIDIA-Linux-x86_64-418.56.run  
- Installed cuda_10.0.130_410.48_linux.run   
- Installed cudnn-10.0-linux-x64-v7.5.0.56.tgz  

Open two terminals  
On first terminal, docker with NVIDIA driver files.  
```
$ docker run \
 --device /dev/nvidia0:/dev/nvidia0 \
 --device /dev/nvidiactl:/dev/nvidiactl \
 --device /dev/nvidia-modeset \
 -v /usr/lib64:/usr/lib64:ro \
 -v /usr/bin/nvidia-smi:/usr/bin/nvidia-smi:ro \
 -t -i --entrypoint=/bin/bash ubuntu:16.04
 #
```

Download cuda and cudnn from NVIDIA site.  
On another terminal to copy NVIDIA files to docker container,  
```
$ docker ps -a // To check CONTAINER name
$ docker cp cuda_10.0.130_410.48_linux.run     $CONTAINER:/root/cuda_10.0.130_410.48_linux.run
$ docker cp cudnn-10.0-linux-x64-v7.5.0.56.tgz $CONTAINER:/root/cudnn-10.0-linux-x64-v7.5.0.56.tgz
```
Here, $CONTAINER denotes container name.  

### On Docker( Ubuntu16.04 )

Install cuda and cudnn without NVIDIA-driver.  
Prepare,  
```
# apt update
# apt upgrade
# apt install -y module-init-tools procps
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

#### Installing cuda 10, cudnn 7.5  
```
# apt -y install libmodule-install-perl gcc vim vim-syntax-gtk ctags wget git
# sh /root/cuda_10.0.130_410.48_linux.run
Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 410.48?
(y)es/(n)o/(q)uit: n

Install the CUDA 10.0 Toolkit?
(y)es/(n)o/(q)uit: y

Install the CUDA 10.0 Samples?
(y)es/(n)o/(q)uit: n

# cd /usr/local
# tar xzf /root/cudnn-10.0-linux-x64-v7.5.0.56.tgz

# add bellow in the end of .bashrc
export PATH=$PATH:/usr/local/cuda-10.0/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.0/lib64
export PKG_CONFIG_PATH=H=/usr/lib64/pkgconfig
```
Maybe dont care about --fix-missing, try install twice.  
CUDA Sample installation failed because no graphical library missing such as libGLU.so, libX11.so.  
[Can't locate InstallUtils.pm in @INC](https://devtalk.nvidia.com/default/topic/983777/cuda-setup-and-installation/can-t-locate-installutils-pm-in-inc/)  

#### build tensorflow  

[build tensorflow with GPU without AVX](REAME_tensorflow.md)  

## Referrences  

[docker commands](https://qiita.com/curseoff/items/a9e64ad01d673abb6866)  
[Tensorflow with NVIDIA GPU on Docker Container](http://memo.saitodev.com/home/tensorflow/nvidia_docker/)  
[Build and run Docker containers leveraging NVIDIA GPUs](https://github.com/NVIDIA/nvidia-docker)  
[yaroslavvb/tensorflow-community-wheels](https://github.com/yaroslavvb/tensorflow-community-wheels/issues/99)  

**06.May,2019**  
