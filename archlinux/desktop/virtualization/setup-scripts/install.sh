#!/usr/bin/env sh

set -e

echo "==> Установка iptables-nft (если потребуется)..."
if pacman -Q iptables &>/dev/null; then
    echo "==> Заменяем iptables на iptables-nft"
    sudo pacman -S --needed iptables-nft
fi

echo "==> Проверка наличия packages.txt..."
if [[ ! -f packages.txt ]]; then
    echo "Ошибка: файл packages.txt не найден"
    exit 1
fi

echo "==> Установка пакетов из packages.txt..."
packages=$(grep -vE '^\s*#' packages.txt | grep -vE '^\s*$' | tr '\n' ' ')
sudo pacman -Syu --needed $packages

echo "==> Включение и запуск службы libvirtd..."
sudo systemctl enable --now libvirtd.service

echo "==> Добавление пользователя '$USER' в группу libvirt..."
if groups $USER | grep -qv '\blibvirt\b'; then
    sudo usermod -aG libvirt $USER
    echo "==> Пользователь $USER добавлен в группу libvirt."
else
    echo "==> Пользователь $USER уже в группе libvirt."
fi

echo "==> Готово."
echo "🔁 Выйди из сеанса и войди заново, чтобы изменения групп вступили в силу."

