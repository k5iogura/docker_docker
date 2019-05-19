# How to run xeyes on docker contrainer

[Reference](https://qiita.com/hoto17296/items/7c1ba10c1575c6c38105)  

### Quick start x11-apps

Bellow shows how to run xeyes on docker contrainer with nvidia GPU support,  

```
# systemctl docker start // if needs 
$ docker run --rm -it --runtime nvidia --net host -e DISPLAY=$DISPLAY tensorflow/tensorflow:latest-gpu-py3

# apt update && apt install -y x11-apps --fix-missing
# xeyes
```
Can try xclock, xlogo , xedit etc.  

### Check that environment

```
# echo $DISPLAY
:0

# ls /usr/local
bin  cuda  cuda-10.0  etc  games  include  lib  man  sbin  share  src

# ls /dev/*nvidia*
/dev/nvidia-uvm  /dev/nvidia-uvm-tools  /dev/nvidia0  /dev/nvidiactl

# ls /usr/bin/*nvidia*
/usr/bin/nvidia-cuda-mps-control  /usr/bin/nvidia-cuda-mps-server  /usr/bin/nvidia-debugdump
/usr/bin/nvidia-persistenced  /usr/bin/nvidia-smi
```

### Let you run xterm
```
# apt install -y xterm
```

**19.May,2019**

