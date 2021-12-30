# DotFiles
使いまわせそうな設定ファイルを保存するためのリポジトリ

* .tmux.conf: tmuxの設定 
* .starship.toml: Starshipの設定

環境変数を一括で設定する際は以下のコマンドで行う

`curl -L raw.github.com/PajamaDrive/dotfiles/master/install.sh | bash`

## Homwbrew
Homebrewで入れたソフト一覧は以下で出力できる

`` brew bundle dump --file $HOME/dotfiles/.brew_`uname` ``

### ソフト一覧
anyenv: env系を一元管理
clipy: クリップボードの拡張
font-hack-nerd-font: NerdFont
git-delta: gitの差分をいい感じに出してくれる
google-chrome: Chrome
keycastr: 打鍵したキーを表示
peco: インクリメンタルサーチ
starship: ターミナルの表示をいい感じにしてくれる
visual-studio-code: VSCode
zinit: zshのプラグインマネージャ

## vimのプラグイン
追加する際は以下のように行う

`git submodule add git@github.com:hogehoge.git ~/.vim/pack/resident/start`

dein.vimを使うとsubmoduleで持ってくるみたいなことをしなくて済むらしいので導入を考えたいところ

### プラグイン一覧
* ale: 非同期のコードチェック
* lexima.vim: 閉じ括弧の補完
* markdown-preview.nvim: コマンド(:MarkdownPreview)でマークダウンファイルのプレビューを見れる(yarnが入っていないとダメ)
* nerdtree: コマンド(:NerdTreeToggle)でファイルツリーを出せる
* vim-airline: vimのステータスバーをそれっぽくする
* vim-airline-themes: vim-airlineのテーマ
* vim-cheatsheet: コマンド(:Cheat)を打つとチートシートを表示する
* vim-commentary: コマンド(gcc)でコメント化
* vim-devicons: NerdFont表示
* vim-fugitive: vim上でgitのコマンドが打てる
* vim-gitgutter: vim上にgitの差分が表示される
* vim-hilightedyank: ヤンクした際にハイライト表示される
* vim-polyglot: さまざまな言語のシンタックス・インデントを提供
* vim-surround: 括弧やクォートの削除・変換が可能
* winresizer: ウインドウ分割時にCtrl-eでリサイズが可能

