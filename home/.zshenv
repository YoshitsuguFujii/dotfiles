# 環境変数
export EDITOR=vim
export LANG=ja_JP.UTF-8
export PATH="$HOME/.anyenv/bin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
# 強制色づけ
export CLICOLOR=1

eval "$(anyenv init -)"
eval "$(direnv hook $0)"

# パスの追加
fpath=(~/.zsh/completion $fpath)

# 追加のコマンドをパスに追加
PATH=~/bin:$PATH
PATH=~/bin/git-info:$PATH
PATH=~/bin/git-ls-branches:$PATH
