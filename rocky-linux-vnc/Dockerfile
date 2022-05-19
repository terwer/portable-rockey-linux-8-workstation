# 依赖的镜像
FROM rockylinux:8.5

# 镜像创建者的信息
LABEL maintainer="Terwer Green <youweics@163.com>"

# 环境变量
ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai \
    TZ=CST-8 \
    USER=terwer

# 中科大rockeylinux源
RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.ustc.edu.cn/rocky|g' \
    -i.bak \
    /etc/yum.repos.d/Rocky-AppStream.repo \
    /etc/yum.repos.d/Rocky-BaseOS.repo \
    /etc/yum.repos.d/Rocky-Extras.repo \
    /etc/yum.repos.d/Rocky-PowerTools.repo \
    && dnf clean all \    
    && dnf makecache

# 更新
RUN dnf update -y

# 安装RHEL上游发行版仓库
RUN dnf install epel-release -y

# 安装dnf插件
RUN dnf install dnf-plugins-core -y

# 安装lightdm
RUN dnf config-manager --set-enabled powertools \
    && dnf copr enable stenstorp/lightdm -y

# 安装开发者工具
RUN dnf groupinstall -y "Development Tools" \
    && dnf clean all \
    && dnf makecache \
    && dnf update -y

# 安装Xfce、lightdm、vncserver
RUN dnf groupinstall "xfce" -y \
    && dnf install lightdm -y \
    && dnf install tigervnc-server -y

# 安装其他常用工具
RUN dnf install sudo wget vim util-linux-user -y

# alias
# alias ll='ls -l'

# 安装zsh
RUN dnf install zsh -y

# 容器入口
COPY ./rocky-linux-vnc/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY ./rocky-linux-vnc/scripts /scripts

# 创建普通用户
RUN mkdir -p -- "/home"           \
    && mkdir -p -- "/home/terwer"
RUN useradd -G root -m terwer -p 123456

# 一些需要ROOT权限的操作，比如目录
RUN chown -R terwer: /home         \
    && chown -R terwer: /scripts
RUN chown -R terwer: /home/*       \
    && chown -R terwer: /scripts/*

# cleanup
# RUN rm /home/terwer/.zcompdump-*

# =================================
# 从这里开始操作不再拥有ROOT权限
# =================================

# 切回普通用户
USER terwer

# oh-my-zsh
# RUN echo "y" | (sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)") \
# 可能需要在安装一次
RUN echo "y" | (sh /scripts/zsh/install.sh)
# zsh语法校验（需手动设置）
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# vim ~/.zshrc
# plugins=(git zsh-syntax-highlighting)

CMD ["bash", "/entrypoint.sh"]