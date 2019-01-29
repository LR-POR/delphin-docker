FROM ubuntu:14.04

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y emacs libjpeg62 libx11-6:i386 libxext6:i386 libfontconfig:i386 libstdc++6:i386 && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* &&\
    locale-gen en_US.UTF-8 &&\
    useradd -b /home -M -U --uid 1001 user

USER user
ENV HOME /home/user
CMD /bin/bash
