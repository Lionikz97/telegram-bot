
/*
button keyboard
*/
const keymenu = [
  ['/menu', '/cpustat', '/reboot','/update'],
  ['/ping', '/uptime', '/time', '/clear'],
  ['/command','/cmd','/stopbot'],
  ['/process','/kill','/sub'],
  ['/restartbot','/speedtest','/firewall','/mmsmss'],
  ['/passwall','/button','/mmsms','/mmsmsd',],
  ['/adb','/vnstat','/vnstati','/dhcpl'],
  ['/service','/myip', '/help'],
  ['/getsms','/getcount','/infomodem','/sendsms'],
  ['/deletesms','/system','/proc','/ifconfig'],
  ['/curl','/wget','/git','/5ginfo'],
  ['/startup', '/crontab', '/synctime'],
  ['/pingall', '/readlog', '/clearlog', '/traceroute'],
 
];


/*
command
*/
const commands = [
    { command: 'service', description: 'service app start, stop dll' },
    { command: 'menu', description: 'show command bot' },
    { command: 'ping', description: 'ping google or ping a specified <host>'},
    { command: 'uptime', description: "view the bot's uptime" },
    { command: 'time', description: 'get the time from OpenWrt' },
    { command: 'clear', description: 'clear RAM cache' },
    { command: 'setnamebot', description: "set the bot's name" },
    { command: 'command', description: 'enable or disable the command menu' },
    { command: 'cmd', description: 'run a command as terminal' },
    { command: 'stopbot', description: 'stop the bot' },
    { command: 'process', description: 'view running application processes' },
    { command: 'restartbot', description: 'restart the bot' },
    { command: 'speedtest', description: 'perform a public speedtest' },
    { command: 'firewall', description: 'view all firewall rules' },
    
    { command: 'openclash', description: 'OpenClash menu' },
    { command: 'passwall', description: 'Passwall menu' },
    { command: 'button', description: 'enable or disable keyboard buttons' },
    { command: 'mmsms', description: 'Modem Manager menu' },
    { command: 'mmsmsd', description: 'delete SMS with Modem Manager' },
    { command: 'adb', description: 'ADB menu' },
    { command: 'vnstat', description: 'display vnstat information for the specified interface' },
    { command: 'vnstati', description: 'generate network monitoring images' },
    { command: 'dhcpl', description: 'view DHCP lease list' },
    { command: 'opkgup', description: 'update OpenWrt packages' },
    
    { command: 'opkglist', description: 'view installed packages' },
    { command: 'opkgin', description: 'install OpenWrt packages' },
    { command: 'help', description: 'display help information' },
    { command: 'upfile', description: 'upload a file, photo, video to OpenWrt with the specified document type' },
    { command: 'dlfile', description: 'send a file, photo, video from OpenWrt to the bot' },
    { command: 'getsms', description: 'SMS menu (only for Huawei modems)' },
    { command: 'getcount', description: 'view SMS inbox count (only for Huawei modems)' },
    { command: 'infomodem', description: 'view modem information (only for Huawei modems)' },
    { command: 'sendsms', description: 'send SMS (only for Huawei modems)' },
    { command: 'deletesms', description: 'delete SMS menu (only for Huawei modems)' },
    
    { command: 'system', description: 'system information' },
    { command: 'proc', description: 'CPU information' },
    { command: 'ifconfig', description: 'network information' },
    { command: 'reboot', description: 'reboot menu' },
    { command: 'opkgupg', description: 'upgrade OpenWrt packages' },
    { command: 'update', description: 'cek updates bot' },
    { command: 'base64', description: 'base64 decode and encode' },
    { command: 'curl', description: 'download a file from the web' },
    { command: 'wget', description: 'download a file from the web' },
    { command: 'git', description: 'git <command> / git clone' },
    
    { command: '3ginfo', description: '5ginfo menu modem 5g'},
    { command: 'myip', description: 'my ip information'},
    { command: 'cpustat', description: 'status cpu and temperature'},
    { command: 'crontab', description: 'crontab menu'},
    { command: 'startup', description: 'startup menu'},
    { command: 'synctime', description: 'sync time from web'},
    { command: 'pingall', description: 'pingall to host'},
    
    { command: 'readlog', description: 'read log error 10 line'},
    { command: 'clearlog', description: 'clear all log error'},
    { command: 'traceroute', description: 'hows the path packets take to a destination.'},
    { command: 'nslookup', description: 'queries DNS for domain information (IP addresses, etc.). '},
    { command: 'dnslookup', description: 'similar to nslookup; resolves domain names to IP addresses. '},

];
const listcomnd = commands.map(command => command.command);
/* */
//ping domain

const domains = ['google.com', 'github.com','facebook.com', 'whatsapp.com', 'cloudflare.com', 'x.com', '1.1.1.1', '8.8.8.8', '9.9.9.9', 'instagram.com', 'tiktok.com', 'yandex.com', ];
 
/*
menu command
*/
const today = new Date();
const currentHour = today.getHours();
const hours = String(today.getHours()).padStart(2, '0');
const minutes = String(today.getMinutes()).padStart(2, '0');
const seconds = String(today.getSeconds()).padStart(2, '0');
const time = `${hours}:${minutes}:${seconds}`;

let greeting;

if (hours >= 5 && hours < 12) {
  greeting = "good morning 🌅";
} else if (hours >= 12 && hours < 15) {
  greeting = "good afternoon ☀️";
} else if (hours >= 15 && hours < 18) {
  greeting = "good evening 🌄";
} else {
  greeting = "good night 🌃";
}

const listmenu = `
<blockquote>
━━━━━━━━━━━━━━━━━━━━━━━━━━
 ${greeting} || ${time}
 welcome to bot command 
 this is the command menu
━━━━━━━━━━━━━━━━━━━━━━━━━━
             					     OPENWRT
━━━━━━━━━━━━━━━━━━━━━━━━━━
» /dhcpl view DHCP lease list
» /cmd run a command as terminal 
» /clear clear RAM cache 
» /firewal view all firewall rules 
» /proc CPU information 
» /reboot reboot menu 
» /system system information
» /cpustat informasi cpu and temperature
» /service service app start, stop dll
» /ifconfig network information
» /time get the time from OpenWrt
» /vnstat display vnstat information for the specified interface
» /vnstati generate network monitoring images
» /startup startup menu
» /crontab crontab menu
» /synctime synctime from web
» /pingall ping all to host
» /infomodem view modem information

              						     BOT
━━━━━━━━━━━━━━━━━━━━━━━━━━
» /uptime view the bot's uptime
» /restartbot restart the bot
» /stopbot stop the bot
» /button enable or disable keyboard buttons
» /command enable or disable the command menu
» /setnamebot set the bot's name
» /update update bot
» /readlog read log error bot
» /dellog clear all log error bot
━━━━━━━━━━━━━━━━━━━━━━━━━━
              						     TOOL
━━━━━━━━━━━━━━━━━━━━━━━━━━

» /ping ping google or ping a specified host
» /myip my ip information
» /5ginfo menu modem 5g
» /speedtest perform a public speedtest
» /help display help information
» /traceroute shows the path packets take to a destination
» /nslookup similar to nslookup; resolves domain names to IP addresses
» /dnslookup queries DNS for domain information (IP addresses, etc.)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

</blockquote>
`; 


export { keymenu, commands, listmenu, listcomnd, domains };
