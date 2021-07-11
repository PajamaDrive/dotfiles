# zshのコマンドの履歴をシェルが終了しても保持するようにする
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

# パスを直接入力するとcd
setopt AUTO_CD

# 環境変数を補完する
setopt AUTO_PARAM_KEYS

# Ctrl-sとCtrl-qを有効にする
setopt no_flow_control

# alias
alias pbcopy='xsel --clipboard --input'
alias vi='vim'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias ls='ls -h --color=always'

# Homebrew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.starship.toml

# wslのシェルからwindowsのクリップボードにコピーするための設定
if [ -e /mnt/c/Windows/System32/wsl.exe ]; then
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
    # auto run vcxsrv
    if [ -z "$(tasklist.exe | grep vcxsrv)" ]; then
        cmd.exe /c config.xlaunch
    fi
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# zsh-completions
zinit ice wait'0'; zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1 

# zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntaxhighlighting
zinit light zsh-users/zsh-syntax-highlighting
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=white'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=white'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'

# anyenv
eval "$(anyenv init -)"

# peco
## コマンド履歴検索
function peco-history-selection() {
  BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

## カレントディレクトリ以下のディレクトリ検索・移動
function find_cd() {
  local selected_dir=$(find . -type d | peco)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N find_cd
bindkey '^X' find_cd

## gitリポジトリ検索・移動
function peco-src () {
  local selected_dir=$(ghq list -p | peco)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N peco-src
bindkey '^G' peco-src

# zsh-history-substring-search
zinit light zsh-users/zsh-history-substring-search

# enhanced
zinit light b4b4r07/enhancd

# zsh-completions
zinit light zsh-users/zsh-completions

# emojify
zinit light b4b4r07/emoji-cli
zinit light mrowa44/emojify
export PATH="$PATH:$HOME/.zinit/plugins/mrowa44---emojify"
