#!/usr/bin/env sh

# === Удаляем старую установку (опционально, если хочешь с нуля) ===
# rm -rf "$HOME/arch"

# === Обновляем и устанавливаем зависимости ===
pkg update && pkg upgrade -y
pkg install proot tar curl -y

# === Создаем директорию для установки ===
mkdir -p ~/arch/rootfs
cd ~/arch

# === Скачиваем архив, если его ещё нет ===
ARCHIVE="ArchLinuxARM-aarch64-latest.tar.gz"
ARCH_URL="http://os.archlinuxarm.org/os/$ARCHIVE"

if [ ! -f "$ARCHIVE" ]; then
  echo "Скачиваем $ARCHIVE..."
  curl -LO "$ARCH_URL"
else
  echo "Архив уже существует: $ARCHIVE"
fi

# === Распаковываем архив в rootfs (без dev) ===
echo "Распаковываем..."
tar -xpf "$ARCHIVE" --exclude='dev' -C ~/arch/rootfs

# === Создаём скрипт запуска ===
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
  -b /data/data/com.termux/files/home:/hosthome \
  -w /root \
  /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    LANG=C.UTF-8 \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login
EOF

# === Делаем скрипт исполняемым ===
chmod +x start-arch.sh

echo "✅ Установка завершена. Запусти Arch Linux командой:"
echo "./start-arch.sh"

