#!/bin/bash
#
# file: setup.sh
# author: Ryan James Spencer
# summary: Symlinks files in users root directory the files living here.

backup_dir="$HOME/.dotfiles.bk"
config_files=$(find -type f | grep -Zv .git);

for file in "$config_files"; do
  if [ "$file" = "$0" ]; then echo "$file"; fi
  # Skip any ignored files.
  #filename=$(basename $file)
  #if [[ -n "${ignored_files[$filename]}" ]]; then
    #continue
  #fi
  #echo -e "$file\n"

  #if [[ -e "$HOME/$file" ]]; then
    ## Backup the old config files someplace safe.
    #mkdir -p "$backup_dir"
    #cp -r "$file" "$backup_dir"
    #echo "Copying $file to $backup_dir"

    ## Do tell if there are differences between the files.
    #diff -q "$HOME/$file" "$PWD/$file" &>/dev/null
    #if [ $? -eq 1 ]; then
      #echo "$file is different from local copy!"
    #fi
  #fi

  #echo "Linking $HOME/$file to $PWD/$file"
  ## TODO remove verbose flag.
  ##ln -sfv "$HOME/$file" "$PWD/$file"
done
