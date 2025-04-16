#!/bin/bash

info='\e[46;30m'
warn='\e[41;37m'
success='\e[42;30m'
end='\e[0m'

help(){
    echo -e '\e[31m────────────────────────────────────────────── \e[0m'
    echo -e '\e[31m───────| \e[0m \e[35mSIMPLE GUI BOT - NODE - WRT\e[0m \e[31m|───────\e[0m'
    echo -e '\e[31m──────────────────────────────────────────────\e[0m'
    echo -e ''
    echo -e 'help, -h                       \e[33mshow help usage\e[0m' 
    echo -e 'install, -i                            \e[33minstall\e[0m'
    echo -e 'uninstall, -rf                   \e[33muninstall bot\e[0m'
    echo -e 'changecfg, -cc                   \e[33mchange config\e[0m'
    echo -e 'backup, -bck                     \e[33mbackup config\e[0m'
    echo -e 'restore, -rst                   \e[33mrestore config\e[0m'
    echo -e 'update, -u                          \e[33mupdate bot\e[0m'
    echo -e 'upnode, -un                    \e[33mupdate telegram-bot\e[0m'
    echo -e 'version, -v                        \e[33mversion bot\e[0m'
    echo -e 'status, -s                      \e[33mcek status bot\e[0m'
    echo -e 'start                                \e[33mstart bot\e[0m'
    echo -e 'stop                                  \e[33mstop bot\e[0m'
    echo -e 'restart                            \e[33mrestart bot\e[0m'
    echo -e 'add_bot_cron, -cb                     \e[33madd cron\e[0m'
    echo -e 'rm_bot_cron, -rcb                    \e[33mdell cron\e[0m'
    echo -e '\e[31m──────────────────────────────────────────────\e[0m'
}
status(){
    pgrep -f /root/telegram-bot/index.js > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "$success telegram-bot is running [$(pgrep -f /root/telegram-bot/index.js)]$end"
    else
        echo -e "$warn telegram-bot not running $end"
    fi
}
version(){
    version=$(grep '"version":' /root/telegram-bot/package.json | sed -E 's/.*"version": "(.*)".*/\1/')
    echo "$info version: $version $end" 
}
installpckg(){
    if [[ $(opkg list-installed | grep -c "^$1") == "0" ]]; then
        echo -e "$success installing ${1}... $end" && opkg install $1
    fi
}
addCrontab() {
    if [ "$1" == "botcb" ]; then
        if crontab -l | grep -q 'cek-bot.sh'; then
            echo -e "$info crontab bot already exists $end"
            return 0
        fi
    else
        echo -e "$info add bot to crontab ... $end"
    fi

    tmpfile=$(mktemp)
    crontab -l >"$tmpfile"
    printf '%s\n' "$2" >>"$tmpfile"
    crontab "$tmpfile" && rm -f "$tmpfile"
    echo -e "$info successfully add crontab $end"
}
removeCrontab(){
    tmpfile=$(mktemp)
    crontab -l >"$tmpfile"
    if [ "$1" == "botcb" ]; then
        sed -i "/cek-bot.sh/d" "$tmpfile"
    fi
    crontab "$tmpfile" && rm -f "$tmpfile"
    echo -e "$info successfully delete crontab $end"
}
createConfig(){
    sed -i "1s/.*/TOKEN='$(printf "%s" "$1")'/" /root/telegram-bot/.env
    sed -i "2s/.*/USERID='$(printf "%s" "$2")'/" /root/telegram-bot/.env
    sed -i "3s/.*/IPMODEM='$(printf "%s" "$3")'/" /root/telegram-bot/.env
    sed -i "4s/.*/PASSWORD='$(printf "%s" "$4")'/" /root/telegram-bot/.env
}
backup(){
    if [ -e "../.env" ]; then
        rm -rf ../.env
        cp /root/telegram-bot/.env /.env
        echo -e "$success backup config successfully ../.env $end" 
    else
        cp /root/telegram-bot/.env /.env
        echo -e "$success backup config successfully ../.env $end"
    fi
}
restore(){
    mv ../.env /root/telegram-bot/.env
    echo -e "$success restore config successfully $end"
}
changecfg(){
    while :; do
            echo -e "$info 1 (TOKEN) 2 (USERID) 3 (IPMODEM) 4 (PASSWORD) || 0 (exit mode) $end"
            read -e -p "what do you want to change? eg: 1 : "  q
            if [ "${q}" == '1' ]; then
                read -e -p "enter new Token : " newtok
                sed -i "1s/.*/TOKEN='$(printf "%s" "$newtok")'/" /root/telegram-bot/.env 
                break
            elif [ "${q}" == '2' ]; then
                read -e -p "enter new Userid : " newusr
                sed -i "2s/.*/USERID='$(printf "%s" "$newusr")'/" /root/telegram-bot/.env 
                break
            elif [ "${q}" == '3' ]; then
                read -e -p "enter new ipmodem : " newip
                sed -i "3s/.*/IPMODEM='$(printf "%s" "$newip")'/" /root/telegram-bot/.env 
                break
            elif [ "${q}" == '4' ]; then
                read -e -p "enter new Password : " newpass
                sed -i "4s/.*/PASSWORD='$(printf "%s" "$newpass")'/" /root/telegram-bot/.env 
                break
            elif [ "${q}" == '0' ]; then 
                echo -e 'exit mode'
                exit 0
            break
            else
                echo -e "input error! Please only input 1 to 4 or 0"
            fi
        done 
} 
uninstall(){
while :; do
            read -e -p "$info do you want to uninstall telegram-bot ? [y/n]: $end" q
            if [ "${q}" == 'y' ]; then
                echo -e "$info uninstalling telegram-bot ... $end"
                rm -r /root/telegram-bot
                rm -rf /usr/bin/ht-api /usr/bin/mmsms /etc/init.d/telegram-bot
                break
            elif [ "${q}" == 'n' ]; then 
                echo -e 'exit mode'
                exit 0
            break
            else
                echo -e "$warn input error! Please only input 'y' or 'n' $end"
            fi
        done
}
upnode(){
    wget https://raw.githubusercontent.com/Lionikz97/telegram-bot/master/install.sh -O /usr/bin/telegram-bot.bak && chmod +x /usr/bin/telegram-bot.bak
    echo -e "$success update telegram-bot successfully $end"
    rm -rf /usr/bin/telegram-bot
    mv /usr/bin/telegram-bot.bak /usr/bin/telegram-bot
}
install(){
    if [ -d "/root/telegram-bot" ]; then
        echo -e "$info telegram-bot already installed $end"
        while :; do
            read -p "$(echo -e "$info do you want to reinstall telegram-bot ? [y/n]: $end")" q
            if [ "${q}" == 'y' ]; then
                echo -e "$info uninstalling telegram-bot ... $end"
                rm -r /root/telegram-bot
                rm -rf /usr/bin/ht-api /usr/bin/mmsms /etc/init.d/telegram-bot
                break
            elif [ "${q}" == 'n' ]; then
                echo -e "exit installation mode"
                exit 0
            else
                echo -e "$warn input error! Please only input 'y' or 'n' $end"
            fi
        done
    fi
    while :; do
        read -p "$(echo -e "$info please input BOT TOKEN : $end")" TOKEN
        if [[ -z "${TOKEN}" ]]; then
            echo -e "$warn TOKEN BOT cant be empty$end"
        else
            break
        fi
    done
    while :; do
        read -p "$(echo -e "$info please input USER ID : $end")" USERID
        if [[ -z "${USERID}" ]]; then
            echo -e "$warn USERID cant be empty$end"
        else
            break
        fi
    done
    read -p "$(echo -e "$info please input ip address : $end")" IPMODEM
    read -p "$(echo -e "$info please input password : $end")" PASSWORD
    echo -e "$info update package & install package ... $end"
    sleep 1
    opkg update
    installpckg "node-npm"
    installpckg "git"
    installpckg "git-http"
    installpckg "jq"
    installpckg "sysstat"
    installpckg "bash"
    installpckg "curl"
    installpckg "wget"
    installpckg "vnstat2"
    installpckg "vnstati"
    echo -e "installing bot ..."
    sleep 1
    cd
    git clone https://github.com/Lionikz97/telegram-bot.git
    cd telegram-bot
    echo -e "$info installing dependencies NPM ... $end"
    sleep 1
    retry=true
    while $retry; do
    npm install && {
    echo -e "$success npm install successful.$end"
    retry=false
    } || {
    read -p "$(echo -e "$warn npm install failed. retry? (y/n): $end")" answer
    case "$answer" in
      [yY] )
        echo -e "$info ietrying npm install...$end"
        ;;
      [nN] )
        echo -e "$warn installation aborted.$end"
        exit 1
        ;;
      * )
        echo -e "$warn invalid input. Please enter y or n.$end"
        ;;
    esac
    }
    done
    cp /root/telegram-bot/etc/init.d/telegram-bot /etc/init.d/
    cp /root/telegram-bot/.env.example /root/telegram-bot/.env
    cp /root/telegram-bot/lib/mmsms /usr/bin/
    cp /root/telegram-bot/lib/ht-api /usr/bin/
    chmod +x /usr/bin/ht-api /usr/bin/mmsms
    chmod +x /etc/init.d/telegram-bot
    chmod +x /root/telegram-bot/lib/*/*.sh
    createConfig "$TOKEN" "$USERID" "$IPMODEM" "$PASSWORD"
    echo -e "$info test send message ... $end"
    sleep 1
    /root/telegram-bot/lib/bot/booting.sh
    sleep 1
    echo -e "$info enable service ... $end"
    /etc/init.d/telegram-bot enable
    sleep 1
    echo -e "$info start service ... $end"
    /etc/init.d/telegram-bot start
    sleep 1
    addCrontab "botcb" "*/2 * * * *  /root/telegram-bot/lib/bot/cek-bot.sh"
    sleep 1
    echo -e "$success bot successfully installed ... $end"
    echo -e "$info join groups telegram https://t.me/infobot_wrt $end"
}
update() {
    while :; do
        read -p "$(echo -e "$info Do you want to continue the update? [y/n]: $end")" q
        if [[ "$q" == "y" || "$q" == "Y" ]]; then
            echo -e "$info Starting update process...$end"
            
            # Navigasi ke direktori proyek
            cd /root/telegram-bot || {
                echo -e "$error Failed to change directory. Exiting.$end"
                exit 1
            }
            
            # Tarik pembaruan dari Git
            git pull origin master || {
                echo -e "$error Failed to pull updates from Git. Exiting.$end"
                exit 1
            }

            # Salin file dan set izin
            cp /root/telegram-bot/etc/init.d/telegram-bot /etc/init.d/
            cp /root/telegram-bot/lib/mmsms /usr/bin/
            cp /root/telegram-bot/lib/ht-api /usr/bin/
            chmod +x /usr/bin/ht-api /usr/bin/mmsms
            chmod +x /etc/init.d/telegram-bot
            chmod +x /root/telegram-bot/lib/*/*.sh

            # Aktifkan dan mulai layanan
            /etc/init.d/telegram-bot enable
            /etc/init.d/telegram-bot start
            
            echo -e "$info Update completed successfully.$end"
            break
        elif [[ "$q" == "n" || "$q" == "N" ]]; then
            echo -e "$info Update canceled. Exiting.$end"
            exit 0
        else
            echo -e "$warn Invalid input. Please enter 'y' or 'n'.$end"
        fi
    done
}


case "${1}" in
-s|status)
  status
  ;;
-h|help)
  clear
  help
  ;;
-v|version)
  version
  ;;
-i|install)
  clear
  install
  ;;
-rf|uninstall)
  clear
  uninstall
  ;;
-u|update)
  clear
  update
  ;;
-un|upnode)
   upnode
   ;;
-bck|backup)
   backup
   ;;
-rst|restore)
   restore
   ;;
-cc|changecfg)
   changecfg
   ;;
-cb|add_bot_cron)
  addCrontab "botcb" "*/2 * * * *  /root/telegram-bot/lib/bot/cek-bot.sh"
  ;;
-rcb|rm_bot_cron)
  removeCrontab "botcb"
  ;;
start)
  /etc/init.d/telegram-bot start
  ;;
stop)
  /etc/init.d/telegram-bot stop
  ;;
restart)
  /etc/init.d/telegram-bot restart
  ;;
*)
  echo 'invalid params, -h for help'
  exit 1
  ;;
esac
