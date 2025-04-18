#! bash oh-my-bash.module

# This theme attempts to replicate the default "robbyrussell" theme from ohmyzsh:
#  https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/robbyrussell.zsh-theme

function _omb_theme_PROMPT_COMMAND() {
    if [[ "$?" == 0 ]]; then
        local arrow_color="${_omb_prompt_bold_green}"
    else
        local arrow_color="${_omb_prompt_bold_brown}"
    fi

    local base_directory="${_omb_prompt_bold_teal}\W${_omb_prompt_reset_color}"

    local GIT_THEME_PROMPT_PREFIX="${_omb_prompt_bold_navy}git:(${_omb_prompt_bold_brown}"
    local SVN_THEME_PROMPT_PREFIX="${_omb_prompt_bold_navy}svn:(${_omb_prompt_bold_brown}"
    local HG_THEME_PROMPT_PREFIX="${_omb_prompt_bold_navy}hg:(${_omb_prompt_bold_brown}"
    local SCM_THEME_PROMPT_SUFFIX="${_omb_prompt_reset_color}"
    local SCM_THEME_PROMPT_CLEAN="${_omb_prompt_bold_navy})${_omb_prompt_reset_color}"
    local SCM_THEME_PROMPT_DIRTY="${_omb_prompt_bold_navy}) ${_omb_prompt_olive}✗${_omb_prompt_reset_color}"

    local arrow="${arrow_color}➜${_omb_prompt_reset_color}"

    PS1="${arrow}  ${base_directory} "

    # Check if inside a Python environment
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local python_env="${_omb_prompt_bold_green}($(basename "$VIRTUAL_ENV" | sed 's/-.*$//'))${_omb_prompt_reset_color}"
        PS1+="${python_env} "
    fi

    # Check if inside a Pixi/Magic/Mojo environment
    if [[ "$PIXI_IN_SHELL" == 1 ]]; then
      local mojo_env="${_omb_prompt_bold_green}($(basename "$PIXI_PROJECT_NAME"))${_omb_prompt_reset_color}"
      PS1+="${mojo_env} "
    fi

    if [[ -n "$SSH_CLIENT" ]]; then
        local ssh_str="${_omb_prompt_bold_blue}("$USER"@SSH)${_omb_prompt_reset_color}"
        PS1="${ssh_str}"+" ${PS1}"
    fi

    local scm_info=$(scm_prompt_info)

    PS1+=${scm_info:+$scm_info }
    PS1+=${_omb_prompt_normal}
}

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
