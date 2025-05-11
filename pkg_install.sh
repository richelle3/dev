#!/usr/bin/env sh

# All programs that you need to be installed

refresh() {
  # Refresh package list
  if [ -n "$TERMUX_VERSION" ]; then
    echo "[ * ] Refreshing package list...";
    apt update && apt upgrade -y;
    echo "[ Ok ] Package list refreshed"
  fi
}

check_program() {
  # Check if a program is installed
  command -v "$1" >/dev/null 2>&1;
}

install() {
  # For Termux
  if [ -n "$TERMUX_VERSION" ]; then
    for program in "$@"; do
      if check_program "$program"; then
        echo "[ Ok ] Already installed: $program";
      else
        echo "[ * ] Start installing: $program"
        apt install -y "$program"
        echo "[ Ok ] Installed: $program"
      fi
    done
  fi
}

# Main
refresh

install git curl wget zip unzip tar gzip
install fzf fd ripgrep bc
install bat exa lsd
