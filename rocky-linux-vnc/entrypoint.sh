#!/bin/sh

# =========================
# 备份
# =========================
# backup
source /scripts/backup.sh

# =========================
# 初始化
# =========================
# init
source /scripts/init.sh

# =========================
# 启动应用
# =========================
# vncserver
source /scripts/start_vncserver.sh

echo "rocky linux 8.5 is successfully started"
echo "back to shell=>"
cd ~
pwd
zsh