
# opkg update && opkg install ca-bundle ca-certificates && wget https://raw.githubusercontent.com/ChargCoinLLC/NODE/master/setup.sh -q -O /tmp/setup.sh.tmp && tr -d '\r' < /tmp/setup.sh.tmp > /tmp/setup.sh && chmod 755 /tmp/setup.sh && /tmp/setup.sh

setup_host=https://raw.githubusercontent.com/ChargCoinLLC/NODE/master/

mkdir -p /www/cgi-bin
mkdir -p /www/charg
printf  "."
wget $setup_host/usr/bin/init_service -q -O /tmp/script.tmp && tr -d '\r' < /tmp/script.tmp > /usr/bin/init_service && chmod 755 /usr/bin/init_service
printf  "."
wget $setup_host/usr/bin/charg_service -q -O /tmp/script.tmp && tr -d '\r' < /tmp/script.tmp > /usr/bin/charg_service && chmod 755 /usr/bin/charg_service
printf  "."
wget $setup_host/usr/bin/format_sd -q -O /tmp/script.tmp && tr -d '\r' < /tmp/script.tmp > /usr/bin/format_sd && chmod 755 /usr/bin/format_sd
printf  "."
wget $setup_host/www/cgi-bin/cgi-chg -q -O /tmp/script.tmp && tr -d '\r' < /tmp/script.tmp > /www/cgi-bin/cgi-chg && chmod 755 /www/cgi-bin/cgi-chg
printf  "."
wget $setup_host/www/charg/index.html -q -O /tmp/script.tmp && tr -d '\r' < /tmp/script.tmp > /www/charg/index.html
printf  "."
wget $setup_host/www/charg/login.html -q -O /tmp/script.tmp && tr -d '\r' < /tmp/script.tmp > /www/charg/login.html
printf  "."
wget $setup_host/www/charg/setup.html -q -O /tmp/script.tmp && tr -d '\r' < /tmp/script.tmp > /www/charg/setup.html
printf  "."
wget $setup_host/usr/bin/db_call -q -O /tmp/script.tmp && cp /tmp/script.tmp /usr/bin/db_call && chmod 755 /usr/bin/db_call
printf  "."

echo "
config options station
        option address ''
        option state 'idle'
		
config options client
        option address ''
        option state ''

config options service
        option contract '0xC4A86561cb0b7EA1214904f26E6D50FD357C7986'
	option rpc 'rpc:http://93.178.245.130:8845'
        option interval 5
        option switch_port 11
        option protocol secure
        option debug 0
	
" > /etc/config/node

echo "
init_service&
exit 0            
" > /etc/rc.local

if [ "$(opkg list-installed | grep swap-utils)" = "" ]; then
        opkg update
        opkg install swap-utils fdisk block-mount e2fsprogs
fi

echo " Done!"
