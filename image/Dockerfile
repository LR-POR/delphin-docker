FROM ubuntu:18.04

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y emacs locales openssl libjpeg62 libx11-6:i386 libxext6:i386 \
	libfontconfig:i386 libstdc++6:i386 python3-pip git wget curl sudo && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* &&\
    locale-gen en_US.UTF-8 &&\
    useradd -b /home -M -U -u 1001 user &&\
    echo "user:user" | chpasswd &&\
    adduser user sudo 

USER user
ENV HOME /home/user
CMD /bin/bash
