#######################################
#Mod by LinGruby .zshrc               #
#######################################

# protect special characters
export LC_CTYPE="pl_PL.UTF-8"

#=====================================#
# Default colors                      #
#=====================================#

if [[ ! -z $COLORTERM ]] && [[ "$COLORTERM" == "truecolor" ]]; then
    export TERM="rxvt-unicode-256color"
fi

#=====================================#
# LS colors                           #
#=====================================#

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.7z=01;31:*.xz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:';

#=====================================#
# zsh settings                        #
#=====================================#

# avoid beeping
setopt nobeep
# cd when only a path is given
setopt autocd

########## syntax highlighting ########### {{{
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
########################################## }}}

######## commands autosuggestion ######### {{{
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
########################################## }}}

######## fast-syntax-highlighting ######## {{{
if [[ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
	source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi
########################################## }}}

#=====================================#
# History settings                    #
#=====================================#

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt append_history			# default
setopt BANG_HIST				# Treat the '!' character specially during expansion.
setopt extended_history			# Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY		# Write to the history file immediately, not when the shell exits.
setopt share_history			# Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST	# Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS			# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS		# Delete old recorded entry if new entry is a duplicate.
setopt histignorealldups
setopt HIST_FIND_NO_DUPS		# Do not display a line previously found.
setopt HIST_IGNORE_SPACE		# Don't record an entry starting with a space.
setopt histignorespace
setopt HIST_SAVE_NO_DUPS		# Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS		# Remove superfluous blanks before recording entry.
setopt HIST_VERIFY				# Don't execute immediately upon history expansion.

# History search {{{
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

if [[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# }}}

#=====================================#
# Load zsh modules                    #
#=====================================#

# Basic auto/tab complete:
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin


# End of lines added by compinstall

zstyle :compinstall filename '${ZDOTDIR}/.zshrc'
zstyle ':completion:*' menu select

zstyle ':completion:*' rehash true

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                           /usr/local/bin  \
                                           /usr/sbin       \
                                           /usr/bin        \
                                           /sbin           \
                                           /bin


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'underline' ]]; then
    echo -ne '\e[3 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'underline' ]]; then
    echo -ne '\e[3 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[3 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[3 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[3 q' ;}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

bindkey -s '^o' 'lfcd\n'  # zsh

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#=====================================#
# Load config                         #
#=====================================#

if [[ -e $HOME/.zshrc.config ]]; then
    source $HOME/.zshrc.config
elif [[ -e /etc/zsh/.zshrc.config ]]; then
    source /etc/zsh/.zshrc.config
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_prompt_command
fi

#=====================================#
# EDITOR is nano                      #
#=====================================#

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nano'
fi

#=====================================#
# Default prompt                      #
#=====================================#

# prompt settings
#promptinit
#prompt walters
setopt prompt_subst

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
	PUSER1="%F{red}┌─┤%B%n%f %F{red}%Bat %B%m├─"
	PUSER2="%F{red}└─┤%h├──┤%?├─%b%f %#"
	PUSER3="%F{red}─┤%D{%a %d %b %Y} ─ %D{%H%M%S}├─"
else
	PUSER1="%F{yellow}┌─┤%B%n%f %F{yellow}%Bat %B%m├─"
	PUSER2="%F{yellow}└─┤%h├──┤%?├─%b%f %#"
	PUSER3="%F{yellow}─┤%D{%a %d %b %Y} ─ %D{%H%M%S}├─"
fi

PROMPT='%B$PUSER1%B$PUSER3%B─┤~├─
%B$PUSER2 '


#=====================================#
# ALIAS                               #
#=====================================#

alias paksyyu='pak -Syyu'
alias paksyu='pak -Syu'
alias paksyup='pak -SyuP'
alias paks='pak -S'
alias paksa='pak -SA'
alias pakvcs='pak --vcs'
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
alias pakc='pak -C'
alias pacup='pacman -Syu'
alias pacum='pacman -Scc --noconfirm'
alias repoup='repo-add /home2/custompkgs/custom.db.tar.gz /home2/custompkgs/*.pkg.tar'
alias grubup='grub-mkconfig -o /boot/grub/grub.cfg'
alias sa='systemd-analyze'
alias sab='systemd-analyze blame'
alias lx='lxappearance'
alias q5='qt5ct'
alias neo='neofetch'
alias scr='screenfetch'
alias al='alsi -l'
alias cm='cmatrix'
alias pogoda='curl -H "Accept-Language: pl" wttr.in/Łódź'
alias gitu='git add . && git commit && git push'

#=====================================#
# Sources                             #
#=====================================#

#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

POWERLEVEL10K_COLOR_SCHEME='dark'
POWERLEVEL10K_CONTEXT_DEFAULT_BACKGROUND='0'
POWERLEVEL10K_CONTEXT_DEFAULT_FOREGROUND='10'
POWERLEVEL10K_STATUS_OK_BACKGROUND='8'
POWERLEVEL10K_VCS_CLEAN_BACKGROUND='11'
POWERLEVEL10K_VCS_UNTRACKED_BACKGROUND='8'
POWERLEVEL10K_VCS_MODIFIED_BACKGROUND='10'
POWERLEVEL10K_VCS_MAX_SYNC_LATENCY_SECONDS='0.05'
POWERLEVEL10K_VI_INSERT_MODE_STRING='INSERT'
POWERLEVEL10K_VI_COMMAND_MODE_STRING='NORMAL'﻿

########### coloured manuals ############# {{{
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}
########################################## }}}

export TERM=rxvt-unicode-256color
export TIME_STYLE='+%a %d %b %Y %H%M%S'

# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
REPORTTIME=5


cd
