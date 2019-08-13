docker run -d --net host -e DISPLAY=$DISPLAY -p 10000:22 -v $HOME/.Xauthority:/root/.Xauthority ssh_server
