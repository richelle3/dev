cat > "$HOME/.bashrc" << 'EOF'
# ~/.bashrc for Termux

# Aliases
alias ll='ls -la --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias update='pkg update && pkg upgrade'
alias cls='clear'


# PATH для пользовательских программ
export PATH="$HOME/.local/bin:$PATH"


# Nnn
export NNN_PLUG="\
i:exec;\
v:nvim;\
g:gpt;\
m:music;\
y:youtube;\
t:term;\
"
export NNN_USE_EDITOR=1
export NNN_PIPE="$HOME/.nnn_pipe"
export NNN_SEL="$HOME/.nnn_sel"
export NNN_FIFO="$HOME/.nnn_fifo"


# Termux специфические настройки
# termux-setup-storage 2>/dev/null

# Neovim как основной редактор
export EDITOR=nvim
alias vi='nvim'
alias vim='nvim'

# FZF (если установлен)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

## Загрузка окружения nvm (если установлен)
# if [ -d "$HOME/.nvm" ]; then
#     export NVM_DIR="$HOME/.nvm"
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# fi
EOF
