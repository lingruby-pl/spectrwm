#######################################
# Mod by LinGruby .zshrc              #
#######################################

# hikari-zsh -  A pure and minimalistic zsh with special shortcuts
#
# Copyright (c) 2021 by Christian Rebischke <chris@shibumi.dev>

# load $HOME/.zshrc.pre to overwrite defaults
[[ -r ${HOME}/.zshrc.pre ]] && source ${HOME}/.zshrc.pre


# Colors!
set black       = '%{#010101}'
set red         = '%{#D02038}'
set green       = '%{#008800}'
set yellow      = '%{#fabd2f}'
set blue        = '%{#0080F8}'
set purple      = '%{#cd00cd}'
set megenta     = '%{#cd00cd}'
set cyan        = '%{#00FFFF}'
set white       = '%{#F5F5F5}'
set nocolor     = '%{#F5F5F5}'

# man help colors and man colors replace by batman from bat-extras
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# protect special characters
export LANG="pl_PL"
export LC_ALL="pl_PL.UTF-8"
export TERM=st
export TIME_STYLE="+%a %d %b %Y %H%M%S"
export FZF_BASE=/usr/share/fzf

# Setopts
# allow prompt substitution
setopt prompt_subst
# append history list to the history file; this is the default but we make sure
# because it's required for share_history.
setopt append_history
# import new commands from the history file also in other zsh-session
setopt share_history
# save each command's beginning timestamp and the duration to the history file
setopt extended_history
# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups
# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace
# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob
# display PID when suspending processes as well
setopt longlistjobs
# try to avoid the 'zsh: no matches found...'
setopt nonomatch
# report the status of backgrounds jobs immediately
setopt notify
# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all
# not just at the end
setopt completeinword
# Don't send SIGHUP to background processes when the shell exits.
setopt nohup
# make cd push the old directory onto the directory stack.
setopt auto_pushd
# avoid "beep"ing
setopt nobeep
# don't push the same dir twice.
setopt pushd_ignore_dups
# * shouldn't match dotfiles. ever.
setopt noglobdots
# use zsh style word splitting
setopt noshwordsplit
# enable dir-stack
setopt autopushd pushdminus pushdsilent pushdtohome
# Remove duplicate entries
setopt pushdignoredups
# Shortcuts for directories e.g. hash -d
setopt autocd
# enable interactivecomments
setopt interactivecomments
# Disable flowcontrol
stty -ixon

# Autoload
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz compinit

# History Settings
HISTSIZE=99999999
SAVEHIST=99999999
HISTFILE=~/.zsh_history
HISTTIMEFORMAT="%F %T "

# zstyles
zstyle ':completion:*' menu select
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes false
zstyle ':vcs_info:git*' formats "%8.8i %b "
zstyle ':vcs_info:git*' actionformats "%8.8i %b %F{red}%a %m%f "
zstyle ':vcs_info:git*' patch-format "%8.8p "
zstyle ':vcs_info:svn*:*' get-revision true
zstyle ':vcs_info:svn*:*' check-for-changes false
zstyle ':vcs_info:svn*' formats "%b %m "
zstyle ':vcs_info:svn*' actionformats "%b/%a %m "

# completion dump file
COMPDUMPFILE=${COMPDUMPFILE:-${ZDOTDIR:-${HOME}}/.zcompdump}
# activate completion
compinit -d ${COMPDUMPFILE} || print 'Notice: no compinit available :('

# Smart Functions
# smart cd function, allows switching to /etc when running 'cd /etc/fstab'
function cd () {
    if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
        [[ ! -e ${1:h} ]] && return 1
        print "Correcting ${1} to ${1:h}"
        builtin cd ${1:h}
    else
        builtin cd "$@"
    fi
}

# Behaviour
# custom keybindings for string operations
toggleSingleString() {
  LBUFFER=`echo $LBUFFER | sed "s/\(.*\) /\1 '/"`
  RBUFFER=`echo $RBUFFER | sed "s/\($\| \)/' /"`
  zle redisplay
}
zle -N toggleSingleString

toggleDoubleString() {
  LBUFFER=`echo $LBUFFER | sed 's/\(.*\) /\1 "/'`
  RBUFFER=`echo $RBUFFER | sed 's/\($\| \)/" /'`
  zle redisplay
}
zle -N toggleDoubleString

clearString() {
  LBUFFER=`echo $LBUFFER | sed 's/\(.*\)\('"'"'\|"\).*/\1\2/'`
  RBUFFER=`echo $RBUFFER | sed 's/.*\('"'"'\|"\)\(.*$\)/\1\2/'`
  zle redisplay
}
zle -N clearString

#overwrite alt+backspace
backward-kill-dir () {
    local WORDCHARS='*?-[]~=&;!#$%^(){}<>|_.'
    zle backward-kill-word
}
zle -N backward-kill-dir

# backward half word
backward-half-word () {
    local WORDCHARS='*?-[]~=&;!#$%^(){}<>|_.'
    zle backward-word
}
zle -N backward-half-word

# forward half word
forward-half-word () {
    local WORDCHARS='*?-[]~=&;!#$%^(){}<>|_.'
    zle forward-word
}
zle -N forward-half-word

# run command line as user root via sudo:
function sudo-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N sudo-command-line

# insert datetime on key shortcut
function insert-datestamp () { LBUFFER+=${(%):-'%D{%Y-%m-%d}'}; }
zle -N insert-datestamp

# get last modified file
function get-last-modified-file () {
	LAST_FILE=$(\ls -t1p | grep -v / | head -1)
	LBUFFER+=${(%):-$LAST_FILE}
}
zle -N get-last-modified-file

# jump behind the first word on the cmdline
# useful to add options.
function jump_after_first_word () {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[1]}}+1
    fi
}
zle -N jump_after_first_word

# Custom Prompt

if [[ ! -f ~/.zshcolor ]]; then
	declare -a colors
	colors=('cyan' 'green' 'yellow' 'magenta' 'red' 'blue')
	host_hash=$(hostnamectl --static | md5sum | tr -d '[a-fA-F]' | cut -d ' ' -f 1 | head -c 5)
	prompt_color=$colors[$((host_hash % ${#colors[@]} + 1))]
	echo -n $prompt_color > ~/.zshcolor
else
	prompt_color=$(cat ~/.zshcolor)
fi

prompt_dir_writeable() {
    if [ -w $PWD ]; then
        echo "blue"
    else
        echo "red"
    fi
}

prompt_git_dirty() {
    if ! command -v git &> /dev/null; then
	    exit
    fi
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [ -z "$(command git status --porcelain --ignore-submodules -unormal)" ]; then
            echo "green"
        else
            echo "yellow"
        fi
    else
        echo "blue"
    fi
}

prompt_get_namespace() {
	if ! command -v kubens &> /dev/null; then
		exit
	fi
	echo "$(kubens -c)"
}

prompt_get_context() {
	if ! command -v kubectx &> /dev/null; then
		exit
	fi
	echo "$(kubectx -c)"
}

git_prompt() {
	BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
	if [ ! -z "${BRANCH}"  ]; then
		echo -n "%F{yellow}${BRANCH}"
		if [ ! -z "$(git status --short)"  ]; then
			echo " %F{red}X "
		fi
	fi
}

if [[ $(id -u) = 0 ]]; then
	PUSER1="%B%F{red}%n%b%f"
	PUSER2="%B%F{blue}%~%b%f"
	PUSER3="%B%F{green}( %B%F{blue}%h%b %B%F{red}%?%b%f%B%F{green} )%b%f  %B%F{blue}%D{%a %d %b %Y} ─ %D{%H%M%S}%b%f"
	PUSER4="%B%F{blue}=->%b%f "
else
	PUSER1="%B%F{yellow}%n%b%f"
	PUSER2="%B%F{blue}%~%b%f"
	PUSER3="%B%F{green}( %B%F{blue}%h%b %B%F{red}%?%b%f%B%F{green} )%b%f  %B%F{blue}%D{%a %d %b %Y} ─ %D{%H%M%S}%b%f"
	PUSER4="%B%F{blue}=->%b%f "
fi

NEWLINE=$'\n'
PROMPT=' $PUSER1  $PUSER2  $(git_prompt)  $PUSER3 ${NEWLINE} $PUSER4 '
#RPROMPT='%B%F{green}( %B%F{blue}%h%b %B%F{red}%?%b%f%B%F{green} )%b%f  %B%F{blue}%D{%a %d %b %Y} ─ %D{%H%M%S}%b%f'

# Bindkeys
bindkey -e
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey "^xd" insert-datestamp
bindkey "^xs" sudo-command-line
bindkey "^x1" jump_after_first_word
bindkey "^x'" toggleSingleString
bindkey '^x"' toggleDoubleString
bindkey '^x;' clearString
bindkey '^xc' copy-prev-shell-word
bindkey '^xl' get-last-modified-file
bindkey '^[^?' backward-kill-dir
bindkey '\e[1;3D' backward-half-word
bindkey '\e[1;3C' forward-half-word

#=====================================#
# ALIAS                               #
#=====================================#

alias paksyyu='pak -Syyu'
alias paksyyuu='pak -Syyuu'
alias paksyu='pak -SU'
alias paksyup='pak -SyuP'
alias paks='pak -S'
alias paksa='pak -SA'
alias pakvcs='pak --vcs $(pak -Slq custom | grep "\-git")'
alias pakna='pak -NA'
alias paknp='pak -NP'
alias pakr='pak -R'
alias pakrunsc='pak -Runsc'
alias pakSs='pak -Ss'
alias pakSS='pak -SS'
alias pakQi='pak -Qi'
alias pakpy='pak -SyP'
alias pakp='pak -SP'
alias paksc='pak -Sc'
alias pakscc='pak -Scc'
alias pakc='pak -C'
alias pacup='pacman -Syu'
alias pacum='pacman -Scc --noconfirm'
alias repoup='repo-add /dane/pkgs/custom.db.tar.zst /dane/pkgs/*.pkg.tar'
alias grubup='grub-mkconfig -o /boot/grub/grub.cfg'
alias grubinstall='grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch_Linux'
alias mk='mkinitcpio -P'
alias dracut='dracut-rebuild'
alias sa='systemd-analyze'
alias sab='systemd-analyze blame'
alias sacc='systemd-analyze critical-chain'
alias lx='lxappearance'
alias q5='qt5ct'
alias q6='qt6ct'
alias neo='neofetch'
alias al='alsi -l'
alias pf='pfetch'
alias tf='tfetch'
alias cm='cmatrix'
alias pogoda='curl -H "Accept-Language: pl" wttr.in/Łódź'
alias gitu='git add . && git commit && git push'
alias gitlist='git rev-list --count HEAD'
alias yt='ytfzf -t'
alias cls='printf "\033c && \033c"'
alias ls='exa --time-style default'
alias ll='exa --time-style default -bghHliS'
alias lla='exa --time-style default -bghHliSa'
alias cat="bat"
alias man='batman'
alias tarball='updpkgsums && makepkg -sirc --sign && mkaurball -f'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias ping='ping -c 10'
alias mpkg='updpkgsums && makepkg -sirc --sign'

# load fast-syntax-highlighting
[ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] && source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# load zsh-history-substring-search
[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ] && source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# load commands autosuggestion
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# load zsh-you-should-use
[ -f /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh ] && source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh

# load zsh-autopair
[ -f /usr/share/zsh/plugins/zsh-autopair/autopair.zsh ] && source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh

# load skim completion and keybindings
[ -f /usr/share/skim/key-bindings.zsh ] && source /usr/share/skim/key-bindings.zsh
[ -f /usr/share/skim/completion.zsh ] && source /usr/share/skim/completion.zsh

# Bindkeys for zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# load $HOME/.zshrc.local to overwrite this zshrc
[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local

# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
TIMEFMT="'$fg[green]%J$reset_color' time: $fg[blue]%*Es$reset_color, cpu: $fg[blue]%P$reset_color"
REPORTTIME=5

#pfetch

cd
