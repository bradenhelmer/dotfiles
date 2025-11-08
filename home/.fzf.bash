# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bradenhelmer/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/bradenhelmer/fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/bradenhelmer/fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/bradenhelmer/fzf/shell/key-bindings.bash"
