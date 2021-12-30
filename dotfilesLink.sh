#!/bin/sh
set -u

# dotfilesディレクトリにある、ドットから始まり2文字以上の名前のファイルに対して
for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitconfig.local.template" ] && continue
  [ "$f" = ".gitmodules" ] && continue
  [ `echo "$f" | grep 'brew'` ] && continue

  if [ -d ~/"$f" ]; then
    rm -rf ~/"$f"
  fi

  # シンボリックリンクを貼る
  ln -snfv ${PWD}/"$f" ~/
done

