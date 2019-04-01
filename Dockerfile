FROM alpine:latest
MAINTAINER Jerry <mcchae@gmail.com>

# install openntp
RUN apk add --no-cache openntpd tcpdump

# use custom ntpd config file
COPY ntpd.conf /etc/ntpd.conf

# ntp port
EXPOSE 123/udp

# let docker know how to test container health
HEALTHCHECK CMD ntpctl -s status || exit 1

# start ntpd in the foreground
CMD [ "/usr/sbin/ntpd", "-v", "-d", "-s" ]
