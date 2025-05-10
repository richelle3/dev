t() {
  if [ -z "$TMUX" ]; then
    tmux new-session -d -s "work" -n "XD" "zsh"
    tmux attach-session -t "work"
  else
    # Если уже в tmux, просто переключаемся на сессию
    tmux switch-client -t "work"
  fi
}

n() {
  nnn -H ./;
}

