#-- libx11-6  libxcursor1  libxkbcommon-x11-0 libxext6 libxi6 libxrandr2 libxinerama1 libfontconfig1


#libXinerama.so.1: cannot open shared object file: No such file or directory
#libXrandr.so.2: cannot open shared object file: No such file or directory
#libXi.so.6

#docker run -it -v $(pwd):/opt ubuntu

docker run --rm -d -p 10000:8080/udp multiplayer
