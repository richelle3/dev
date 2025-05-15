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

Отлично. Termux обычно запускается на Android-устройстве с архитектурой **`aarch64`** (ARM64), если только ты не используешь x86-эмулятор, что маловероятно.

### 🔧 Значит, можно собрать кастомную установку Arch Linux в `$HOME/arch`, без `proot-distro`.

Вот что я тебе предлагаю:

---

## ✅ Установка Arch в `$HOME/arch` через `proot` (ручной, стабильный способ)

### 1. Установи зависимости:

```bash
pkg update
pkg install proot tar curl
```

---

### 2. Скачай и распакуй Arch Linux (bootstrap):

```bash
mkdir -p ~/arch/rootfs
cd ~/arch
curl -LO http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz
tar -xpf ArchLinuxARM-aarch64-latest.tar.gz --exclude='dev' -C ~/arch/rootfs
```

---

### 3. Создай скрипт запуска `start-arch.sh`

```bash
cat > ~/arch/start-arch.sh << 'EOF'
#!/bin/bash
unset LD_PRELOAD
proot \
  --link2symlink \
  -0 \
  -r ~/arch/root.aarch64 \
  -b /dev \
  -b /proc \
  -b /sys \
  -b ~/arch/root.aarch64/root:/root \
  -b ~/arch/root.aarch64/tmp:/tmp \
  -w /root \
  /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    LANG=C.UTF-8 \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login
EOF

chmod +x ~/arch/start-arch.sh
```

---

### 4. Запусти Arch:

```bash
~/arch/start-arch.sh
```

Первый запуск займёт немного времени. Далее — ты внутри полноценного Arch Linux.

---

### 5. (опционально) Настроим систему внутри Arch:

```bash
pacman-key --init
pacman-key --populate archlinuxarm
pacman -Syu
pacman -S vim git curl
```

---

Хочешь, чтобы я дал тебе скрипт, который всё это сделает за тебя?

