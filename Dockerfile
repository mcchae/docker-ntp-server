FROM alpine:latest
MAINTAINER Jerry <mcchae@gmail.com>

RUN apk add --no-cache \
    bash \
    coreutils \
    chrony \
    vim \
	tcpdump
COPY chronyd.sh /usr/bin/
COPY chrony.conf /var/lib/chrony/

# ntp port
EXPOSE 123/udp
CMD ["/usr/bin/chronyd.sh"]
