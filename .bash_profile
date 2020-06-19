# Docker
alias dr='docker'
alias drr='docker run'
alias drrm="docker rm"
alias drps="docker ps"
alias drl='docker ps -l -q'
alias dri="docker images"
alias drri="docker rmi"
alias drb="docker build"
alias dcra="docker-compose run app"
alias dc="docker-compose"

# Git
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gm='git merge'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcod='git checkout dev'
alias gcos='git checkout stage'
alias gcom='git checkout master'
alias ga='git add'
alias gc='git commit -m'
alias gplrom='git pull --rebase origin master'
alias gplros='git pull --rebase origin stage'
alias gplrod='git pull --rebase origin dev'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gpos='git push origin stage'
alias gpod='git push origin dev'

## PROMPT BUSINESS ##
# Let's sprinkle a little RVM and Git in there

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
 return
fi

PS1='\h:\W \u\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize

# Configure colors, if available.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  c_reset='\[\e[0m\]'
  c_user='\[\033[1;33m\]'
  c_path='\[\e[0;33m\]'
  c_git_clean='\[\e[0;36m\]'
  c_git_dirty='\[\e[0;35m\]'
else
  c_reset=
  c_user=
  c_path=
  c_git_clean=
  c_git_dirty=
fi

# Function to assemble the Git part of our prompt.
git_prompt () {
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')

  if git diff --quiet 2>/dev/null >&2; then
    git_color="$c_git_clean"
  else
    git_color="$c_git_dirty"
  fi

  echo " [$git_color$git_branch${c_reset}]"
}

function rvm_version {
	local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
	[ "$gemset" != "" ] && gemset="@$gemset"
	local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
	[ "$version" != "" ] && version=" $version"
	local full="$version$gemset"
	[ "$full" != "" ] && echo "$full "
}

# Thy holy prompt.
PROMPT_COMMAND='PS1="${c_path}\w${c_reset}$(git_prompt) $(rvm_version)\$ "'

## END PROMPT BUSINESS ##缀
