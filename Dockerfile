# 使用官方的基础镜像
FROM nextcloud:fpm
LABEL maintainer="docker@moecly" \
    description="nextcloud install ffmpeg."

# 创建 /etc/apt/sources.list 文件并添加阿里云源
RUN echo "deb https://mirrors.aliyun.com/debian/ bookworm main non-free non-free-firmware contrib" > /etc/apt/sources.list \
    && echo "deb https://mirrors.aliyun.com/debian-security/ bookworm-security main" >> /etc/apt/sources.list \
    && echo "deb https://mirrors.aliyun.com/debian/ bookworm-updates main non-free non-free-firmware contrib" >> /etc/apt/sources.list \
    && echo "deb https://mirrors.aliyun.com/debian/ bookworm-backports main non-free non-free-firmware contrib" >> /etc/apt/sources.list \
    && rm /etc/apt/sources.list.d/debian.sources
# 安装 FFmpeg 版本（请替换为你想要的版本）
RUN apt update && apt install -y ffmpeg

COPY dockerfiles/mysql/ /etc/mysql/conf.d/
COPY dockerfiles/php/ /usr/local/etc/php-fpm.d/

# 清理不必要的缓存和文件
RUN apt clean && rm -rf /var/lib/apt/lists/*

