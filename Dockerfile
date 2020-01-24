FROM ubuntu:16.04

RUN apt-get update -y

# Variables
ARG CADDY_VERSION

ENV GOROOT /usr/local/go
ENV GOPATH $HOME/go
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH


# ========== Dependencies ===============
RUN apt-get install wget git -y

# Install go
RUN wget https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz
RUN tar -xvf go1.13.6.linux-amd64.tar.gz
RUN mv go /usr/local

ENV GOROOT /usr/local/go
ENV GOPATH $HOME/go
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# clone caddy
RUN git clone --branch  ${CADDY_VERSION} https://github.com/mholt/caddy /root/mholt/caddy 

# clone builder
RUN git clone https://github.com/caddyserver/caddy  /root/caddyserver/caddy

RUN mkdir -p /var/www/html
COPY index.html /var/www/html/index.html

#Disable Caddy Telemetry
RUN sed -i 's/var EnableTelemetry = true/var EnableTelemetry = false/' /root/mholt/caddy/caddy/caddymain/run.go

# build caddy
WORKDIR /root/mholt/caddy/caddy
RUN go install 

RUN cp $GOPATH/bin/caddy /usr/local/bin/

#copy caddy binary to host
RUN mkdir -p /docker-host
VOLUME /tmp/build_output/ /docker-host/
RUN cp $GOPATH/bin/caddy /docker-host/ 

WORKDIR /var/www/html
