# Run X11 in tty1
[ "$(tty)" = "/dev/tty1"  ] && ! pgrep -x Xorg >/dev/null && exec startx -- vt1 &> /dev/null

# Apperance
autoload -U colors && colors
PS1=" %B%F{8}%~%f%b "
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# History setting
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Functions
ud () {
  doas pacman -Syu #ADD replace by aur helper
  updatedb
  sh ~/repos/dotfiles/update_dotfiles.sh
}
of () { 
    #fzf | xargs -r $EDITOR 
    fzf | xargs -0 xdg-open 
}
od () {
    #FIX od function
    ls -1d */ | fzf | xargs -r cd
}
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
wat () {
    while true
    do
        clear
        $1
        sleep 2 
    done
}

# Alias 
alias sudo='doas'
alias pac='doas pacman'
alias ls='ls --sort=time --color=auto --reverse'
alias la='ls --sort=time --color=auto -a --reverse'
alias ll='ls --sort=time --color=auto -l -a -h --reverse'
alias grep='grep --color=auto'
alias ..='cd ..'
alias v='nvim'
alias j='jrnl'
alias jp='jrnl philosophy:'
alias jd=''
alias c='calcurse'
alias open='xdg-open'
alias install='doas xbps-install'
alias query='doas xbps-query'
alias remove='doas xbps-remove'

# Vim mode
bindkey -v
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd  ]] || [[ $1 = 'block'  ]]
	then
	  echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main  ]] || [[ ${KEYMAP} == viins  ]] || [[ ${KEYMAP} = ''  ]] || [[ $1 = 'beam'  ]]
	then
		 echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Autostart
#calcurse -t | tail -n +2 | head -1
