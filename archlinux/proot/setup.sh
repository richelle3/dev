#!/usr/bin/env sh

# === Удаляем старую установку (опционально, если хочешь с нуля) ===
rm -rf "$HOME/arch"

# === Обновляем и устанавливаем зависимости ===
pkg update && pkg upgrade -y
pkg install proot tar curl -y

# === Создаем директорию для установки ===
mkdir -p ~/arch/root
cd ~/arch

# === Скачиваем архив, если его ещё нет ===
ARCHIVE="ArchLinuxARM-aarch64-latest.tar.gz"
ARCH_URL="http://os.archlinuxarm.org/os/$ARCHIVE"

if [ ! -f "$ARCHIVE" ]; then
  echo "Скачиваем $ARCHIVE..."
  curl -LO "$ARCH_URL"
else
  echo "[ Ok ] Архив уже существует: $ARCHIVE"
fi
#
# # === Распаковываем архив в rootfs (без dev) ===
# echo "Распаковываем..."
# tar -xpf "$ARCHIVE" --exclude='dev' -C ~/arch/root
#
#
# echo "✅ Установка завершена. Запусти Arch Linux командой:"
# echo "./start-arch.sh"
#
