FROM alpine:3.12

MAINTAINER Rubén Cabrera Martínez <dev@rubencabrera.es>

RUN apk update && apk add perl perl-libwww curl jq
ADD source /app
WORKDIR /app
RUN ["sh", "./install.sh"]
ENTRYPOINT ["./entrypoint.sh"]
