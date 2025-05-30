```
setup-scripts/
├── install.sh              # Главный скрипт для запуска всей настройки
├── packages.txt            # Список пакетов для установки
├── config/
│   ├── sway/               # Конфиги Sway, Waybar, и т.д.
│   └── virt/               # Настройки виртуализации
│       └── libvirtd.conf   # Кастомные конфиги libvirt (если есть)
├── post-install/
│   ├── enable-services.sh  # Скрипт для включения systemd-сервисов
│   └── user-setup.sh       # Добавление в группы, копирование конфигов и т.д.
```

Отличная идея — автоматизировать настройку системы через скрипты. Это сэкономит тебе массу времени при повторной установке Arch.

Вот как лучше организовать директорию `virtuali` (или переименовать её во что-то вроде `setup-scripts`, если она будет шире чем просто виртуалки):

---

## ✅ Предлагаемая структура:

```
setup-scripts/
├── install.sh              # Главный скрипт для запуска всей настройки
├── packages.txt            # Список пакетов для установки
├── config/
│   ├── sway/               # Конфиги Sway, Waybar, и т.д.
│   └── virt/               # Настройки виртуализации
│       └── libvirtd.conf   # Кастомные конфиги libvirt (если есть)
├── post-install/
│   ├── enable-services.sh  # Скрипт для включения systemd-сервисов
│   └── user-setup.sh       # Добавление в группы, копирование конфигов и т.д.
```

---

## 🧠 Что может делать `install.sh`

```bash
#!/bin/bash
set -e

echo ">> Installing packages..."
sudo pacman -Syu --noconfirm $(< packages.txt)

echo ">> Enabling services..."
./post-install/enable-services.sh

echo ">> Setting up user configs..."
./post-install/user-setup.sh

echo ">> Done!"
```

---

## 📦 Пример `packages.txt`

```txt
base-devel
git
sway
waybar
alacritty
virt-manager
qemu
libvirt
dnsmasq
edk2-ovmf
vde2
bridge-utils
```

---

## 🔧 Пример `enable-services.sh`

```bash
#!/bin/bash
sudo systemctl enable --now libvirtd.service
```

---

## 👤 Пример `user-setup.sh`

```bash
#!/bin/bash
sudo usermod -aG libvirt $USER

mkdir -p ~/.config
cp -r ../config/sway ~/.config/
```

---

## 💡 Совет

* Добавь `README.md`, чтобы не забыть, что делает каждый файл.
* Храни всё это в приватном репозитории на GitHub или в GitLab — и ты сможешь клонировать его при установке системы:

```bash
git clone https://github.com/youruser/setup-scripts
cd setup-scripts
./install.sh
```

---

Хочешь, я сгенерирую тебе минимальный `install.sh` и структуру на основе текущей задачи — настройки виртуализации?

---

Отлично, хранить виртуальные машины в `~/VMs` — это удобно и прозрачно. Вот как учесть это при создании виртуалок:

---

## 🛠️ Настройка virt-manager на хранение VM в `~/VMs`

### 🔁 Один раз:

1. Открой **virt-manager**.
2. Меню → `Edit` → `Preferences` → вкладка **Default Storage**.
3. Нажми `+`, выбери `/home/твое_имя/VMs`, задай имя (например, `user-storage`).
4. Сделай хранилище **default**.
5. Убедись, что оно **активировано** (Status: Active).

Теперь новые VM будут по умолчанию сохраняться в `~/VMs`.

---

## 🧱 При создании вручную (`virt-install`)

Если ты создаешь VM через терминал:

```bash
virt-install \
  --name arch-vm \
  --ram 2048 \
  --vcpus 2 \
  --disk path=~/VMs/arch-vm.qcow2,size=20 \
  --os-variant archlinux \
  --cdrom /path/to/archlinux.iso \
  --network network=default \
  --graphics spice
```

> Убедись, что директория `~/VMs` существует и у тебя есть права на запись.

---

Если хочешь, могу помочь сделать скрипт для создания VM в твоём `~/VMs` с нужными параметрами.

---

У тебя возник конфликт между двумя пакетами: `iptables` и `iptables-nft`.

---

## ❓ Что происходит

* `libvirt` и/или `vde2`, `ebtables` могут тянуть `iptables-nft` как зависимость.
* У тебя уже установлен классический `iptables` (устаревающий backend).
* Эти два пакета **конфликтуют**, потому что предоставляют один и тот же бинарник (`/usr/bin/iptables`) — но с разной реализацией:

  * `iptables` → классический (legacy backend).
  * `iptables-nft` → современный backend через `nftables`.

---

## ✅ Что делать

### 💡 Рекомендуемое решение: перейти на `iptables-nft`

Arch по умолчанию уже давно рекомендует использовать `iptables-nft`.

Введи:

```bash
sudo pacman -R iptables
```

Затем снова запусти установку:

```bash
./install.sh
```

---

## 🧠 Почему так лучше

* `iptables-nft` совместим с `nftables`, современным фреймворком фильтрации пакетов в Linux.
* `libvirt`, `firewalld` и другие современные утилиты работают с `nftables` по умолчанию.
* Обычный `iptables` (legacy) считается устаревшим, и Arch Linux постепенно отходит от его использования.

---

Если вдруг у тебя специфичный firewall или скрипты, которые требуют **именно legacy iptables**, тогда можно рассмотреть `iptables-legacy` из AUR — но это редкость.

---

Хочешь, я помогу добавить в твой `install.sh` автоматическую проверку и удаление `iptables`, если он мешает?

---

Отлично, ты поймал один из классических подводных камней: `iptables` нужен как зависимость для `iproute2`, но только из-за библиотеки `libxtables`.

---

## 📌 Что происходит

`iproute2` в Arch Linux **линкован с `libxtables.so`**, которую предоставляет `iptables`.

Но если ты хочешь перейти на `iptables-nft`, тебе **не нужно вручную удалять `iptables`** — Arch сам переключит бэкенд.

---

## ✅ Правильное решение

Вместо удаления `iptables`, просто **установи `iptables-nft` поверх** — pacman сам предложит заменить:

```bash
sudo pacman -S iptables-nft
```

Он предложит:

```
:: iptables-nft и iptables находятся в конфликте. Удалить iptables? [y/N]
```

Выбирай **`y`**, и pacman заменит `iptables` на `iptables-nft` без поломки зависимостей (включая `libxtables.so` — она в `iptables-nft` тоже есть).

---

## ⚙️ После замены

Проверь, что всё переключилось:

```bash
sudo iptables --version
```

Вывод будет:

```
iptables v1.8.x (nf_tables)
```

Если видишь `(nf_tables)` — всё ОК.

---

## 🧪 Дополнительно (если надо)

Ты можешь проверить, какое поведение включено по умолчанию:

```bash
sudo update-alternatives --config iptables
```

Если вдруг `iptables-legacy` или `iptables-nft` конфликтуют в системе — там можно вручную выбрать нужный бэкенд (но в Arch это обычно не требуется).

---

Готов помочь обновить твой `install.sh` скрипт так, чтобы он **автоматически ставил `iptables-nft`** при необходимости. Хочешь?

