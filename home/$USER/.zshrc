########################################
#Mod by LinGruby .zshrc               #
#######################################


# Colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# protect special characters
export LC_CTYPE="pl_PL.UTF-8"

#=====================================#
# Default colors                      #
#=====================================#

if [[ ! -z $COLORTERM ]] && [[ "$COLORTERM" == "truecolor" ]]; then
    export TERM="st-256color"
fi

#=====================================#
# LS colors                           #
#=====================================#

# activate color-completion
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

#=====================================#
# zsh settings                        #
#=====================================#

# History Settings
HISTSIZE=1000000
SAVEHIST=9000000
HISTFILE=~/.zsh_history

###### zsh-history-substring-search #######
if [[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
##########################################

# Fancy auto-complete
autoload -Uz compinit
zstyle ':completion:*' menu select=0
zmodload zsh/complist
zstyle ':completion:*' format '>>> %d'
compinit
_comp_options+=(globdots) # hidden files are included

# Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

#=====================================#
# Load zsh modules                    #
#=====================================#

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

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

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	zle-line-init() { echoti smkx; }; zle -N zle-line-init
	zle-line-finish() { echoti rmkx; }; zle -N zle-line-finish
fi

stty stop undef		# Disable ctrl-s to freeze terminal.

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
setopt prompt_subst
autoload -U colors && colors	# Load colors

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
	PUSER1="%F{blue}┌┤%B%F{red}%n%b%F{blue}├─"
	PUSER2="%F{blue}└┤%B%F{red}%h%b%F{blue}├─┤%B%F{yellow}%?%b%F{blue}├─❱❱❱%b%f %# "
	PUSER3="%F{blue}┤%B%F{red}%D{%a %d %b %Y} %F{blue}─%F{red} %D{%H%M%S}%b%F{blue}├─┤%B%F{red}%~%b%F{blue}├─"
else
	PUSER1="%F{blue}┌┤%B%F{yellow}%n%b%F{blue}├─"
	PUSER2="%F{blue}└┤%B%F{yellow}%h%b%F{blue}├─┤%B%F{red}%?%b%F{blue}├─❱❱❱%b%f %# "
	PUSER3="%F{blue}┤%B%F{yellow}%D{%a %d %b %Y} %F{blue}─%F{yellow} %D{%H%M%S}%b%F{blue}├─┤%B%F{yellow}%~%b%F{blue}├─"
fi

PROMPT='$PUSER1$PUSER3
$PUSER2 '


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
alias mk='mkinitcpio -P'
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
alias yt='ytfzf -t'
alias cls='printf "\033c && \033c"'



########### coloured manuals #############
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
##########################################


########## syntax highlighting ###########
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
##########################################

######## commands autosuggestion #########
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
##########################################

######## fast-syntax-highlighting ########
if [[ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
	source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi
##########################################

## load skim completion and keybindings ##
[ -f /usr/share/skim/key-bindings.zsh ] && source /usr/share/skim/key-bindings.zsh
[ -f /usr/share/skim/completion.zsh ] && source /usr/share/skim/completion.zsh
##########################################

# export THEME_HISTFILE=~/.theme_history
# [ -e "$THEME_HISTFILE" ] && theme.sh "$(theme.sh -l|tail -n1)"

# load $HOME/.zshrc.local to overwrite this zshrc
[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local

export TERM=st
export TIME_STYLE='+%a %d %b %Y %H%M%S'

# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
TIMEFMT="'$fg[green]%J$reset_color' time: $fg[blue]%*Es$reset_color, cpu: $fg[blue]%P$reset_color"
REPORTTIME=5

#=====================================#
# Sources                             #
#=====================================#

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

cd
