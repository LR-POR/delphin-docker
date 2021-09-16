#! /bin/bash

###   Usage:   ./logon.sh 
###
###   your $HOME/hpsg folder must contain:
###       - Subdirectory 'logon', containing all logon tree
###       - fixed .bashrc with LOGONROOT definition
###       - fixed .emacs with logon stuff

## bind the X11 server socket to a port so it is accessible by the VM
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &

## allow VM to create windows
xhost +

# find out IP of host
IP=`ipconfig getifaddr en0`

# run VM, redirecting display, ports and map the $HOME folder.
docker run -p 80:80 -p 9080:9080 -p 8080:8080 -it --rm -v $HOME/hpsg:/home/user -w /home/user --user=user -e DISPLAY=$IP:0 logon:latest /bin/bash

# remove X11 socket binding
killall socat

