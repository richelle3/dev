w() {
  if [ -z "$TMUX" ]; then
    cd $HOME/dev;
    tmux new-session -d -s "work" "zsh"
    tmux attach-session -t "work"
  else
    # Если уже в tmux, просто переключаемся на сессию
    tmux switch-client -t "work"
  fi
}

n() {
  nnn -H ./;
}

