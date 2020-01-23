FROM ubuntu:16.04

RUN apt-get update -y

# Variables
ARG CADDY_VERSION

# ========== Dependencies ===============
RUN apt-get install wget git -y
RUN wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz
RUN tar -xvf go1.13.3.linux-amd64.tar.gz
RUN mv go /usr/local
RUN echo "export GOROOT=/usr/local/go" >> $HOME/.bashrc
RUN echo "export GOPATH=$HOME/go" >> $HOME/.bashrc
RUN echo "export PATH=$PATH:$GOROOT/bin" >> $HOME/.bashrc
RUN . ~/.bashrc


# clone caddy
RUN git clone --branch  ${CADDY_VERSION} https://github.com/mholt/caddy mholt/caddy 

# clone builder
RUN git clone https://github.com/caddyserver/caddy  caddyserver/caddy

COPY index.html index.html

#Disable Caddy Telemetry
RUN sed -i 's/var EnableTelemetry = true/var EnableTelemetry = false/' ~/mholt/caddy/caddy/caddymain/run.go

# build caddy
RUN cd $HOME/mholt/caddy/caddy && go install 
