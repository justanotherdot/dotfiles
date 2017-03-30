#!/bin/bash
# author: Ryan James Spencer

set -eu

backup_dir=".dotfiles.bk"
dotfiles=$(find -type f | egrep -v "(.git/|$0)" | sed 's/\.\///')

mkdir -p "$HOME/$backup_dir"

for dotfile in $dotfiles; do
  # Backup all the respective files.
  # TODO Want a better way to do multiple backups.
  if [[ -f "$HOME/$dotfile" ]]; then
    cp -vf "$HOME/$dotfile" "$HOME/$backup_dir/$dotfile"
  fi
  # TODO Improve this with an env-var that designates the dotfile git repo.
  # Symlink dotfile in home directory to this dotfile directory.
  ln -vsf "$PWD/$dotfile" "$HOME/$dotfile"
done
