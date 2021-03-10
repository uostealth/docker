#!/bin/bash

export SCREEN_RESOLUTION=1024x768x24
export DISPLAY_NUM=99
export DISPLAY=":$DISPLAY_NUM"

/usr/bin/xvfb-run -l -n "$DISPLAY_NUM" -s "-ac -screen 0 $SCREEN_RESOLUTION -noreset -listen tcp" /opt/UOStealth &
XVFB_PID=$!

sleep 8

x11vnc -display "$DISPLAY" -passwd stealth -shared -forever -loop500 -rfbport 5900 -rfbportv6 5900 -logfile /dev/null &
X11VNC_PID=$!

X_WINDOW_ID=`xdotool search --onlyvisible --limit 1 --name stealth`
xdotool windowsize $X_WINDOW_ID 1024 768
xdotool windowmove $X_WINDOW_ID 0 0

wait