FROM golang:1.25-alpine

SHELL [ "ash", "-c" ]

ENV PATH=$PATH:/go/bin
ENV GOOS=linux
ENV CGO_ENABLED=0
ENV GOCACHE=/tmp/go-cache
ENV GOMODCACHE=/tmp/go-mod-cache

# Create appuser and set up home directory
RUN addgroup -g 1000 appuser && \
    adduser -D -u 1000 -G appuser appuser

WORKDIR /home/appuser

COPY ./cli /home/appuser/cli

# Change ownership of the copied files to appuser
RUN chown -R appuser:appuser /home/appuser

# Switch to appuser
USER appuser

RUN go mod init github.com/cyokozai/pvectl && \
    go get gopkg.in/yaml.v3@latest && \
    go get github.com/google/go-cmp/cmp@latest && \
    go get github.com/Telmate/proxmox-api-go@latest && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    go install golang.org/x/lint/golint@latest

CMD [ "tail", "-f", "/dev/null" ]
 