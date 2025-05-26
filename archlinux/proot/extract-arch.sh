#!/usr/bin/env sh

cd ~/arch

ARCHIVE="ArchLinuxARM-aarch64-latest.tar.gz"
TARGET_DIR="root"

# Проверка архива
echo "Проверка архива..."
if ! tar -tzf "$ARCHIVE" > /dev/null 2>&1; then
  echo "❌ Повреждённый архив! Удали и скачай заново."
  exit 1
fi

# Удаляем старую rootfs (если нужно)
# rm -rf "$TARGET_DIR"

# Распаковка
echo "Распаковываем в $TARGET_DIR..."
mkdir -p "$TARGET_DIR"
tar -xpf "$ARCHIVE" --exclude='dev' -C "$TARGET_DIR"

echo "✅ Распаковка завершена. Запусти Arch Linux командой:"
echo "./start-arch.sh"
