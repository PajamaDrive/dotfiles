#!/bin/sh

# gitのリポジトリをローカルに持ってくる
function getGitRepository() {
  # git が使えるなら git
  if has "git"; then
    git clone --recursive git@github.com:PajamaDrive/"$1".git

  # 使えない場合は curl か wget を使用する
  elif has "curl" || has "wget"; then
    tarball="https://github.com/PajamaDrive/"$1"/archive/master.tar.gz"

  # どっちかでダウンロードして，tar に流す
  if has "curl"; then
    curl -L "$tarball"

  elif has "wget"; then
    wget -O - "$tarball"

  fi | tar zxv

  # 解凍したら，別の場所 に置く  
  mv -f "$1"-master "$HOME/.$1"

  else
    die "curl or wget required"
  fi
}

# dotfilesの設定

DOTFILES_DIR=$HOME/.dotfiles

## dotfilesをローカルに持ってくる
getGitRepository dotfiles
cd $DOTFILES_DIR

## ホームディレクトリにシンボリックリンクを貼る
sh dotfilesLink.sh

## 環境変数を有効にする
source $HOME/.zshrc

## OSによってbrewで入れるソフトを変える
[ -f $DOTFILES_DIR/.brew_`uname` ] && . brew bundle --file $DOTFILES_DIR/.brew_`uname`

# VSCodeの設定

VSCODE_SETTING_DIR=$HOME/.vscode-settings

## VSCodeの設定ファイルをローカルに持ってくる
getGItRepository vscode-settings

## VSCodeの拡張機能を入れる
sh $VSCODE_SETTING_DIR/extensions.sh

## VSCodeの設定ファイルをコピー
if [ `uname` = 'Darwin' ]; then
  cp $VSCODE_SETTING_DIR/*.json $HOME/Library/Application\ Support/Code/User/
elif [ `uname` = 'Linux' ]; then
  cp $VSCODE_SETTING_DIR/*.json $HOME/.config/Code/User/
fi

