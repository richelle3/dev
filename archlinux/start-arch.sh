#!/usr/bin/env sh

# Создаём скрипт запуска
cat > ~/arch/start-arch.sh << 'EOF'
#!/usr/bin/env bash

cd ~/arch

unset LD_PRELOAD

proot \
  --link2symlink \
  -0 \
  -r ~/arch/root \
  -b /sdcard \
  -b /data/data/com.termux/files/home:/termux \
  -w /root \
  /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    LANG=C.UTF-8 \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash
EOF

# Делаем скрипт исполняемым
chmod +x ~/arch/start-arch.sh

echo "✅ Скрипт запуска создан: ~/arch/start-arch.sh"
echo "Запусти Arch Linux командой:"
echo "./start-arch.sh"
