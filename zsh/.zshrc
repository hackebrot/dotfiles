# Custom prompt indicating the exit code of previous command
PROMPT='%(?.🦊.🤖) %F{111}%n %F{reset_color}at %F{97}%~ %F{reset_color}%# '

if type brew &>/dev/null; then
  # Load homebrew completions https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit

  # Load z https://github.com/rupa/z
  . $(brew --prefix)/etc/profile.d/z.sh
fi

if command -v pyenv 1>/dev/null 2>&1; then
  # Load pyenv https://github.com/pyenv/pyenv
  eval "$(pyenv init -)"
fi


# Path config for Go
export GOPATH="${HOME}/Code/go"
export PATH="${GOPATH}/bin:${PATH}"
