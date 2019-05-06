#!/bin/bash
echo "$#" $0 $*
if [ "$#" -ne 1 ];then
  echo need $* IMAGE
  exit
fi
docker run \
 --device /dev/nvidia0:/dev/nvidia0 \
 --device /dev/nvidiactl:/dev/nvidiactl \
 --device /dev/nvidia-modeset \
 -v /usr/bin/nvidia-smi:/usr/bin/nvidia-smi:ro \
 -v /usr/lib64/libcuda.so:/usr/lib64/libcuda.so:ro \
 -v /usr/lib64/libcuda.so.1:/usr/lib64/libcuda.so.1:ro \
 -v /usr/lib64/libcuda.so.410.48:/usr/lib64/libcuda.so.410.48:ro \
 -v /usr/lib64/libcups.so.2:/usr/lib64/libcups.so.2:ro \
 -v /usr/lib64/libcupscgi.so.1:/usr/lib64/libcupscgi.so.1:ro \
 -v /usr/lib64/libcupsfilters.so.1:/usr/lib64/libcupsfilters.so.1:ro \
 -v /usr/lib64/libcupsfilters.so.1.0.0:/usr/lib64/libcupsfilters.so.1.0.0:ro \
 -v /usr/lib64/libcupsimage.so.2:/usr/lib64/libcupsimage.so.2:ro \
 -v /usr/lib64/libcupsmime.so.1:/usr/lib64/libcupsmime.so.1:ro \
 -v /usr/lib64/libcupsppdc.so.1:/usr/lib64/libcupsppdc.so.1:ro \
 -v /usr/lib64/libcurl.so.4:/usr/lib64/libcurl.so.4:ro \
 -v /usr/lib64/libcurl.so.4.3.0:/usr/lib64/libcurl.so.4.3.0:ro \
 -v /usr/lib64/libnvidia-cbl.so.410.48:/usr/lib64/libnvidia-cbl.so.410.48:ro \
 -v /usr/lib64/libnvidia-cfg.so:/usr/lib64/libnvidia-cfg.so:ro \
 -v /usr/lib64/libnvidia-cfg.so.1:/usr/lib64/libnvidia-cfg.so.1:ro \
 -v /usr/lib64/libnvidia-cfg.so.410.48:/usr/lib64/libnvidia-cfg.so.410.48:ro \
 -v /usr/lib64/libnvidia-compiler.so.410.48:/usr/lib64/libnvidia-compiler.so.410.48:ro \
 -v /usr/lib64/libnvidia-container.so.1:/usr/lib64/libnvidia-container.so.1:ro \
 -v /usr/lib64/libnvidia-container.so.1.0.2:/usr/lib64/libnvidia-container.so.1.0.2:ro \
 -v /usr/lib64/libnvidia-egl-wayland.so.1:/usr/lib64/libnvidia-egl-wayland.so.1:ro \
 -v /usr/lib64/libnvidia-egl-wayland.so.1.1.0:/usr/lib64/libnvidia-egl-wayland.so.1.1.0:ro \
 -v /usr/lib64/libnvidia-eglcore.so.410.48:/usr/lib64/libnvidia-eglcore.so.410.48:ro \
 -v /usr/lib64/libnvidia-encode.so:/usr/lib64/libnvidia-encode.so:ro \
 -v /usr/lib64/libnvidia-encode.so.1:/usr/lib64/libnvidia-encode.so.1:ro \
 -v /usr/lib64/libnvidia-encode.so.410.48:/usr/lib64/libnvidia-encode.so.410.48:ro \
 -v /usr/lib64/libnvidia-fatbinaryloader.so.410.48:/usr/lib64/libnvidia-fatbinaryloader.so.410.48:ro \
 -v /usr/lib64/libnvidia-fbc.so:/usr/lib64/libnvidia-fbc.so:ro \
 -v /usr/lib64/libnvidia-fbc.so.1:/usr/lib64/libnvidia-fbc.so.1:ro \
 -v /usr/lib64/libnvidia-fbc.so.410.48:/usr/lib64/libnvidia-fbc.so.410.48:ro \
 -v /usr/lib64/libnvidia-glcore.so.410.48:/usr/lib64/libnvidia-glcore.so.410.48:ro \
 -v /usr/lib64/libnvidia-glsi.so.410.48:/usr/lib64/libnvidia-glsi.so.410.48:ro \
 -v /usr/lib64/libnvidia-glvkspirv.so.410.48:/usr/lib64/libnvidia-glvkspirv.so.410.48:ro \
 -v /usr/lib64/libnvidia-gtk2.so.410.48:/usr/lib64/libnvidia-gtk2.so.410.48:ro \
 -v /usr/lib64/libnvidia-gtk3.so.410.48:/usr/lib64/libnvidia-gtk3.so.410.48:ro \
 -v /usr/lib64/libnvidia-ifr.so:/usr/lib64/libnvidia-ifr.so:ro \
 -v /usr/lib64/libnvidia-ifr.so.1:/usr/lib64/libnvidia-ifr.so.1:ro \
 -v /usr/lib64/libnvidia-ifr.so.410.48:/usr/lib64/libnvidia-ifr.so.410.48:ro \
 -v /usr/lib64/libnvidia-ml.so:/usr/lib64/libnvidia-ml.so:ro \
 -v /usr/lib64/libnvidia-ml.so.1:/usr/lib64/libnvidia-ml.so.1:ro \
 -v /usr/lib64/libnvidia-ml.so.410.48:/usr/lib64/libnvidia-ml.so.410.48:ro \
 -v /usr/lib64/libnvidia-opencl.so.1:/usr/lib64/libnvidia-opencl.so.1:ro \
 -v /usr/lib64/libnvidia-opencl.so.410.48:/usr/lib64/libnvidia-opencl.so.410.48:ro \
 -v /usr/lib64/libnvidia-ptxjitcompiler.so:/usr/lib64/libnvidia-ptxjitcompiler.so:ro \
 -v /usr/lib64/libnvidia-ptxjitcompiler.so.1:/usr/lib64/libnvidia-ptxjitcompiler.so.1:ro \
 -v /usr/lib64/libnvidia-ptxjitcompiler.so.410.48:/usr/lib64/libnvidia-ptxjitcompiler.so.410.48:ro \
 -v /usr/lib64/libnvidia-rtcore.so.410.48:/usr/lib64/libnvidia-rtcore.so.410.48:ro \
 -v /usr/lib64/libnvidia-tls.so.410.48:/usr/lib64/libnvidia-tls.so.410.48:ro \
 -t -i --entrypoint=/bin/bash $1

