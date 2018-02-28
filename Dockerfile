FROM maven:7-alpine

# Install Docker and dependencies
RUN apk --update add \
  bash \
  iptables \
  ca-certificates \
  e2fsprogs \
  docker \
  && chmod +x /usr/local/bin/wrapdocker \
  && rm -rf /var/cache/apk/*
