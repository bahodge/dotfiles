export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="norm"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Custom

# asdf
. ${HOME}/.asdf/asdf.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# editor
export EDITOR=/usr/bin/nvim
alias vi="nvim"

# path
export GOPATH="$(go env GOPATH)"
export PATH="${PATH}:${GOPATH}/bin"
export PATH=$PATH
