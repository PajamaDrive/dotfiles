#!/bin/sh

# gitのリポジトリをローカルに持ってくる
B
function getGitRepository() {
  # git が使えるなら git
  if type "git"; then
    git clone --recursive git@github.com:PajamaDrive/"$1".git
    mv -f "$1" "$HOME/.$1"
  # 使えない場合は curl か wget を使用する
  elif type "curl" || type "wget"; then
    tarball="https://github.com/PajamaDrive/"$1"/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if type "curl"; then
      curl -L "$tarball"

    elif type "wget"; then
      wget -O - "$tarball"

    fi | tar zxv

    # 解凍したら，別の場所 に置く  
    mv -f "$1"-master "$HOME/.$1"

  else
    die "curl or wget required"
  fi
}

# カレントディレクトリを記憶しておく
CURRENT_DIR=`pwd`

# dotfilesの設定

DOTFILES_DIR=$HOME/.dotfiles

## dotfilesをローカルに持ってくる
getGitRepository dotfiles
cd $DOTFILES_DIR

## ホームディレクトリにシンボリックリンクを貼る
sh dotfilesLink.sh

## OSによってbrewで入れるソフトを変える
 [ -f $DOTFILES_DIR/.brew_`uname` ] && brew bundle --file $DOTFILES_DIR/.brew_`uname`

## 環境変数を有効にする
source $HOME/.zshrc

# VSCodeの設定

VSCODE_SETTING_DIR=$HOME/.vscode-settings

## VSCodeの設定ファイルをローカルに持ってくる
getGitRepository vscode-settings
cd $VSCODE_SETTING_DIR

### VSCodeの拡張機能を入れる
sh $VSCODE_SETTING_DIR/install.sh

## VSCodeの設定ファイルをコピー
if [ `uname` = 'Darwin' ]; then
  cp $VSCODE_SETTING_DIR/*.json $HOME/Library/Application\ Support/Code/User/
elif [ `uname` = 'Linux' ]; then
  cp $VSCODE_SETTING_DIR/*.json $HOME/.config/Code/User/
fi

# 元いたディレクトリに戻る
cd $CURRENT_DIR
