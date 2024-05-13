FROM ubuntu:22.04
COPY app/ /opt/app

RUN apt update && apt -y install libfontconfig1

EXPOSE 8080
WORKDIR /opt/app
CMD [ "/opt/app/multiplayer.sh","--server", "--headless" ]

