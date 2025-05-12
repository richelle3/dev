#!/usr/bin/env sh

rm -rf $HOME/arch

pkg update && pkg upgrade -y
pkg install proot tar curl -y

mkdir -p ~/arch/rootfs
cd ~/arch

curl -LO https://mirror.rackspace.com/archlinuxarm/os/ArchLinuxARM-aarch64-latest.tar.gz
proot --link2symlink tar -xpf ArchLinuxARM-aarch64-latest.tar.gz --exclude='dev' -C rootfs

cat > start-arch.sh << 'EOF'
#!/usr/bin/env bash

cd ~/arch

unset LD_PRELOAD

proot \
  --link2symlink \
  -0 \
  -r ~/arch/rootfs \
  -b /dev \
  -b /proc \
  -b /sys \
  -b /sdcard \
  -w /root \
  /bin/bash --login
EOF

chmod +x start-arch.sh

