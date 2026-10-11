
#!/bin/bash
set -eu

if [ -z "${SSH_PUBLIC_KEY:-}" ]; then
    echo "SSH_PUBLIC_KEY belum diatur."
    exit 1
fi

mkdir -p /home/railway/.ssh
printf '%s\n' "$SSH_PUBLIC_KEY" \
  > /home/railway/.ssh/authorized_keys

chown -R railway:railway /home/railway/.ssh
chmod 700 /home/railway/.ssh
chmod 600 /home/railway/.ssh/authorized_keys

exec /usr/sbin/sshd -D -e
