#!/usr/bin/env sh

# Установка шрифта и конфигурация Termux

TARGET="$HOME"
SOURCE="./src/termux"

echo "[ * ] Установка шрифта и конфигурации Termux"

# Проверка на существование директории источника
if [ ! -d "$SOURCE" ]; then
  echo "[ ! ] Ошибка: директория $SOURCE не найдена"
  exit 1
fi

# Удаление старой конфигурации
rm -rf "$TARGET/.termux"

# Копирование новой конфигурации
cp -r "$SOURCE" "$TARGET/.termux"

echo "[ ✓ ] Конфигурация Termux установлена"

