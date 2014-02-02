zstyle :compinstall filename '/home/lukas/.zshrc'

# vim mode
bindkey -v
# backspace should still work after leaving command mode
bindkey "^?" backward-delete-char
# allows the use of ESC+v to edit the current command in vim
# fc edits the last command in the history in vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# autocomplete
autoload -Uz compinit
compinit
# no need to type cd
setopt auto_cd
setopt correct

autoload -U colors && colors

#
# the following functions are used for the customized appearance of the shell
#

# get background jobs
function get_jobs() {
  # the variable psvar can then be used in the prompt with the %v parameter
  psvar=`jobs | grep '^\[' |  sed  's/.*  //g' | grep -o '^[^[:space:]]*' | tr '\n' '|' | rev | cut -c 2- | rev`
}
# get the walltime of a computation
function timer_start() {
  timer=${timer:-$SECONDS}
}
function preexec() {
  timer=$SECONDS
  # reset color of the command entered and display the output in the usual manner (-n tells echo to suppress the customary linebreak)
  echo -n "$reset_color" 
}
# convert seconds to hours/minutes/seconds
function convertsecs() {
 ((h=${1}/3600))
 ((m=(${1}%3600)/60))
 ((s=${1}%60))
 printf "%02d:%02d:%02d\n" $h $m $s
}

# execute before new shell appears
function precmd() {
  if [[ -n "$timer" ]] # checks if timer is set to something
  then
    result=$(($SECONDS-$timer))
    pp=$(convertsecs $result)
    if [[ $result -gt 2 ]]
    then
      echo "$fg_bold[yellow]Walltime" "$pp" "$reset_color"
    fi
    unset timer
  fi
  get_jobs
}

# set the prompt (yellow if ssh is used otherwise red)
if [ -z "$SSH_CLIENT" ]; then
PROMPT="%{$bg_bold[red]%} %{$reset_color%} %{$fg_bold[red]%}%m [%*] [%v]%{$reset_color%} %{$fg_bold[red]%}%~ %{$reset_color%}%

%{$bg_bold[red]%} %{$reset_color%} "
else
PROMPT="%{$bg_bold[yellow]%} %{$reset_color%} %{$fg_bold[yellow]%}%m [%*] [%v]%{$reset_color%} %{$fg_bold[red]%}%~ %{$reset_color%}%

%{$bg_bold[yellow]%} %{$reset_color%} "
fi

# set colors of commonly used filetypes
# for the codes see http://blog.twistedcode.org/2008/04/lscolors-explained.html
LS_COLORS_L='*.tex=33:*.bib=33:*.lyx=33:*.pdf=35:*.djvu=35'
LS_COLORS_C='*.cpp=32:*.c=32:*.hpp=32:*.h=32'
LS_COLORS_D='*.dat=36:*.data=36'
LS_COLORS_PY='*.py=32'
LS_COLORS_EXE='ex=4;31'
export LS_COLORS=$LS_COLORS_L:$LS_COLORS_C:$LS_COLORS_D:$LS_COLORS_PY:$LS_COLORS_EXE

# save extensive history across sessions
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory 
setopt sharehistory
setopt extendedhistory

# enable history search with Ctrl+r like in bash
bindkey "^R" history-incremental-search-backward
bindkey "^T" history-incremental-search-forward

export EDITOR='vim'

# use vim as a pager
export PAGER=~/bin/vimpager
alias less=$PAGER
alias zless=$PAGER

# open cpp and hpp file with vim
alias -s cpp=vim
alias -s hpp=vim

# aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls --color=auto --group-directories-first -lah'
alias df='df -h'
alias bc='bc -l' #enable floating point computations by default
alias grep='grep --color'
alias ip='ipython notebook --pylab inline'
alias astyle='astyle -T'
alias zsh-reload='. ~/.zshrc'
alias gnuplot='gnuplot -'
alias spellcheck='aspell -c'
alias md='pandoc -f markdown -t html'
alias ai='sudo apt-get install'
alias as='apt-cache search'
function mdp() {
	perl -p -e 's/\n/\\\n/' $1 | pandoc -o ${1%.*}.pdf
}

# okular makes too much noise
function okular() {
	/usr/bin/okular $@ > /tmp/okular.stdout 2>&1
}
# complete pdflatex build (including bibtex)
function mpdf() {
	pdflatex $1
	bibtex ${1%.tex}
	pdflatex $1
	pdflatex $1
}
# show battery status
function battery() {
	acpi
}
# creates tar.gz archive of directory given
function archive() {
	tar -czf $(basename $1)-$(/bin/date +%Y%m%d).tar.gz $1
}
# calc '...' does a much better job than bc
function calc() { 
	awk "BEGIN{ print $* }"
}

# load computer names
. ~/.computers

# map caps lock to escape
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

