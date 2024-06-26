# starts tmux if not already running (checked via $TMUX env var)
# if [ "$TMUX" = "" ]; then /opt/homebrew/bin//tmux; fi

#Enable Command-Correction
setopt correct

# History Setup
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
HISTFILE=$HOME/.zhistory
HISTSIZE=9999999999
SAVEHIST=$HISTSIZE

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
export ZSH_FZF_HISTORY_SEARCH_BIND='^f'
export PYTHONWARNINGS="ignore"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6c7086'
set -g @tmux_window_dir_programs "['nvim', 'vim', 'vi', 'git', 'pnpm']"

SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

if [[ -n ${ZSH_VERSION-} ]]; then
  autoload -U +X compinit && if [[ ${ZSH_DISABLE_COMPFIX-} = true ]]; then
    compinit -u
  else
    compinit
  fi
  autoload -U +X bashcompinit && bashcompinit
fi



if [[ $(uname) == "Darwin" ]]; then
    echo "Detected macOS"

    eval "$(/opt/homebrew/bin/fnm env --use-on-cd)"
    
    # Java Commands
    alias j12="export JAVA_HOME=`/usr/libexec/java_home -v 12`; java -version"
    alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
    alias j10="export JAVA_HOME=`/usr/libexec/java_home -v 10`; java -version"
    alias j9="export JAVA_HOME=`/usr/libexec/java_home -v 9`; java -version"
    alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
    export JAVA_HOME=$(/usr/libexec/java_home -v 11)
    export ZSH="/Users/fabiobaser/.oh-my-zsh"

elif command -v apt > /dev/null; then
    echo "Detected Debian"

    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) # evalutes location of brew so it can be executed by simply calling brew
else
    echo 'Unknown OS!'
fi


# fnm init

#ZSH_THEME=spaceship

#Env Variables
export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/bin/:/usr/local/Cellar:/opt/Sencha/Cmd:/opt/homebrew/Cellar:$PATH
export EDITOR="/opt/homebrew/bin/nvim"
export LANG=de_DE.UTF-8
export FZF_DEFAULT_COMMAND="fd -H -t f -E .git -E .DS_Store"
export DISABLE_AUTO_TITLE=true
# export ZSH_TMUX_AUTO_TITLE_TARGET="window" # plugin tmux-auto-title should change the window not 'pane'
# export ZSH_TMUX_AUTO_TITLE_IDLE_TEXT="%pwd"

#COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` ad `.`
zstyle ':fzf-tab:*' switch-group ',' '.'


fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
# source $ZSH/oh-my-zsh.sh

# brew bundle install

alias v="nvim --listen /tmp/nvimsocket"
alias zv="z $1"
alias vrc="nvim ~/.config/nvim/"
alias zshconfig="nvim ~/.zshrc"
alias zshrc="zshconfig"
alias zshreload="source ~/.zshrc"

alias l="exa -1 --icons --group-directories-first"
alias la="exa --icons -a --group-directories-first"
alias ll="exa -T -L 3 --icons --group-directories-first --git-ignore -I node_modules"
alias lla="exa -T -L 3 -a --icons --group-directories-first -I node_modules"
alias lll="exa -T -L 3 --icons --group-directories-first"

alias c="clear;export NEW_LINE_BEFORE_PROMPT=0; printf '\e[3J'" #tput reset

# NPM Helper
alias list_node_module_dirs="find . -name 'node_modules' -type d -prune"
alias rm_node_modules_recursive="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"

alias df='lg -g $HOME/.dotfiles -w $HOME'
alias dfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

#Mac Specific Commands
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool FALSE;killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool TRUE;killall Finder"
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO"
alias cleardock="defaults write com.apple.dock persistent-apps -array; killall Dock"


eval "$(sheldon source)"

abbrev-alias lg="lazygit"
abbrev-alias ld="lazydocker"

abbrev-alias n="npm"
abbrev-alias -r ni="n install"
abbrev-alias -r nr="n run"

abbrev-alias bi="brew install"
abbrev-alias -r bic="bi --cask"

abbrev-alias t="tmux"
abbrev-alias -r tmuxreload="t source-file ~/.tmux.conf"
abbrev-alias tp="tmuxp load"
abbrev-alias -r tpf="tp frontend"
abbrev-alias -r tpc="tp collector"

abbrev-alias p="pnpm"
abbrev-alias -r pi="p install"
abbrev-alias -r pir="pi -r"
abbrev-alias -r px="p nx"
abbrev-alias -r pxr="px run"
abbrev-alias -r pxrm="px run-many --target"

abbrev-alias shad="sheldon add --github"

abbrev-alias d="docker"
abbrev-alias -r db="d build"

eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/Users/fabiobaser/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
SPACESHIP_PROMPT_ASYNC=FALSE

# fnm
export PATH="/Users/fabiobaser/Library/Application Support/fnm:$PATH"
eval "`fnm env`"

# bun completions
[ -s "/Users/fabiobaser/.bun/_bun" ] && source "/Users/fabiobaser/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
