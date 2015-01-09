# 環境変数
export EDITOR=vim
export LANG=ja_JP.UTF-8
export PATH="$HOME/.anyenv/bin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
# 強制色づけ
export CLICOLOR=1

if [ -d ${HOME}/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`
  do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi
eval "$(direnv hook $0)"

# パスの追加
fpath=(~/.zsh/completion $fpath)

if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# 追加のコマンドをパスに追加
PATH=~/bin:$PATH
PATH=~/bin/git-info:$PATH
PATH=~/bin/git-ls-branches:$PATH
