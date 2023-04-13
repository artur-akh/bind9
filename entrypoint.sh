#!/bin/sh

# Определение переменных для файлов конфигурации
FORWARD_CONFIG=/etc/bind/forward.my.zone
REVERSE_CONFIG=/etc/bind/reverse.my.zone
LOCAL_CONFIG=/etc/bind/named.conf.local

# Замена переменных в файле forward.my.zone
sed -i "s|%ZONE_NAME%|$ZONE_NAME|g; s|%NS_IP%|$NS_IP|g; s|%HOST_1_IP%|$HOST_1_IP|g; s|%HOST_1_NAME%|$HOST_1_NAME|g; s|%HOST_2_IP%|$HOST_2_IP|g; s|%HOST_2_NAME%|$HOST_2_NAME|g;" $FORWARD_CONFIG

# Замена переменных в файле reverse.my.zone
sed -i "s|%ZONE_NAME%|$ZONE_NAME|g; s|%HOST_1_NAME%|$HOST_1_NAME|g; s|%HOST_1_REVERSE%|$HOST_1_REVERSE|g; s|%HOST_2_NAME%|$HOST_2_NAME|g; s|%HOST_2_REVERSE%|$HOST_2_REVERSE|g;" $REVERSE_CONFIG

# Замена переменных в файле named.conf.local
sed -i "s|%ZONE_NAME%|$ZONE_NAME|g; s|%REVERSE_ZONE_NAME%|$REVERSE_ZONE_NAME|g;" $LOCAL_CONFIG

# Изменение владельца файла rndc.key
chown root:root /etc/bind/rndc.key

# Запуск named в фоновом режиме
/usr/sbin/named -g &

# Вывод сообщения об успешном запуске скрипта
echo "Start script -- ok"



