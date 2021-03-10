FROM centos:7.9.2009

ENV STEALTH_VERSION="v8.11.4"

RUN \
    yum upgrade -y && \
    rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y \
    x11vnc.x86_64 \
    which.x86_64 \
    wget.x86_64 \
    unzip.x86_64 \
    xorg-x11-server-Xvfb.x86_64 \
    python3.x86_64 \
    xdotool.x86_64 \
    gtk3.x86_64 \
    libcurl.x86_64 \
    webkitgtk4.x86_64

COPY entrypoint.sh /opt/entrypoint.sh

RUN \
    cd /opt && \
    chmod +x entrypoint.sh && \
    wget https://stealth.od.ua/download/Stealth_${STEALTH_VERSION}_Linux.zip && \
    unzip Stealth_${STEALTH_VERSION}_Linux.zip && \
    chmod +x UOStealth && \
    rm -f Stealth_${STEALTH_VERSION}_Linux.zip && \    
    yum -y clean all --enablerepo='*' && \
    rm -rf /var/log/*

ENTRYPOINT ["/opt/entrypoint.sh"]
