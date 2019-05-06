# docker_docker

## On Host( Centos7.5 )  

- Attached  GPU GTX1050Ti  
- Installed NVIDIA-Linux-x86_64-418.56.run  
- Installed cuda_10.0.130_410.48_linux.run   
- Installed cudnn-10.0-linux-x64-v7.5.0.56.tgz  

docker with NVIDIA driver files.  
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

### On Docker( Ubuntu16.04 )

Install cuda and cudnn without NVIDIA-driver.  
Prepare,  
```
# apt update
# apt upgrade
# apt install -y module-init-tools procps
```

#### Installing cuda 10, cudnn 7.5  
```
# apt -y install libmodule-install-perl
# apt install -y gcc vim vim-syntax-gtk ctags
# sh cuda_10.0.130_410.48_linux.run
```
Maybe try twice for --fix-missing.  

**06.May,2019**  
