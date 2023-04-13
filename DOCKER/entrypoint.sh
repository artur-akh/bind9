#!/bin/sh

sed -i 's|%ZONE_NAME%|'"$ZONE_NAME"'|g' /etc/bind/forward.my.zone
sed -i 's|%ZONE_NAME%|'"$ZONE_NAME"'|g' /etc/bind/named.conf.local
sed -i 's|%REVERSE_ZONE_NAME%|'"$REVERSE_ZONE_NAME"'|g' /etc/bind/named.conf.local
sed -i 's|%ZONE_NAME%|'"$ZONE_NAME"'|g' /etc/bind/reverse.my.zone

sed -i 's|%NS_IP%|'"$NS_IP"'|g' /etc/bind/forward.my.zone

sed -i 's|%HOST_1_IP%|'"$HOST_1_IP"'|g' /etc/bind/forward.my.zone
sed -i 's|%HOST_1_NAME%|'"$HOST_1_NAME"'|g' /etc/bind/forward.my.zone
sed -i 's|%HOST_1_NAME%|'"$HOST_1_NAME"'|g' /etc/bind/reverse.my.zone
sed -i 's|%HOST_1_REVERSE%|'"$HOST_1_REVERSE"'|g' /etc/bind/reverse.my.zone

sed -i 's|%HOST_2_IP%|'"$HOST_2_IP"'|g' /etc/bind/forward.my.zone
sed -i 's|%HOST_2_NAME%|'"$HOST_2_NAME"'|g' /etc/bind/forward.my.zone
sed -i 's|%HOST_2_NAME%|'"$HOST_2_NAME"'|g' /etc/bind/reverse.my.zone
sed -i 's|%HOST_2_REVERSE%|'"$HOST_2_REVERSE"'|g' /etc/bind/reverse.my.zone

chown root:root rndc.key
/usr/sbin/named -g
echo "Start script -- ok"