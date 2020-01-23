FROM golang:1.13-alpine

ARG CADDY_VERSION

# install git
RUN apk add --no-cache git

# clone caddy
RUN git clone --branch  ${CADDY_VERSION} https://github.com/mholt/caddy mholt/caddy 

# clone builder
RUN git clone https://github.com/caddyserver/caddy  caddyserver/caddy

RUN mkdir /www
COPY index.html /www/index.html

# build caddy
RUN cd mholt/caddy/caddy \
    && go get ./... 
#    && go run main.go \
