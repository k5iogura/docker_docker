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
```

### Run xterm
```
# apt install -y xterm
```

**19.May,2019**

