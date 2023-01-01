FROM alpine:3.8

RUN apk add --no-cache pdftk bash

WORKDIR /

ADD merge.sh ./

VOLUME [ "/in", "/out" ]

ENTRYPOINT [ "./merge.sh" ]
