export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

alias clean="clear && printf '\e[3J'"
alias ebp="nano /home/pi/.bash_profile"
alias sudo="sudo "

function news {
curl -s http://feeds.reuters.com/reuters/topNews?format=xml | grep "<title>" | sed -e 's/<[^>]*>//g' -e '2,$ s/^[ \t]*//' | grep -v "Reuters: Top News"
}

function weather {
curl -s wttr.in/@$(curl -s ipinfo.io/ip)?0q | sed -e 's/↖/⭦/g' -e 's/↗/⭧/g' -e 's/↘/⭨/g' -e 's/↙/⭩/g'
}

let rand="$RANDOM"
let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

echo "
`clean`
$(tput setaf 2)   .~~.   .~~.    `figlet -f kban Welcome | sed -n '8p' | lolcat -f -S "$rand"` 
$(tput setaf 2)  '. \ ' ' / .'   `figlet -f kban Welcome | sed -n '1p' | lolcat -f -S "$rand"`
$(tput setaf 1)   .~ .~~~..~.    `figlet -f kban Welcome | sed -n '2p' | lolcat -f -S "$rand"`
$(tput setaf 1)  : .~.'~'.~. :   `figlet -f kban Welcome | sed -n '3p' | lolcat -f -S "$rand"`
$(tput setaf 1) ~ (   ) (   ) ~  `figlet -f kban Welcome | sed -n '4p' | lolcat -f -S "$rand"`
$(tput setaf 1)( : '~'.~.'~' : ) `figlet -f kban Welcome | sed -n '5p' | lolcat -f -S "$rand"`
$(tput setaf 1) ~ .~ (   ) ~. ~  `figlet -f kban Welcome | sed -n '6p' | lolcat -f -S "$rand"`
$(tput setaf 1)  (  : '~' :  )   Time/Date....: `date +"%A, %e %B %Y, %r"`
$(tput setaf 1)   '~ .~~~. ~'    System.......: `uname -srmo`
$(tput setaf 1)       '~'        Uptime.......: ${UPTIME}
$(tput setaf 1)Your Location and Weather......: `weather`
$(tput sgr0)"
