# 環境変数
export EDITOR=vim
export LANG=ja_JP.UTF-8
export PATH="$HOME/.anyenv/bin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom" 

eval "$(anyenv init -)"
eval "$(direnv hook $0)"
