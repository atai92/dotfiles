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

function set-prompt {
	BLACK="\[\033[0;30m\]"   # Black
	RED="\[\033[0;31m\]"     # Red
	GREEN="\[\033[0;32m\]"   # Green
	YELLOW="\[\033[0;33m\]"  # Yellow
	BLUE="\[\033[0;34m\]"    # Blue
	MAGENTA="\[\033[0;35m\]" # MAGENTA
	CYAN="\[\033[0;36m\]"    # Cyan
	WHITE="\[\033[0;37m\]"   # White

	# Bold
	BLACKBOLD="\[\033[1;30m\]"   # Black
	REDBOLD="\[\033[1;31m\]"     # Red
	GREENBOLD="\[\033[1;32m\]"   # Green
	YELLOWBOLD="\[\033[1;33m\]"  # Yellow
	BLUEBOLD="\[\033[1;34m\]"    # Blue
	MAGENTABOLD="\[\033[1;35m\]" # MAGENTA
	CYANBOLD="\[\033[1;36m\]"    # Cyan
	WHITEBOLD="\[\033[1;37m\]"   # White

	RESET_COLOR="\[\033[0m\]"

	local __git_branch_color="$MAGENTABOLD"
	#local __git_branch=$(__git_ps1);
	local __git_branch=$(git branch --show-current 2>/dev/null)

	# colour branch name depending on state
	if [[ "${__git_branch}" =~ "*" ]]; then # if repository is dirty
		__git_branch_color="$RED"
	elif [[ "${__git_branch}" =~ "$" ]]; then # if there is something stashed
		__git_branch_color="$YELLOW"
	elif [[ "${__git_branch}" =~ "%" ]]; then # if there are only untracked files
		__git_branch_color="$WHITE"
	elif [[ "${__git_branch}" =~ "+" ]]; then # if there are staged files
		__git_branch_color="$CYAN"
	fi

	export PS1="${REDBOLD}[${CLUSTERNAME}] ${GREENBOLD}\$(pwd) ${__git_branch_color}${__git_branch} ${BLUE}\n→ ${RESET_COLOR}"
}

export PROMPT_COMMAND=set-prompt

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
