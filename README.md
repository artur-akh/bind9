**Запуск контейнера BIND с двумя хостами:**<br>
docker run --name dns --rm -d \\<br>
-e ZONE_NAME=local \\<br>
-e REVERSE_ZONE_NAME=31.172 \\<br>
-e NS_IP=172.31.1.2 \\<br>
-e HOST_1_NAME=host1 \\<br>
-e HOST_1_IP=172.31.1.3 \\<br>
-e HOST_1_REVERSE=3.1 \\<br>
-e HOST_2_NAME=host2 \\<br>
-e HOST_2_IP=172.31.1.4 \\<br>
-e HOST_2_REVERSE=4.1 \\<br>
-p 53:53/udp \\<br>
-p 53:53/tcp \\<br>
arturakh/bind9:latest

**Volume:**<br>
-v ./named.conf.options:/etc/bind/named.conf.options \\<br>
-v ./named.conf.local:/etc/bind/named.conf.local \\<br>
-v ./forward.my.zone:/etc/bind/forward.my.zone \\<br>
-v ./reverse.my.zone:/etc/bind/reverse.my.zone \\<br>