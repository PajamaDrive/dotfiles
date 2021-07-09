#!/bin/sh
set -u

# 今のディレクトリ
# dotfilesディレクトリに移動する
BASEDIR=$(dirname $0)
cd $BASEDIR

# dotfilesディレクトリにある、ドットから始まり2文字以上の名前のファイルに対して
for f in .??*; do
	[ "$f" = ".git" ] && continue
	[ "$f" = ".gitconfig.local.template" ] && continue
	[ "$f" = ".gitmodules" ] && continue
  if [ -d ~/"$f" ]; then
    rm -rf ~/"$f"
  fi
	# シンボリックリンクを貼る
	ln -snfv ${PWD}/"$f" ~/
done
