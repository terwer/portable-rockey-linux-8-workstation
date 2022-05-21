# 依赖的镜像
FROM rockylinux:8.5

# 镜像创建者的信息
LABEL maintainer="Terwer Green <youweics@163.com>"

# 环境变量
ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai \
    TZ=CST-8

# 用 root 用户操作
USER root

# 中科大rockeylinux源
RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.ustc.edu.cn/rocky|g' \
    -i.bak \
    /etc/yum.repos.d/Rocky-AppStream.repo \
    /etc/yum.repos.d/Rocky-BaseOS.repo \
    /etc/yum.repos.d/Rocky-Extras.repo \
    /etc/yum.repos.d/Rocky-PowerTools.repo
RUN dnf clean all && dnf makecache

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
RUN dnf groupinstall -y "Development Tools"
RUN dnf clean all \
    && dnf makecache \
    && dnf update -y

# 安装Xfce、lightdm、vncserver
RUN dnf groupinstall "xfce" -y
RUN dnf install lightdm -y

# 安装其他常用工具
RUN dnf install sudo \
    wget \
    vim \
    util-linux-user \
    passwd \
    -y

# 显示系统信息    
RUN dnf install neofetch -y

# 浏览器
RUN dnf install firefox -y

# 安装zsh
RUN dnf install zsh -y

# 安装vncserver
RUN dnf install tigervnc-server -y

# 创建普通用户
RUN useradd --create-home --no-log-init --shell /bin/zsh -G root terwer 
RUN echo 'terwer:123456' | chpasswd
RUN echo 'root:password' | chpasswd
RUN chown -R terwer:terwer /home

# ==========================
# zsh以及环境变量
# ==========================
# 给root用户安装oh-my-zsh
RUN git clone https://gitee.com/mirrors/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && git clone https://gitee.com/playerfs/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://gitee.com/playerfs/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && sed -i 's/^plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting /' ~/.zshrc \
    && chsh -s /bin/zsh

USER terwer
# 为普通用户再安装一次oh-my-zsh
RUN git clone https://gitee.com/mirrors/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && git clone https://gitee.com/playerfs/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://gitee.com/playerfs/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && sed -i 's/^plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting /' ~/.zshrc
# 添加自定义环境变量
RUN echo "source ~/.my_profile" >> ~/.bashrc
RUN echo "source ~/.my_profile" >> ~/.zshrc
RUN echo '# auto set env template' > ~/my_profile_auto.sh

USER root
# ===============================
# 安装一些其他软件
# ==============================
RUN dnf install emacs -y

# =================================
# 从这里开始操作不再拥有ROOT权限
# =================================
# 切回普通用户
USER terwer

# 容器入口
COPY ./entrypoint.sh /entrypoint.sh

CMD ["zsh", "/entrypoint.sh"]