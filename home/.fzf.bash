# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bradenhelmer/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/bradenhelmer/.fzf/bin"
fi

eval "$(fzf --bash)"
