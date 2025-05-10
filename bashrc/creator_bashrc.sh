cat > "$HOME/.bashrc" << 'EOF'
# ~/.bashrc for Termux

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
# termux-setup-storage 2>/dev/null

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
EOF
