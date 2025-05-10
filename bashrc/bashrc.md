> Bashrc для Termux — хорошая идея, чтобы автоматизировать окружение, улучшить удобство и внешний вид терминала.

Вот базовый пример `bashrc` с фокусом на Termux:

```bash
# ~/.bashrc for Termux

# Цветной prompt
PS1="\[\e[0;32m\]\u@\h:\[\e[0;34m\]\w\[\e[0m\]\$ "

# Aliases
alias ll='ls -la --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias update='pkg update && pkg upgrade'
alias cls='clear'

# PATH для пользовательских скриптов
export PATH="$HOME/bin:$PATH"

# Termux специфические настройки
termux-setup-storage 2>/dev/null

# Neovim как основной редактор
export EDITOR=nvim
alias vi='nvim'
alias vim='nvim'

# FZF (если установлен)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Загрузка окружения nvm (если установлен)
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi
```

### Советы:

* Добавь проверку на наличие команд перед их использованием (например, `command -v fzf >/dev/null && ...`).
* Хочешь добавить функции (например, быстрая установка плагинов, LSP и т.д.) — тоже можно в `bashrc`.
