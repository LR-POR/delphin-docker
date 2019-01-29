#! /bin/bash

## Usage:   ./logon.sh 
###
###   your $HOME folder must contain:
###       - Subdirectory 'logon', containing all logon tree
###       - fixed .bashrc with LOGONROOT definition
###       - fixed .emacs with logon stuff


## bind the X11 server socket to a port so it is accessible by the VM
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &

## allow VM to create windows
xhost +

# find out IP of host
IP=`ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}'`

# run VM, redirecting display and mapping $HOME folders 
docker run -it --rm -v $HOME/hpsg:/home/user -w /home/user --user=user -e DISPLAY=$IP:0 logon /bin/bash

# remove X11 socket binding
killall socat

