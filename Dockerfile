FROM golang:1.8-alpine

USER root

RUN export GOPATH=$HOME/go && \
    export PATH=$PATH:$GOPATH/bin && \
    apk update && apk upgrade && \
    apk add --no-cache bash git openssh

ENV GREMLIN_PROXY="$GOPATH/src/github.com/gremlinproxy"

RUN mkdir -p "$GREMLIN_PROXY"
RUN cd "$GOPATH/src/github.com" && \
    git clone https://github.com/worldtiki/gremlinproxy.git && \
    cd "$GREMLIN_PROXY" && \
    go-wrapper download && \
    go-wrapper install

# Expose gremlinproxy's control port.
EXPOSE 9876

ENTRYPOINT ["gremlinproxy"]
