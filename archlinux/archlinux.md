> Ниже — подробная инструкция по установке **Arch Linux в Termux через proot**, без использования `proot-distro`. Этот способ не требует root-доступа.

---

## **Шаг 1: Установка необходимых пакетов**

Открой Termux и выполни:

```bash
pkg update && pkg upgrade
pkg install proot tar curl
```

---

## **Шаг 2: Скачивание и установка rootfs Arch Linux**

1. Создай рабочую директорию:

```bash
mkdir -p ~/arch
cd ~/arch
```

2. Скачай rootfs для архитектуры твоего устройства (скорее всего, aarch64):

```bash
curl -LO https://mirror.rackspace.com/archlinuxarm/os/ArchLinuxARM-aarch64-latest.tar.gz
```

3. Распакуй архив:

```bash
proot --link2symlink tar -xpf ArchLinuxARM-aarch64-latest.tar.gz --exclude='dev' -C ~/arch
```

> Мы исключаем `dev`, чтобы избежать конфликтов с системой.

---

## **Шаг 3: Создание скрипта запуска**

Создай файл `start-arch.sh`:

```bash
cat > start-arch.sh << 'EOF'
#!/usr/bin/env bash

cd ~/arch

unset LD_PRELOAD

proot \
  --link2symlink \
  -0 \
  -r ~/arch \
  -b /dev \
  -b /proc \
  -b /sys \
  -b /sdcard \
  -w /root \
  /bin/bash --login
EOF
```

Сделай его исполняемым:

```bash
chmod +x start-arch.sh
```

---

## **Шаг 4: Настройка Arch Linux (внутри proot)**

Запусти Arch Linux:

```bash
./start-arch.sh
```

После запуска:

1. Настрой DNS (если надо):

```bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

2. Инициализируй ключи:

```bash
pacman-key --init
pacman-key --populate archlinuxarm
```

3. Обнови систему и установи нужное:

```bash
pacman -Syu
pacman -S base-devel vim git
```

---

## **Дополнительно**

* Ты можешь установить `neovim`, `python`, `clang`, `nodejs` и т.д.
* Все данные хранятся в `~/arch`, поэтому легко сделать резервную копию.

---

