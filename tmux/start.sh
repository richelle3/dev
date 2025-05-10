#!/usr/bin/env sh

# Проверка и установка tmux в Termux
if ! command -v tmux >/dev/null 2>&1; then
  echo "Installing tmux..."
  pkg install -y tmux
fi

# Запись конфигурации .tmux.conf
cat > "$HOME/.tmux.conf" <<'EOF'
# ~/.tmux.conf
unbind C-b
set -g prefix C-Space
bind-key C-Space send-prefix

# Режим изменения размера панели с Ctrl + стрелками
bind -n C-Left  resize-pane -L 3
bind -n C-Right resize-pane -R 3
bind -n C-Up    resize-pane -U 3
bind -n C-Down  resize-pane -D 3

set-option -g focus-events on

set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:RGB"
set -as terminal-features 'xterm-256color:RGB'

set -g status on
set -g status-position bottom
set -g status-justify centre
set -g status-style bg=black,fg=yellow

set -g status-left ""
set -g status-right ""

setw -g pane-border-status top
setw -g pane-border-format "#[bg=black,fg=yellow] #{b:pane_current_path} "
setw -g pane-active-border-style fg=yellow

setw -g window-status-format "#I:#W"
setw -g window-status-current-format "#[bold]#I:#W"
EOF

