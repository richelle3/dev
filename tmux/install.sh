#!/usr/bin/env sh

# Проверка и установка tmux в Termux
if ! command -v tmux >/dev/null 2>&1; then
  echo "[..] Installing tmux..."
  apt install -y tmux
fi

# Запись конфигурации .tmux.conf
cat > "$HOME/.tmux.conf" <<'EOF'
# ~/.tmux.conf
# Убираем стандартный префикс
unbind C-b

# Новый префикс: Ctrl-Space (если не работает — замени на C-a)
set -g prefix C-Space
bind C-Space send-prefix

# Изменение размеров панелей после префикса + H/J/K/L
bind H resize-pane -L 3
bind L resize-pane -R 3
bind K resize-pane -U 3
bind J resize-pane -D 3

set-option -g focus-events on

set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:RGB"
set -as terminal-features 'xterm-256color:RGB'

set -g status on
set -g status-position bottom
set -g status-justify centre
set -g status-style bg=black,fg=yellow

set -g status-left-length 14
set -g status-left "#[fg=green]₿=#(curl -s https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT | jq -r '.price')"

setw -g window-status-format " #[fg=green]#I "
setw -g window-status-current-format " #[bold]#I "

# время и дата
set -g status-right "#[fg=green]%H:%M %d/%m/%y"

# Pane border
setw -g pane-border-status top
setw -g pane-border-format "#[bg=black,fg=yellow] #{b:pane_current_path} "
setw -g pane-active-border-style fg=yellow
EOF

tmux source-file "$HOME/.tmux.conf"

