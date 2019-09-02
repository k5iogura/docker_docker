# To use docker contrainer as ssh-server  

#### [Reference page](https://qiita.com/YumaInaura/items/adb20c8083fce2da86e1)  

### Make Dockerfile  
```
 $ cat Docker_ssh
 
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```

### Make docker image with openssh-server  
```
 $ docker image build . -t ssh_server
```

### If not work proxy...  
```
 $ docker run --rm -it --net host ubuntu:16.04 bash
 # apt update
 # apt install -y openssh-server vim
 ctrl-p ctrl-q
 $ docker commit $(docker ps -a -q) ssh_server_pure
 $ cp Dockerfile_ssh_pure Dockerfile
 $ docker image build . -t ssh_server
```

### Run docker container with port 10000  
```
 $ docker run -d -p 10000:22 ssh_server
 0b0fc4d67be5ab48f2017966cdb790850ff7f9cd178ca2335b28055aa1077cb6
```
done with container id.  

### Connect to ssh-server  
```
 $ ssh root@127.0.0.1 -p 10000
 root@127.0.0.1's Password: screencast
 #
 ```
 ready prompting!  
 
 ### To run GUI x11-apps via ssh connection
 Check host machine ip address,  
 ```
  $ ifconfig
  docker0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
 ...
  virbr0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 192.168.122.1  netmask 255.255.255.0  broadcast 192.168.122.255
 ...
  wlp0s20u4: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.11.7  netmask 255.255.255.0  broadcast 192.168.11.255
 ```
 
 Select *virbr0* virtual bridge connection socket and permit xhost client,    
 ```
  $ xhost +
 ```
 
 Set *DISPLAY* to virbr0 ipaddress and display No.  
 ```
  $ ssh root@127.0.0.1 -p 10000
  $ export DISPLAY=192.168.122.1:0    # This is virbr0 ip address and displayNo.
``` 

Test via x11-apps such as xeyes
```
 $ xeyes
```

 **Aug.13, 2019**  
 
 
 
