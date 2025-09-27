FROM golang:1.25-alpine

SHELL [ "ash", "-c" ]

ARG APPUSER

ENV PATH=$PATH:/go/bin
ENV GOOS=linux
ENV CGO_ENABLED=0
ENV GOCACHE=/tmp/go-cache
ENV GOMODCACHE=/tmp/go-mod-cache

WORKDIR /home/$APPUSER

COPY ./src /home/$APPUSER/src

RUN apk add --no-cache git && \
    go mod init github.com/cyokozai/pvectl && \
    go get gopkg.in/yaml.v3@latest && \
    go get github.com/google/go-cmp/cmp@latest && \
    go get github.com/Telmate/proxmox-api-go@latest && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    go install golang.org/x/lint/golint@latest && \
    adduser -D -s /bin/sh -u 1001 $APPUSER &&\
    mkdir /home/$APPUSER/src &&\
    chown -R $APPUSER:$APPUSER /home/$APPUSER/src && chmod -R 755 /home/$APPUSER/src

USER $APPUSER

WORKDIR /home/$APPUSER/src

CMD [ "tail", "-f", "/dev/null" ]
