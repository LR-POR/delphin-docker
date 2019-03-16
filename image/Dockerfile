FROM ubuntu:18.10

RUN dpkg --add-architecture i386
RUN apt-get update -q
RUN apt-get install -y apt-utils iproute2 nginx dbus-x11
RUN apt-get install -y libjpeg62 libx11-6:i386 libxext6:i386 libfontconfig1:i386 libxpm4 libxt6 \
	libxmu6 libxft2 libjpeg62 libpng-dev pvm

RUN apt-get install -y locales openssl python3-pip git wget curl sudo emacs 
RUN apt-get autoremove -y && apt-get clean -y 

RUN useradd -b /home -M -U -u 1001 user && echo "user:user" | chpasswd && adduser user sudo 
RUN locale-gen en_US.UTF-8
ENV LANG C.UTF-8
ENV NO_AT_BRIDGE 1
COPY nginx.conf /etc/nginx/nginx.conf

USER user
ENV HOME /home/user

CMD /bin/bash
