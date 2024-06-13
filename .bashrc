# Source env file which contains all the environment variables
[ -f ~/.env ] && source ~/.env

CLUSTERNAME="home"

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_HIDE_IF_PWD_IGNORED=true
GIT_PS1_SHOWCOLORHINTS=true

# Source all files in ~/.funcs
for file in $(find ~/.funcs -type f); do
	source $file
done

# Source all files in ~/.alias
for file in $(find ~/.alias -type f); do
	source $file
done

# Fuzzy Finder Tab Completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_COMPLETION_TRIGGER=''
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_COMPLETION_AUTO_COMMON_PREFIX=true
export FZF_COMPLETION_AUTO_COMMON_PREFIX_PART=true

# Set up kubectl completion
source <(kubectl completion bash)

# Sets up FZF tab completion from a separate source
source ~/fzf-tab-completion/bash/fzf-bash-completion.sh
# Set Fuzzy Finder Tab completion to activate on tab
bind -x '"\t": fzf_bash_completion'
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
eval "$(oh-my-posh init bash --config ~/dotfiles/.config/oh-my-posh/conf.toml)"
