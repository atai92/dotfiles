# Source env file which contains all the environment variables
[ -f ~/.env ] && source ~/.env

eval "$(oh-my-posh init bash --config ~/dotfiles/.config/oh-my-posh/conf.toml)"

# Sets up FZF tab completion from a separate source
source ~/fzf-tab-completion/bash/fzf-bash-completion.sh

# Source all files in ~/.funcs
for file in $(find ~/.funcs -type f); do
  source $file
done

# Source all files in ~/.alias
for file in $(find ~/.alias -type f); do
  source $file
done

export FZF_COMPLETION_TRIGGER=''
# Preview will show the file tree and the file contents. Any errors will be hidden, so completions that aren't files/dirs will not have a preview.
export FZF_COMPLETION_OPTS="--style minimal --border --info=inline --height 30 --bind 'focus:transform-header:file --brief {}'"
export FZF_COMPLETION_AUTO_COMMON_PREFIX=true
export FZF_COMPLETION_AUTO_COMMON_PREFIX_PART=true
# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'
export FZF_TAB_COMPLETION_PROMPT='❯ '

# Set Fuzzy Finder Tab completion to activate on double tab -- for supporting fzf tab completion on all bash completions
bind -x '"\t\t": fzf_bash_completion'
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Set up kubectl completion
# source <(carapace _carapace)
source <(kubectl completion bash)
source <(kubectl argo rollouts completion bash)
source <(dipctl completion bash)
source <(snooctl completion bash)
# source <(snoodev completion bash) # Snoodev completion takes a long time, so disabled for now

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd) fzf --preview 'eza -al --tree --color=always {} 2>/dev/null' "$@" ;;
  export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
  ssh) fzf --preview 'dig {}' "$@" ;;
  # Default to show permissions of file/dir and contents of files if possible
  *) fzf --preview 'eza -al --tree --color=always {1} 2>/dev/null && echo "" && bat -n --color=always {1} 2>/dev/null' "$@" ;;
  esac
}

# Fuzzy Finder Tab Completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
