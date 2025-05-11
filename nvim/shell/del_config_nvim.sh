#!/usr/bin/env sh

# Проверка и установка bc в Termux
if ! command -v bc >/dev/null 2>&1; then
    echo "[ ! ] Утилита 'bc' не найдена, пытаемся установить..."
    if command -v pkg >/dev/null 2>&1; then
        pkg install bc -y && echo "[ OK ] 'bc' успешно установлен" || {
            echo "[ !! ] Ошибка установки 'bc'"
            exit 1
        }
    else
        echo "[ !! ] Не удалось установить 'bc' (pkg не найден)"
        exit 1
    fi
fi

# Каталоги для удаления
conf_dir="$HOME/.config/nvim"
share_dir="$HOME/.local/share/nvim"
state_dir="$HOME/.local/state/nvim"
cache_dir="$HOME/.cache/nvim"

# Функция для подсчёта размера каталога в человеко-читаемом формате
calculate_size() {
    if [ -d "$1" ]; then
        du -sh "$1" 2>/dev/null | awk '{print $1}' || echo "0K"
    else
        echo "0K"
    fi
}

# Функция для подсчёта размера в мегабайтах (число)
get_size_mb() {
    if [ -d "$1" ]; then
        du -s "$1" 2>/dev/null | awk '{printf "%.2f", $1/1024}' || echo "0"
    else
        echo "0"
    fi
}

# Подсчёт общего размера перед удалением
total_mb=$(echo "$(get_size_mb "$conf_dir") + \
                 $(get_size_mb "$share_dir") + \
                 $(get_size_mb "$state_dir") + \
                 $(get_size_mb "$cache_dir")" | bc)

echo "Будет удалена конфигурация Neovim:"
echo "  $conf_dir ($(calculate_size "$conf_dir"))"
echo "  $share_dir ($(calculate_size "$share_dir"))"
echo "  $state_dir ($(calculate_size "$state_dir"))"
echo "  $cache_dir ($(calculate_size "$cache_dir"))"
echo ""
echo "Всего будет освобождено: ${total_mb} MB"
echo "Продолжить? (y/N)"

read answer
case "$answer" in
    y|Y) 
        echo "[ * ] Удаление..."
        [ -d "$conf_dir" ] && { rm -rf "$conf_dir"; echo "  $conf_dir удалён"; }
        [ -d "$share_dir" ] && { rm -rf "$share_dir"; echo "  $share_dir удалён"; }
        [ -d "$state_dir" ] && { rm -rf "$state_dir"; echo "  $state_dir удалён"; }
        [ -d "$cache_dir" ] && { rm -rf "$cache_dir"; echo "  $cache_dir удалён"; }
        echo "[ OK ] Конфигурация удалена!"
        echo "[ OK ] Освобождено: ${total_mb} MB"
        ;;
    *)
        echo "[ -- ] Отменено"
        ;;
esac
