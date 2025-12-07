# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/bradenhelmer/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random" it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="customRR"

OMB_USE_SUDO=true

OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)


source "$OSH"/oh-my-bash.sh

# My aliases
alias arc='ssh $SSHARC'
alias bsh='nvim ~/.bashrc'
alias c='clear'
alias cm='cmake --build build -t '
alias cndact='source ~/dev/tools/anaconda3/bin/activate'
alias cdnvim='cd ~/.config/nvim'
alias class='cd ~/dev/school'
alias dev='cd ~/dev'
alias e='exit'
alias egrep='egrep --color=auto'
alias envim='nvim ~/.config/nvim/init.lua'
alias exp='cd ~/dev/exploratory'
alias f='cd $(find ~/dev -mindepth 1 -type d -not -path "*/.git*" -not -path "*/build*" 2>/dev/null | fzf)'
alias ff='cd $(find ~/ -mindepth 1 -type d -not -path "*/.git*" -not -path "*/build*" 2>/dev/null | fzf)'
alias ga='git add .'
alias gcm='git commit -am'
alias gd='git diff .'
alias grep='grep --color=auto'
alias gst='git status'
alias l='ls -CF'
alias la='ls -A'
alias lc='llvm-config'
alias ll='ls -alF'
alias llvm='cd ~/dev/tools/llvm/llvm-project'
alias ls='ls --color=auto'
alias m='make'
alias nvim='/usr/local/bin/nvim'
alias vim='/usr/local/bin/nvim'
alias proj='cd ~/dev/projects'
alias pshconf='~/dev/tools/dotfiles/collect'
alias pps='pipenv shell'
alias py='python3'
alias python='python3'
alias src='source ~/.bashrc'
alias sudovim='sudo -E $(which nvim)'
alias tool='cd ~/dev/tools'
alias tx='tmux'
alias txnvim='nvim ~/.tmux.conf'
alias wez='nvim ~/.wezterm.lua'

export EDITOR=nvim
export VIMRUNTIME="/home/bradenhelmer/dev/tools/neovim/runtime/"

export CC=/usr/local/bin/clang
export CXX=/usr/local/bin/clang++

#PATH
export PATH="~/dev/tools/flutter/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export PATH="~/dev/tools/zig:$PATH"
export PATH="~/dev/tools/zls/zig-out/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="~/dev/tools/swift/usr/bin:$PATH"
export PATH="/usr/local/include:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/home/bradenhelmer/dev/tools/jdtls/bin:$PATH"
export PATH="/home/bradenhelmer/dev/tools/gradle-8.7/bin:$PATH"
export PATH="/usr/local/cuda-13.0/bin${PATH:+:${PATH}}"
export PATH="~/dev/tools/cmake/bin:$PATH"

# Linker
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/12:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda-13.0/lib64:$LD_LIBRARY_PATH

# JAVA
export JAVA_HOME=/usr/lib/jvm/java-18-openjdk-amd64
export CLASSPATH="/usr/local/lib:$CLASSPATH"
export CLASSPATH=".:/usr/local/lib/antlr-4.13.1-complete.jar:$CLASSPATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FZF Stuff
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_COMPLETION_TRIGGER="**"
export FZF_COMPLETION_OPTS='--border --info=inline'

# NCSU Arc 
export SSHARC="bthelmer@arc.csc.ncsu.edu"

# NVHPC
export INCLUDE_PATH="/usr/local/include:$INCLUDE_PATH"
export INCLUDE_PATH="/usr/include:$INCLUDE_PATH"

# Random
export TOOLS="/home/bradenhelmer/dev/tools"
export PROJECTS="/home/bradenhelmer/dev/projects"
export GNU_HEADERS="/usr/lib/gcc/x86_64-linux-gnu/12/include"
export GNU_LIBS="/usr/lib/gcc/x86_64-linux-gnu/12"

export LLVM_DEBUG_BUILD="/home/bradenhelmer/dev/projects/llvm-dev/debug"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/bradenhelmer/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

set +o noclobber

source /home/bradenhelmer/.local/share/bash-completion/completions/deno.bash
export PATH="$PATH:/home/bradenhelmer/.modular/bin"
. "$HOME/.cargo/env"
export PATH="/home/bradenhelmer/.pixi/bin:$PATH"
