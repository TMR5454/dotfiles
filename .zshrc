#
# .zshrc
#

export LANG=ja_JP.UTF-8
#export LANG=C

autoload -U colors
colors

# key bind emacs like
bindkey -e

# cd diectory name
setopt auto_cd

# add directory stack cd
setopt auto_pushd

cdpath=(~)
chpwd_functions=($chpwd_functions dirs)


# history
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
setopt no_flow_control


# prompt
setopt prompt_subst
setopt prompt_percent
setopt transient_rprompt

#PROMPT='[%B%F{green}%n%f%F{blue}@%f%F{green}%m%f%b] $ '
PROMPT=$'[%B%F{green}%n%f%F{blue}@%f%F{green}%m%f%b]'$'%% '
RPROMPT='[%B%F{yellow}%~%f%b]'

# 補完
## 初期化
autoload -U compinit
compinit

# Ctrl-i : tab
# Ctrl-f, Ctrl-b, Ctrl-d, Ctrl-u, Ctrl-m
zstyle ':completion:*:default' menu select=2

zstyle ':completion:*:messages' format '%B%F{yellow}%d%f%b'$DEFAULT
zstyle ':completion:*:warnings' format '%B%F{red}No matches for: %f%b''%B%F{yellow}%d%f%b'$DEFAULT
zstyle ':completion:*:corrections' format '%B%F{yellow}%d%f %F{red}(errors: %e)%f%b'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{yellow}%BCompleting %d:%b%f'$DEFAULT
zstyle ':completion:*:options' description 'yes'

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# オブジェクトファイルとか中間ファイルとかはfileとして補完させない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~'


# セパレータを設定する
zstyle ':completion:*' list-separator '-->'

# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true

# 変数の添字を補完する
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters


# 名前で色を付けるようにする
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


## 補完候補がなければより曖昧に候補を探す。
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 補完方法の設定。指定した順番に実行する。
### _oldlist 前回の補完結果を再利用する。
### _complete: 補完する。
### _match: globを展開しないで候補の一覧から補完する。
### _ignored: 補完候補にださないと指定したものも補完候補とする。
### _approximate: 似ている補完候補も補完候補とする。
### _prefix: カーソル以降を無視してカーソル位置までで補完する。
#zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix

## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
## 詳細な情報を使う。
zstyle ':completion:*' verbose yes

# 補完に関するオプション
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs
# 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt list_types
# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu
# カッコの対応などを自動的に補完
setopt auto_param_keys
# カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt always_last_prompt
## カーソル位置で補完する。
setopt complete_in_word
## globを展開しないで候補の一覧から補完する。
setopt glob_complete
## 補完時にヒストリを自動的に展開する。
setopt hist_expand
## 補完候補がないときなどにビープ音を鳴らさない。
setopt no_beep
## 辞書順ではなく数字順に並べる。
setopt numeric_glob_sort


# 展開
## --prefix=~/localというように「=」の後でも
## 「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst
## 拡張globを有効にする。
## glob中で「(#...)」という書式で指定する。
setopt extended_glob


setopt long_list_jobs

REPORTTIME=3

watch="all"
#log

setopt ignore_eof

WORDCHARS=${WORDCHARS:s,/,,}
WORDCHARS="${WORDCHARS}|"





### alias

alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias la='ls --color=auto -a'
alias lla='ls --color=auto -l -a'

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias e='emacs -reverse'
alias l='ls'
alias s='ls'
alias clean='rm -f *~'

alias grep='grep --color=auto'

# 色付きのless
alias less='less -R'


# This script will look-up command in the database and suggest
# installation of packages available from the repository
#if [[ -x /usr/lib/command-not-found ]] ; then
#    function command_not_found_handler() {
#       /usr/lib/command-not-found --no-failure-msg -- $1
#    }
#fi

#add by TMR
alias f='firefox&'

# For Cygwin.
# go to desktop
if [ "$( uname -o )" = 'Cygwin' ]; then
  # Is not changed home directory for some reason, when login shell is Zsh.
  alias cdd="cd '/cygdrive/c/Documents and Settings/$USER/Desktop'"
  alias ccd="cd '/cygdrive/c/Documents and Settings/$USER/Desktop'"
fi

# For WSL
if [[ "$( uname -a )" =~ 'Microsoft' ]] ; then
  # Is not changed home directory for some reason, when login shell is Zsh.
  export WINDOWS_USER="$(/mnt/c/Windows/System32/cmd.exe /c 'echo %USERNAME%' | sed -e 's/\r//g')"
  alias cdd="cd '/mnt/c/Users/${WINDOWS_USER}/Desktop'"
  alias ccd="cd '/mnt/c/Users/${WINDOWS_USER}/Desktop'"
fi


