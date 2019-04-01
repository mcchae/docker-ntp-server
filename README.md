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

### ntp client

```sh
$ ntpdate -q 10.21.0.2
server 10.21.0.2, stratum 3, offset 0.010089, delay 0.02585
17 Sep 15:20:52 ntpdate[14186]: adjust time server 10.13.13.9 offset 0.010089 sec
```
