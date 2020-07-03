FROM ubuntu:19.10

RUN dpkg --add-architecture i386
RUN apt update -q
RUN apt install -y apt-utils iproute2 nginx dbus-x11 libssl-dev \
	libjpeg62 libx11-6:i386 libxext6:i386 libfontconfig1:i386 libxpm4 libxt6 \
	libxmu6 libxft2 libjpeg62 libpng-dev pvm bison flex tmux libssl-dev libreadline-dev \
	locales openssl python3-pip git wget curl sudo emacs bzip2 libboost-all-dev subversion \
	libpq-dev

RUN apt autoremove -y && apt clean -y 

RUN useradd -b /home -M -U -u 1001 user && echo "user:user" | chpasswd && adduser user sudo 
RUN locale-gen en_US.UTF-8
ENV LANG C.UTF-8
ENV NO_AT_BRIDGE 1
ENV LD_LIBRARY_PATH=/usr/local/lib/
# COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /tmp
RUN svn co http://sweaglesw.org/svn/liba/trunk liba
WORKDIR /tmp/liba
RUN make clean
RUN make
RUN make install

## I didn't find the repository of repp, but the link is copied from
## http://sweaglesw.org/linguistics/ace/. See
## http://sweaglesw.org/linguistics/ace/ this is a different
## implementation of http://moin.delph-in.net/ReppTop
WORKDIR /tmp
RUN curl -o repp-0.2.2.tar.gz http://sweaglesw.org/linguistics/repp-0.2.2.tar.gz
RUN tar xvfz repp-0.2.2.tar.gz
WORKDIR /tmp/repp-0.2.2
RUN ./configure
RUN make
RUN make install

# For now, I am not building ACE with support [incr tsdb()]. That is
# the reason for the change in the Makefile
WORKDIR /tmp
RUN curl -o ace-0.9.31.tar.gz http://sweaglesw.org/linguistics/ace/download/ace-0.9.31.tar.gz
RUN tar xvfz ace-0.9.31.tar.gz
WORKDIR /tmp/ace-0.9.31
RUN cp Makefile Makefile.origin && egrep -v ^DELPHIN_ Makefile.origin > Makefile
# RUN svn co http://sweaglesw.org/svn/ace/trunk ace
# WORKDIR /tmp/ace
RUN make
RUN make install

# http://sweaglesw.org/linguistics/libtsdb/index.html. Note that we
# need to explicit call make multiple times since only after the
# installation test, art and mkprof can run.
WORKDIR /tmp
RUN svn co http://sweaglesw.org/svn/libtsdb/trunk libtsdb
WORKDIR /tmp/libtsdb
RUN make libtsdb.so libtsdb.a
RUN make install
RUN make test
RUN make art mkprof
RUN cp art mkprof /usr/local/bin/

WORKDIR /usr/local
RUN svn co http://sweaglesw.org/svn/treebank/trunk fftb
WORKDIR /usr/local/fftb
RUN cp Makefile Makefile.origin && egrep -v ^DELPHIN_LIBS Makefile.origin > Makefile
COPY web.c /usr/local/fftb/web.c
RUN make
WORKDIR /usr/local/bin
RUN ln -s ../fftb/fftb .

WORKDIR /usr/local
RUN svn co http://sweaglesw.org/svn/arbiter/trunk arbiter
WORKDIR /usr/local/arbiter
RUN make
WORKDIR /usr/local/bin
RUN ln -s ../arbiter/arbiter .

USER user
ENV HOME /home/user

CMD /bin/bash
