
#wget http://myreal.space/setup.sh -q -O /tmp/setup.sh.tmp && tr -d '\r' < /tmp/setup.sh.tmp > /tmp/setup.sh && chmod 755 /tmp/setup.sh && /tmp/setup.sh

opkg update
opkg install swap-utils fdisk block-mount ca-bundle ca-certificates e2fsprogs

setup_host=http://myreal.space

wget $setup_host/init_service -q -O /tmp/script.tmp && tr -d '\r' < /tmp/script.tmp > /usr/bin/init_service && chmod 755 /usr/bin/init_service
wget $setup_host/switch_service -q -O /tmp/script.tmp && tr -d '\r' < /tmp/script.tmp > /usr/bin/switch_service && chmod 755 /usr/bin/switch_service
wget $setup_host/db_call -q -O /usr/bin/db_call && chmod 755 /usr/bin/db_call


echo "

config options station
        option address '0x1aa494ff7a493e0ba002e2d38650d4d21bd5591b'
        option parking_rate 1
        option charging_rate 1
        option state 'idle'
		
config options client
        option address ''
        option state ''
		
config options service
        option contract '0xC4A86561cb0b7EA1214904f26E6D50FD357C7986'
		option rpc 'rpc:http://localhost:8545'
        option interval 10
        option switch_port 11
        option debug 0
		
" > /etc/config/node


echo "

init_service&
exit 0            
    
" > /etc/rc.local




	








