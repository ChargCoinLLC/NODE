
# opkg update && opkg install ca-bundle ca-certificates && wget https://forum.charg.io/setup.sh -q -O /tmp/setup.sh.tmp && tr -d '\r' < /tmp/setup.sh.tmp > /tmp/setup.sh && chmod 755 /tmp/setup.sh && /tmp/setup.sh

setup_host=https://forum.charg.io/
wget $setup_host/node.tar.gz -q -O /tmp/node.tar.gz
cd /
tar xzf /tmp/node.tar.gz 
chmod 755 /usr/bin/init_service
chmod 755 /usr/bin/charg_service
chmod 755 /usr/bin/db_call
chmod 755 /usr/bin/format_sd
chmod 755 /www/cgi-bin/cgi-chg

echo "
config options station
        option address ''
        option state 'idle'
	
config options client
        option address ''
        option state ''

config options service
        option contract '0xC4A86561cb0b7EA1214904f26E6D50FD357C7986'
	option rpc 'rpc:http://localhost:8545'
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
	


