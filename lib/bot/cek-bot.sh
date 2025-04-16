#!/bin/sh

pgrep -f /root/telegram-bot/index.js > /dev/null
    if [ $? -eq 1 ]; then
    /etc/init.d/node-bot restart
fi
