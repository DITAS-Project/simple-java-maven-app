FROM maven:3-alpine


# Install Docker and dependencies
RUN apk --update add \
  bash \
  iptables \
  ca-certificates \
  e2fsprogs \
  docker \
  && rm -rf /var/cache/apk/*
 
