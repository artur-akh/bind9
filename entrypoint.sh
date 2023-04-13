#!/bin/bash
set -euo pipefail

# Логгирование в файл
exec &>> /var/log/my_script.log

# Определение переменных для файлов конфигурации
FORWARD_CONFIG="/etc/bind/forward.my.zone"
REVERSE_CONFIG="/etc/bind/reverse.my.zone"
LOCAL_CONFIG="/etc/bind/named.conf.local"

# Замена переменных в файле forward.my.zone
if ! sed -i "s|%ZONE_NAME%|$ZONE_NAME|g; s|%NS_IP%|$NS_IP|g; s|%HOST_1_IP%|$HOST_1_IP|g; s|%HOST_1_NAME%|$HOST_1_NAME|g; s|%HOST_2_IP%|$HOST_2_IP|g; s|%HOST_2_NAME%|$HOST_2_NAME|g;" "$FORWARD_CONFIG"; then
  echo "Failed to replace variables in $FORWARD_CONFIG"
  exit 1
fi

# Замена переменных в файле reverse.my.zone
if ! sed -i "s|%ZONE_NAME%|$ZONE_NAME|g; s|%HOST_1_NAME%|$HOST_1_NAME|g; s|%HOST_1_REVERSE%|$HOST_1_REVERSE|g; s|%HOST_2_NAME%|$HOST_2_NAME|g; s|%HOST_2_REVERSE%|$HOST_2_REVERSE|g;" "$REVERSE_CONFIG"; then
  echo "Failed to replace variables in $REVERSE_CONFIG"
  exit 1
fi

# Замена переменных в файле named.conf.local
if ! sed -i "s|%ZONE_NAME%|$ZONE_NAME|g; s|%REVERSE_ZONE_NAME%|$REVERSE_ZONE_NAME|g;" "$LOCAL_CONFIG"; then
  echo "Failed to replace variables in $LOCAL_CONFIG"
  exit 1
fi

# Изменение владельца файла rndc.key
if ! chown root:root /etc/bind/rndc.key; then
  echo "Failed to change owner of /etc/bind/rndc.key"
  exit 1
fi

# Проверка корректности конфигурации
if ! named-checkconf "$LOCAL_CONFIG" && named-checkconf "$FORWARD_CONFIG" && named-checkconf "$REVERSE_CONFIG"; then
  echo "Failed to check BIND9 configuration"
  exit 1
fi

# Запуск named в фоновом режиме
if ! /usr/sbin/named -g &; then
  echo "Failed to start BIND9"
  exit 1
fi

# Вывод сообщения об успешном запуске скрипта
echo "Start script -- ok"