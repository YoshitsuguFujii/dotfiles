# Created by newuser for 5.0.7


# 補完の有効化
autoload -U compinit && compinit

# direnv設定
eval "$(direnv hook $0)"

# 環境変数
export EDITOR=vim

# some more ls aliases
alias up='cd ..'
alias upp='cd ../..'
alias uppp='cd ../../..'
alias ll='ls -alF'
alias g='git'
alias gs='git status'
alias gst='git status -sb'
alias gd='git diff -w'
alias gdd='git diff -w --word-diff'
alias ga='git add'
alias gr='git rm'
alias gc='git checkout'
alias gb='git branch'
alias rm="trash"
alias zsh_reload="exec $SHELL -l"

# tmux自動起動
# http://d.hatena.ne.jp/tyru/20100828/run_tmux_or_screen_at_shell_startup
is_screen_running() {
    # tscreen also uses this varariable.
    [ ! -z "$WINDOW" ]
}
is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}
shell_has_started_interactively() {
    [ ! -z "$PS1" ]
}
resolve_alias() {
    cmd="$1"
    while \
        whence "$cmd" >/dev/null 2>/dev/null \
        && [ "$(whence "$cmd")" != "$cmd" ]
    do
        cmd=$(whence "$cmd")
    done
    echo "$cmd"
}
 
 
if ! is_screen_or_tmux_running && shell_has_started_interactively; then
    for cmd in tmux tscreen screen; do
        if whence $cmd >/dev/null 2>/dev/null; then
            $(resolve_alias "$cmd")
            break
        fi
    done
fi




