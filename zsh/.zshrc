# History file and secure permissions
HISTFILE=~/.zsh_history
[[ -f $HISTFILE ]] || touch $HISTFILE
chmod 600 $HISTFILE

# Load version control info
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{reset_color}on %F{red}%b%F{reset_color} '

# Shell options
setopt AUTO_CD                   # Change directory without cd
setopt EXTENDED_GLOB             # Extended globbing
setopt NOTIFY                    # Report status of background jobs immediately
setopt PROMPT_SUBST              # Enable parameter expansion in prompts

# History settings
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY            # Share history between sessions
setopt HIST_IGNORE_SPACE        # Don't record commands starting with space
setopt HIST_VERIFY              # Show command with history expansion before running it
setopt INC_APPEND_HISTORY       # Append history immediately
setopt HIST_EXPIRE_DUPS_FIRST   # Remove duplicates first when HISTSIZE exceeded
setopt HIST_FIND_NO_DUPS        # Don't show duplicates in search
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks from history
export HIST_IGNORE_PATTERN='(pass|secret|token|key|auth|ssh|gpg|cert)'
zstyle ':history:*' timestamp '%F %T'

# Load Homebrew completions if Homebrew is installed
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  [[ "$FPATH" != *"$HOMEBREW_PREFIX/share/zsh/site-functions"* ]] && \
    FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"
fi

# Initialize completion system
autoload -Uz compinit
compinit                     # Secure initialization of completion system

# Key bindings for macOS Terminal
bindkey '^A' beginning-of-line                     # Ctrl + A: start of line
bindkey '^E' end-of-line                           # Ctrl + E: end of line
bindkey '^[b' backward-word                        # Option + Left: back one word
bindkey '^[f' forward-word                         # Option + Right: forward one word
bindkey '^W' backward-kill-word                    # Ctrl + W: delete previous word
bindkey '^U' kill-whole-line                       # Ctrl + U: clear entire line
bindkey '^R' history-incremental-search-backward   # Ctrl + R: reverse search
bindkey '^P' up-line-or-history                    # Ctrl + P: previous command
bindkey '^N' down-line-or-history                  # Ctrl + N: next command
bindkey '^[d' kill-word                            # Option + D: delete word forward

# Custom prompt with git branch and exit code indicator
PROMPT='%(?.🐳.😵) %F{yellow}%n %F{reset_color}at %F{blue}%2~ %(?.${vcs_info_msg_0_}.)%F{reset_color}%# '

# Config for Go projects
export GOPATH="${HOME}/Code/go"
export GOBIN="${GOPATH}/bin"
export PATH="${GOBIN}:${PATH}"
