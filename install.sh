#!/usr/bin/env bash

cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)/.dotfiles


install() {
  echo 'Installing dotfiles'
  
  find -H "$DOTFILES" -name 'link.path' | while read linkfile

  do
    cat "$linkfile" | while read line
    do
      local src dst dir
      src=$(eval echo "$line" | cut -d '=' -f 1)
      dst=$(eval echo "$line" | cut -d '=' -f 2)
      dir=$(dirname "$dst")
      mkdir -p "$dir"
      echo "$src" "$dst"
      link_file "$src" "$dst"
    done  
  done 
}

link_file() {
  local src=$1 dst=$2
  if [ -e "$dst" ]; then
    rm "$dst"
  fi
  ln -s $src $dst
 }

install