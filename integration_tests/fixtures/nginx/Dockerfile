# Nginx container including ContainerPilot
FROM alpine:3.15

# install nginx and tooling we need
RUN apk update && apk add \
    nginx \
    curl \
    && rm -rf /var/cache/apk/*

# add ContainerPilot build and configuration
COPY build/containerpilot /bin/containerpilot
COPY build/containerpilot /bin/consul-template
COPY etc /etc

EXPOSE 80

# by default use nginx-with-consul.json, allows for override in docker-compose
ENV CONTAINERPILOT=/etc/nginx-with-consul.json5

ENTRYPOINT [ "/bin/containerpilot" ]
