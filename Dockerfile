FROM ubuntu:15.10

ENV SINUSBOT_VERSION 0.9.15-b20cc30
ENV TS3_VERSION 3.0.19.4
ENV YOUTUBEDL_VERSION 2016.11.08.1

RUN apt-get update
RUN apt-get install -y x11vnc xvfb libxcursor1 ca-certificates bzip2 libglib2.0-0 libquazip-dev wget python
RUN update-ca-certificates
RUN useradd -u 3000 sinusbot
RUN mkdir -p /sinusbot /sinusbot/TeamSpeak3-Client-linux_amd64/
RUN chown -R sinusbot:sinusbot /sinusbot

RUN wget -q -O /usr/local/bin/youtube-dl https://github.com/rg3/youtube-dl/releases/download/$YOUTUBEDL_VERSION/youtube-dl
RUN chmod 775 -f /usr/local/bin/youtube-dl

USER sinusbot
WORKDIR /sinusbot
RUN mkdir /sinusbot/data

RUN wget https://www.sinusbot.com/pre/sinusbot-$SINUSBOT_VERSION.tar.bz2
RUN tar -xjf sinusbot-$SINUSBOT_VERSION.tar.bz2

RUN wget http://dl.4players.de/ts/releases/$TS3_VERSION/TeamSpeak3-Client-linux_amd64-$TS3_VERSION.run
RUN chmod 0755 TeamSpeak3-Client-linux_amd64-$TS3_VERSION.run
RUN tail -c +25000 TeamSpeak3-Client-linux_amd64-$TS3_VERSION.run | tar -xzf- -C TeamSpeak3-Client-linux_amd64/
RUN cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins
RUN chmod 755 sinusbot

ADD config.ini config.ini
EXPOSE 8087
VOLUME /sinusbot/data
CMD ./sinusbot
