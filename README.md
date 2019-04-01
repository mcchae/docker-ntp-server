# NTP 서버 for docker container

이 컨테이너는 NTP 서비스를 구성합니다.

## 사용법
docker-compose 설정 파일로 다음과 같이 설정합니다.

```yaml
version: '2'

services:
  ntp:
    image: mcchae/ntp-server
    container_name: ntp_server
    ports:
    - "123:123/udp"
  ntptest:
    image: mcchae/ntp-server
    container_name: ntp_client
    links:
    - ntp
    command: /bin/sleep 1000```

* tftptest 는 테스트용 컨테이너

## 테스트

### tcpdump at ntp server
```sh
$ docker-compose exec ntp bash
/# tcpdump -i any -nn udp
```

### ntp client

```sh
$ docker-compose exec ntptest bash
root@149fd306800e:/# apt update && apt install -y iputils-ping ntpdate
root@149fd306800e:/# ntpdate -q -o 2 -dv -p 1 -t 1 ntp
 1 Apr 08:47:26 ntpdate[624]: ntpdate 4.2.8p10@1.3728-o (1)
Looking for host ntp and service ntp
192.168.160.2 reversed to ntp_server.docker-ntp-server_default
host found : ntp_server.docker-ntp-server_default
transmit(192.168.160.2)
receive(192.168.160.2)
server 192.168.160.2, port 123
stratum 5, precision -17, leap 00, trust 000
refid [192.168.160.2], delay 0.02611, dispersion 0.00000
transmitted 1, in filter 1
reference time:    e04c4e9d.3e582d5b  Mon, Apr  1 2019  8:47:25.243
originate timestamp: e04c4e9e.3e5a2943  Mon, Apr  1 2019  8:47:26.243
transmit timestamp:  e04c4e9e.3e45168b  Mon, Apr  1 2019  8:47:26.243
filter delay:  0.02611  0.00000  0.00000  0.00000
         0.00000  0.00000  0.00000  0.00000
filter offset: -0.00013 0.000000 0.000000 0.000000
         0.000000 0.000000 0.000000 0.000000
delay 0.02611, dispersion 0.00000
offset -0.000137

 1 Apr 08:47:26 ntpdate[624]: adjust time server 192.168.160.2 offset -0.000137 sec
```
