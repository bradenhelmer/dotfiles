# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/bradenhelmer/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random" it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="modern"

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: 
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# My aliases
alias bsh='nvim ~/.bashrc'
alias c='clear'
alias ccs='~/ti/ccstheia100/ccs/theia/ccstudio'
alias cic='bind "set completion-ignore-case on"' # cic:          Make tab-completion case-insensitive
alias class='cd ~/class'
alias dev='cd ~/dev'
alias e='exit'
alias eclang='cd ~/dev/tools/llvm-project/clang'
alias egrep='egrep --color=auto'
alias envim='nvim ~/.config/nvim/legacy.vim'
alias fgrep='fgrep --color=auto'
alias frc='flutter run -d chrome'
alias ga='git add .'
alias gcm='git commit -am'
alias gd='git diff .'
alias grep='grep --color=auto'
alias gst='git status'
alias gtw='gnome-tweaks'
alias l='ls -CF'
alias la='ls -A'
alias lc='llvm-config'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias nvim='/usr/local/bin/nvim'
alias osrunh='python3 Bootstrap.py -parameters params.high.txt'
alias osrunl='python3 Bootstrap.py -parameters params.low.txt'
alias osrunm='python3 Bootstrap.py -parameters params.medium.txt'
alias proj='cd ~/dev/projects'
alias pshconf='~/dev/tools/src_cfgs/collect'
alias py='python3'
alias src='source ~/.bashrc'                # src:          Reload .bashrc file
alias tool='cd ~/dev/tools'
alias zig='~/dev/tools/zig/build/stage3/bin/zig'
alias zls='~/dev/tools/zls/zig-out/bin/zls'

#PATH
export PATH=~/dev/tools/flutter/bin:$PATH
export PATH=~/.local/bin:$PATH

export CC=/usr/local/bin/clang
export CXX=/usr/local/bin/clang++
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"
