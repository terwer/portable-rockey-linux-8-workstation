#!/bin/sh

# 设置vnc配置
rm -rf ~/.vnc/xstartup
cp -r /config/vnc-xfce/.vnc/xstartup ~/.vnc/xstartup
chmod 777 ~/.vnc/xstartup
echo "set vnc to xfce4 session"

# 更新最新vnc配置
# =============================
rm -rf /tmp/.X1-lock
# 设置vnc密码
# vncpasswd
# 设置vnc密码
# echo -ne "123456" | vncpasswd -f > ~/.vnc/passwd
# echo "reset vnc password"
# =============================

# 启动VNCServer
echo "vncserver is starting..."
vncserver -kill :1
vncserver :1 -geometry 1536x899 -SecurityTypes None
echo "vncserver is started"