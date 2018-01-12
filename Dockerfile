FROM ubuntu
# This file will be in the root of the repo, so a src folder must be present
RUN mkdir /home/src
COPY src /home/src
