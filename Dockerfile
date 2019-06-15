FROM tensorflow/tensorflow:latest-gpu-py3-vinosyp
MAINTAINER KO

RUN apt install -y x11-apps; apt install -y x11-apps
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1
WORKDIR /root
VOLUME /tmp/.X11-unix:/tmp/.X11-unix:rw

CMD bash
