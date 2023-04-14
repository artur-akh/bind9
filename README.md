**Запуск контейнера BIND с двумя хостами:**<br>
```bash
docker run --name dns --rm -d \
-e ZONE_NAME=local \
-e REVERSE_ZONE_NAME=31.172 \
-e NS_IP=172.31.1.2 \
-e HOST_1_NAME=host1 \
-e HOST_1_IP=172.31.1.3 \
-e HOST_1_REVERSE=3.1 \
-e HOST_2_NAME=host2 \
-e HOST_2_IP=172.31.1.4 \
-e HOST_2_REVERSE=4.1 \
-p 53:53/udp \
-p 53:53/tcp \
arturakh/bind9:latest
```

**Compose:**<br>
```version: '3.9'
services:
  dns:
    image: arturakh/bind9:latest
    container_name: dns
    environment:
      ZONE_NAME: local
      REVERSE_ZONE_NAME: 31.172
      NS_IP: 172.31.1.2
      HOST_1_NAME: host1
      HOST_1_IP: 172.31.1.3
      HOST_1_REVERSE: 3.1
      HOST_2_NAME: host2
      HOST_2_IP: 172.31.1.4
      HOST_2_REVERSE: 4.1
    ports:
      - "53:53/udp"
      - "53:53/tcp"
    restart: always
```

**Volume:**<br>
```-v ./named.conf.options:/etc/bind/named.conf.options \\<br>
-v ./named.conf.local:/etc/bind/named.conf.local \\<br>
-v ./forward.my.zone:/etc/bind/forward.my.zone \\<br>
-v ./reverse.my.zone:/etc/bind/reverse.my.zone \\<br>```