# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git, cloudapp)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/piplup/Programming/google-go/repo/bin:/home/piplup/osMaintainence/scripts:



# PS1 and PS2
#export PS1="$(print '%{\e[0;37m%}%n%{\e[0m%}'):$(print '%{\e[0;32m%}%c%{\e[0m%}')$ "
export PS1="$(print '%{\e[1;33m%}➜%{\e[0m%} %{\e[0;32m%}%c%{\e[0m%}')$ "
export PS2="$(print '%{\e[0;34m%}%T>%{\e[0m%}')"
export RPROMPT="$(print '%{\e[0;34m%}%?, %T@%M%{\e[0m%}')"

# aliases ---------o
alias DROPBOX_HOME=${HOME}/Dropbox;
alias RECIEPTS_HOME=$DROPBOX_HOME/receipts;
alias rm="rm -r"


# A small wrapper to allow easier manual music playing
export m_PLAY_COUNT=1;
export m_PREVIOUS='';
function m() {
  if [[ $m_PREVIOUS != $* ]]; then
    m_PLAY_COUNT=1;
  else 
    m_PLAY_COUNT=$(($m_PLAY_COUNT * 2));
  fi 

  m_PREVIOUS=$*
  mplayer -really-quiet -loop ${m_PLAY_COUNT} $@
}

alias octave="octave --quiet"
alias cs="cd"

# tab completion for PID :D
#zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir
#zstyle ':completion:*:cd:*' ignore-parents parent pwd



my_extended_wordchars='*?_-.[]~=&;!#$%^(){}<>:@,\\';
my_extended_wordchars_space="${my_extended_wordchars} "
my_extended_wordchars_slash="${my_extended_wordchars}/"
WORDCHARS=${my_extended_wordchars_slash}
bindkey -e
# useful for path editing — backward-delete-word, but with / as additional delimiter
backward-delete-to-slash () {
  local WORDCHARS=${WORDCHARS//\//}
  zle .backward-delete-word
}

zle -N backward-delete-to-slash

setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd

export EDITOR="vim"
export BROWSER="google-chrome"
export XTERM="aterm +sb -geometry 80x29 -fg black -bg lightgoldenrodyellow -fn -xos4-terminus-medium-*-normal-*-14-*-*-*-*-*-iso8859-15"
export MEDIA_PLAYER="m"

zle -C control-d-exit complete-word exit
bindkey '\C-w' backward-delete-to-slash

# completion in the middle of a line
#bindkey '^i' expand-or-complete-prefix
bindkey '^[[Z' reverse-menu-complete # reverse tab

# command S equivalent to command &> /dev/null &
alias -g S='&> /dev/null &'
alias -g Q='2&> /dev/null '

alias cs343_push="rsync -avrz /home/piplup/waterloo/cs343 s54zhang@linux012.student.cs.uwaterloo.ca:/u9/s54zhang/"
alias cs343_pull="rsync -avrz s54zhang@linux012.student.cs.uwaterloo.ca:/u9/s54zhang/cs343 /home/piplup/waterloo"

alias cg="find . \( -name .git -o -name .svn \) -prune -o \( -type f -name \*.cpp -or -name \*.lua -or -name \*.cc -or -name \*.s -or -name \*.c -or -name \*.h -or -name \*.hpp -or -name \*.py -or -name \*.js \) -print0 | xargs -0 egrep -i -n"
alias f='find | egrep -i ' 
alias f1='find -maxdepth 1 | egrep -i ' 
alias lf='ls | grep -i ' 

# Vars used later on by Zsh
export EDITOR="vim"
export BROWSER="google-chrome"
export XTERM="aterm +sb -geometry 80x29 -fg black -bg lightgoldenrodyellow -fn -xos4-terminus-medium-*-normal-*-14-*-*-*-*-*-iso8859-15"

alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feg
alias -s sxw=soffice
alias -s doc=soffice
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s c=$EDITOR
alias -s cc=$EDITOR
alias -s cpp=$EDITOR
alias -s py=python
alias -s PKGBUILD=$EDITOR
alias -s mp3="$MEDIA_PLAYER"
alias -s m4a="$MEDIA_PLAYER"
alias -s wma="$MEDIA_PLAYER"
alias -s flac="$MEDIA_PLAYER"
alias -s flv="$MEDIA_PLAYER"


#zstyle ':completion:*' file-patterns '%p:globbed-files:'

#zstyle ':completion:*' verbose yes

#zstyle ':completion:*:descriptions' format '%B%d%b'

#zstyle ':completion:*:messages' format '%d'

#zstyle ':completion:*:warnings' format 'No matches for: %d'

#zstyle ':completion:*' group-name
pdf_merge(){
 # test existence for variables
 if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
   if [ -f "$1" -a -f "$2" -a -f "$3" ]; then
     gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=$1 -dBATCH $2 $3;
     return 0;
   fi
   echo "Listed file do not exist.";
 else
   echo "Need 3 file names, top, bottom, result file names";
 fi

 return 1;
}
