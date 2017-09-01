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
            echo "$fg_bold[magenta]Walltime" "$pp" "$reset_color"
        fi
        unset timer
    fi
    get_jobs
}

# set the prompt (magenta if ssh is used otherwise red)
if [ -z "$SSH_CLIENT" ]; then
    PROMPT="%{$bg_bold[red]%} %{$reset_color%} %{$fg_bold[red]%}%m [%*] [%v]%{$reset_color%} %{$fg_bold[red]%}%~ %{$reset_color%}%

%{$bg_bold[red]%} %{$reset_color%} "
else
    PROMPT="%{$bg_bold[magenta]%} %{$reset_color%} %{$fg_bold[magenta]%}%m [%*] [%v]%{$reset_color%} %{$fg_bold[red]%}%~ %{$reset_color%}%

%{$bg_bold[magenta]%} %{$reset_color%} "
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
export PAGER=vimpager
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
alias astyle='astyle --indent=tab --style=java --delete-empty-lines'
alias zsh-reload='. ~/.zshrc'
alias gnuplot='gnuplot -'
alias spellcheck='aspell -c'
alias md='pandoc -f markdown -t html'
alias ai='sudo apt-get install'
alias as='apt-cache search'
alias pi='yaourt -S'
alias arch-update='yaourt -Syu --aur'
alias sync-nas='rsync -aP ~/sync $nas:/share/MD0_DATA/homes/lukas'
alias latexmk='latexmk -pdf'
function mdp() {
    perl -p -e 's/\n/\\\n/' $1 | pandoc -o ${1%.*}.pdf
}

# mount encrypted volume
alias mount-personal='encfs ~/Dropbox/personal-encfs  ~/personal'
alias umount-personal='fusermount -u ~/personal'

# vpn
# this requires to add
# lukas ALL=(root) NOPASSWD: /usr/bin/uibk
# using visudo
# and that the openconnect script exists in the path
alias uibk='sudo uibk'

# memory usage overview
function memusg {
    ps aux | grep "$@" | awk 'BEGIN{a=0}{a+=$6}END{printf("%.2f\n",a/1e6)}'
}
function mem {
    total='0.0'
    for app in chrome okular dropbox Xorg skype Mathematica; do
        m=$(memusg $app)
        echo $m GB $app
        total="$(echo "$total+$m" | bc)"
    done > /tmp/mem_temp
    cat /tmp/mem_temp | sort -r
    printf "total usage: %.2fGB (missing: %.2fGB)\n" $(memusg '') $(echo "$(memusg '')-$total" | bc)
}

# okular makes too much noise
function okular() {
    /usr/bin/okular $@ > /dev/null 2>&1 &
		#disown $!
}
# evince does the same
function evince() {
    /usr/bin/evince $@ > /dev/null 2>&1 &
		#disown $!
}
# foxitreader does the same
function foxit() {
    /usr/bin/foxitreader $@ > /dev/null 2>&1 &
		#disown $!
}

# suffix aliases allows us to open files without specifying the program
alias -s pdf=okular
alias -s djvu=evince
alias -s cpp=$EDITOR
alias -s hpp=$EDITOR
alias -s c=$EDITOR
alias -s h=$EDITOR
alias -s py=$EDITOR
alias -s txt=$EDITOR

#function ip() {
    #ipython notebook > /dev/null 2>&1 &
#}

# complete pdflatex build (including bibtex)
function mpdf() {
    for file in *.tex; do
        echo "=============================="
        echo "processing: $file"
        echo "=============================="
        pdflatex $file
        bibtex ${file%.tex}
        pdflatex $file
        pdflatex $file
        latexmk -c
    done
}
function mpdfd() {
    pdflatex $1
    bibtex ${1%.tex}
    pdflatex $1
    pdflatex $1
    rm ${1%.tex}.log ${1%.tex}.aux ${1%.tex}.nav ${1%.tex}.out ${1%.tex}.toc ${1%.tex}.blg ${1%.tex}.bbl
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
(nohup xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' > /dev/null 2> /dev/null &) > /dev/null 2> /dev/null

# change between german and english layout
alias enkeyb='setxkbmap -layout us'
alias dekeyb='setxkbmap -layout de'

# get last argument with Esc+. as in bash
bindkey '\e.' insert-last-word

xset -b # turn beep off
xset s off # turn x black screen saver off

export PATH=$PATH:$HOME/bin


PATH="/home/lukas/perl5/bin:/opt/intel/composer_xe_2015/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/lukas/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lukas/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lukas/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lukas/perl5"; export PERL_MM_OPT;

#export PATH="$PATH:/usr/local/berkeley_upc/bin/"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/mkl/lib/intel64:/opt/intel/lib/intel64/

. /etc/profile.d/vte.sh # Bug in arch (http://unix.stackexchange.com/questions/93476/gnome-terminal-keep-track-of-directory-in-new-tab)

source /opt/intel/composer_xe_2015/bin/compilervars.sh intel64

export PATH=$PATH:/opt/cuda/bin/

