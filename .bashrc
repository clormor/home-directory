# setup git-completion
GIT_COMPLETION_DIR="$HOME/.git-completion"
if [ -d $GIT_COMPLETION_DIR ]
then
    source $GIT_COMPLETION_DIR
fi

# aliasble color support for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
 
# some ls aliases
alias ls='ls -G' # color, the GNU way. The BSD way (non-GNU coreutils) is 'ls -G'
alias ll='ls -lF'
alias la='ls -A'

# use gnu-tar
alias tar='gtar'
# I literally always want this
alias sed='sed -E'
 
# git aliases
alias hlog='git log --date-order --all --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'
alias gits='git status'
alias gp='git push && git push --tags'
 
# tmux aliases
alias tmux="TERM=screen-256color-bce tmux" # specifically for 256color compat in tmux + iterm
 
# insta aliases
if [ -f /usr/local/opt/insta/bin/insta ]; then
    alias iup='insta start'
    alias idown='insta stop'
    alias ipg='insta workspace'
    alias ipem='insta pem'
    alias ig='insta gemini'
    alias issh='insta ssh'
    alias iscp='insta scp'
fi

# misc aliases
alias info='info --vi-keys'
if [ -f ~/bin/find-gradle ]
then
    alias gw='find-gradle'
fi

# configure gradle user home
GIT_VOLUME=/Volumes/git
if [ -d $GIT_VOLUME ]; then
    export GRADLE_USER_HOME="$GIT_VOLUME/.gradle"
fi

BREW_PREFIX=$(brew --prefix 2>/dev/null)
if [ -d "$BREW_PREFIX" ]
then
    # configure bash-git-prompt
    if [ -f "$BREW_PREFIX/opt/bash-git-prompt/share/gitprompt.sh" ]; then
        __GIT_PROMPT_DIR="$BREW_PREFIX/opt/bash-git-prompt/share"
        GIT_PRMOPT_FETCH_REMOTE_STATUS=0
        GIT_PRMOPT_ONLY_IN_REPO=1
        source "$BREW_PREFIX/opt/bash-git-prompt/share/gitprompt.sh"
    fi
fi

# configure rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]]
then
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

# configure iterm2 shell integration
if [ -e "${HOME}/.iterm2_shell_integration.bash" ]
then
    source "${HOME}/.iterm2_shell_integration.bash"
fi

# configure rbenv
if [ -d "$BREW_PREFIX/opt/rbenv" ]
then
    eval "$(rbenv init -)"
fi

# configure legacy java versions for legace palantir builds
# (should not be needed in recent pgdev versions)
#if [ -d ${GRADLE_USER_HOME:-"$HOME/.gradle"}/caches/jdks/macosx ]
#then
#    jdk_regex=".*/jdk[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}_[0-9]\{1,6\}"
#    cached_jdk=$(find ${GRADLE_USER_HOME:-"$HOME/.gradle"}/caches/jdks/macosx \
#        -type d \
#        -regex $jdk_regex \
#        | sort -V \
#        | tail -n 1)
#    if [ -d $cached_jdk ]
#    then
#        export JAVA_8_HOME=$cached_jdk
#        export JAVA_1_8_HOME=$cached_jdk
#    fi
#fi

#OSX_JAVA_HOME_BIN=/usr/libexec/java_home
#if [ -f $OSX_JAVA_HOME_BIN ]
#then
#    OSX_JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8)
#    if [ -d $OSX_JAVA_8_HOME ]
#    then
#        export JAVA_8_HOME=$OSX_JAVA_8_HOME
#        export JAVA_1_8_HOME=$OSX_JAVA_8_HOME
#    fi
#fi

#OSX_JAVA_6_HOME=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
#if [ -d $OSX_JAVA_6_HOME ]
#then
#    export JAVA_6_HOME=$OSX_JAVA_6_HOME
#    export JAVA_1_6_HOME=$OSX_JAVA_6_HOME
#fi

function prepend_path_if_exists {
    if [ -d $1 ]
    then
        PATH="$1:$PATH"
    fi
}

function append_path_if_exists {
    if [ -d $1 ]
    then
        PATH="$PATH:$1"
    fi
}

# configure legacy node
append_path_if_exists "/usr/local/opt/node@10/bin"
prepend_path_if_exists "~/.gem/ruby/2.6.0/bin"

# source nexus credentials
if [ -f ~/.nexus ]
then
    source ~/.nexus
fi

# add custom scripts to PATH
prepend_path_if_exists "$HOME/bin"
prepend_path_if_exists "$HOME/pbin"

# configure environment variables
export ARTIFACTORY_URL=https://artifactory.palantir.build/artifactory
export HOMEBREW_EDITOR=/usr/bin/vim
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export PIPENV_DEFAULT_PYTHON_VERSION=3.7
prepend_path_if_exists "/usr/local/opt/coreutils/libexec/gnubin/"

# I will migrate to zsh one day, i promise
export BASH_SILENCE_DEPRECATION_WARNING=1
