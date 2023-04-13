FROM ubuntu/bind9

ENV ZONE_NAME=local \
    REVERSE_ZONE_NAME=31.172 \   
    NS_IP=172.31.16.83 \
    HOST_1_NAME=host1 \
    HOST_1_IP=172.31.26.127 \
    HOST_1_REVERSE=127.26 \    
    HOST_2_NAME=null \      
    HOST_2_IP=172.31.15.12 \       
    HOST_2_REVERSE=12.15 

WORKDIR /etc/bind/

COPY ["named.conf.options", \
      "named.conf.local", \
      "forward.my.zone", \
      "reverse.my.zone", \
	"entrypoint.sh", \
      "./"]

RUN chmod +x ./entrypoint.sh

EXPOSE 53/udp \
       53/tcp

CMD ["./entrypoint.sh"]