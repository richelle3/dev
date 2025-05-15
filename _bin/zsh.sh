#!/usr/bin/env sh

set -e

echo "[1/4] Обновляем пакеты..."
pacman -Sy --noconfirm

echo "[2/4] Устанавливаем zsh и необходимые зависимости..."
pacman -S --noconfirm zsh git curl

echo "[3/4] Устанавливаем oh-my-zsh..."
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "[4/4] Делаем zsh оболочкой по умолчанию в proot..."
echo 'exec zsh' >> ~/.bashrc

echo "Готово! Перезапусти терминал или выполни 'zsh', чтобы начать использовать zsh."
