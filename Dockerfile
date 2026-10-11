
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openssh-server bash curl nano ca-certificates iproute2 && \
    useradd -m -s /bin/bash railway && \
    mkdir -p /run/sshd /home/railway/.ssh && \
    chown -R railway:railway /home/railway && \
    rm -rf /var/lib/apt/lists/*

RUN printf '%s\n' \
    'Port 2222' \
    'PermitRootLogin no' \
    'PasswordAuthentication no' \
    'PubkeyAuthentication yes' \
    'AllowUsers railway' \
    >> /etc/ssh/sshd_config

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 2222

CMD ["/entrypoint.sh"]
