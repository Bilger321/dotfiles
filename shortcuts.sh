#!/bin/sh
. /etc/profile

# TO RUN THIS FILE: bash <(curl -ks [external web/intranet location of this file] );
# ALIASES WILL BE LOADED AND AVAILABLE ON THE MACHINE.
# FEEL FREE TO ADD YOUR OWN. I HAD TO REMOVE MANY CUSTOM SCRIPTS STORED ON OLD JOB SERVERS.
# TO NOT AFFECT FORMATTING THE BELOW EXAMPLE HAS REPLACED OPEN/CLOSE PARENTHESIS WITH BRACES.
# EXAMPLE FORMAT:
#==================#Helpful subsection title#=================={}
# alias_name{} { commands go here; }



#==================#Post reboot tests.#==================()

sitechk() { cat /etc/trueuserdomains; }

chksites() { for i in `cat /etc/trueuserdomains | cut -d : -f1`; do  CURL_CHECK=$(curl -Is http://$i/ | head -1); if [[ -n $CURL_CHECK  ]]; then if [ $(curl -Is http://$i/ | head -1 | awk '{print $2'}) -eq "200" ]; then echo -e "http://$i/"; fi; fi; done; }

usrchk() { OUT=$(/usr/local/cpanel/bin/dcpumonview | grep -v Top | sed -e 's#<[^>]*># #g' | while read i ; do NF=`echo $i | awk {'print NF'}` ; if [[ "$NF" == "5" ]] ; then USER=`echo $i | awk {'print $1'}`; OWNER=`grep -e "^OWNER=" /var/cpanel/users/$USER | cut -d= -f2` ; echo "$OWNER $i"; fi ; done) ; (echo "USER CPU" ; echo "$OUT" | sort -nrk4 | awk '{printf "%s %s%\n",$2,$4}' | head -5) | column -t ;echo;(echo -e "USER MEMORY" ; echo "$OUT" | sort -nrk5 | awk '{printf "%s %s%\n",$2,$5}' | head -5) | column -t ;echo;(echo -e "USER MYSQL" ; echo "$OUT" | sort -nrk6 | awk '{printf "%s %s%\n",$2,$6}' | head -5) | column -t; }

mysqlerrors() { tail -n300 /var/lib/mysql/$(hostname).err; }

#==================#Lists Kernels, useful for kernal upgrades.#==================()

listkernels() { awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg; }

#==================#Shows rankings for web services.#==================()

topphp() { grep -P "$(date '+%b %d')" /usr/local/apache/logs/suphp_log | cut -f2 -d\" | sort | uniq -c | sort -n | tail; }

topips() { awk '{ print $1}' /usr/local/apache/logs/access_log | sort | uniq -c | sort -nr | head -n 10; }


#==================#Drive Related.#==================()

filteredmessages() { cat /var/log/messages | grep -iv 'firewall\|named\|pure-ftpd\|proftpd' | less; }

scsirescan() { NUMS=$(ls /sys/class/scsi_host/ | tr -d "host"); for i in $NUMS; do echo "- - -" > /sys/class/scsi_host/host$i/scan; done; }

DC400Health() { NUMS=$(megacli -PDList -aAll | grep "Device Id" | awk '{print $3}'); pVal=0; for i in $NUMS; do echo -ne "Lifetime left on p$pVal: \t"; pVal=$((pVal+1)); smartctl -a -d megaraid,$i /dev/sda | grep "231" | awk '{print $4}'; done; }

#==================#Show this list.#==================()

listaliases() { curl -ks [web location of this file] | grep "()" | sed 's/(.*//' | sed 's/#/\n/g';}

#==================#Various Cutsom functions.#==================()

clean() { clear && printf '\033[3J'; }

up() { watch -t -n0.01 "uptime && echo "" && free -m"; }

#==================#General System Info.#==================()


whatismyip() { ifconfig | grep "inet addr" | head -1 | tr -d inet | tr -d addr | awk '{print $1}' | tr -d :; }
