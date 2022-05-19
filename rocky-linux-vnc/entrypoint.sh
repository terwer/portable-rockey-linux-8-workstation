# 启动VNCServer
# echo "vncserver is starting..."
vncserver -kill :1
vncserver :1 -geometry 1536x899 -depth 24 -SecurityTypes None 
echo "vncserver is started"

echo "rocky linux 8.5 is successfully started"
echo "back to zsh shell=>"
cd ~
bash