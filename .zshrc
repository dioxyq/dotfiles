# zsh base config
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
unsetopt autocd
bindkey -v


# prezto base config
zstyle :compinstall filename '/home/ava/.zshrc'

autoload -Uz compinit
compinit

# prezto theme
autoload -Uz promptinit
promptinit
prompt skwp


# zoxide
eval "$(zoxide init zsh)"


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init -)"


# fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow"
export FZF_DEFAULT_OPTS=""
export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow"
source <(fzf --zsh)


# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


# xdg-open wrapper
function open() {
    if [ -z "$1" ]; then
        echo "usage: open {file}"
        return 1
    fi
    local filetype=$(xdg-mime query filetype "$1")
    local app=$(xdg-mime query default "$filetype")
    if [ -z "$app" ]; then
        local default
        read default"?Enter a default app for filetype $filetype: " && [ ! -z "$default" ] || return 1
        xdg-mime default "$default".desktop "$filetype"
        app=$(xdg-mime query default "$filetype")
    fi
    if [[ "$app" == "nvim"* ]]; then
        xdg-open "$1"
    else
        (&>/dev/null xdg-open "$1" &)
    fi
}


# aliases
alias win="systemctl reboot --boot-loader-entry=auto-windows"
alias o='open'
alias ls='eza'
alias ll='eza -l'
alias la='eza -la'
alias ..='cd ..'
alias vpnu="nmcli connection up us-free-1.protonvpn.udp"
alias vpnd="nmcli connection down us-free-1.protonvpn.udp"
alias freecad="QT_QPA_PLATFORM=xcb freecad"


# environment variables
EDITOR=nvim
