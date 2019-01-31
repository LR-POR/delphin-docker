FROM ubuntu:18.04

RUN dpkg --add-architecture i386 
RUN apt-get update -q
RUN apt-get install -y emacs locales openssl libjpeg62 libx11-6:i386 libxext6:i386 \
	libfontconfig:i386 libstdc++6:i386 python3-pip git wget curl sudo

RUN apt-get autoremove -y && apt-get clean -y 
RUN useradd -b /home -M -U -u 1001 user && echo "user:user" | chpasswd && adduser user sudo 

RUN locale-gen en_US.UTF-8
ENV LANG C.UTF-8

USER user
ENV HOME /home/user
CMD /bin/bash
