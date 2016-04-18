FROM ubuntu

RUN apt-get update
RUN apt-get install -y x11vnc xvfb libxcursor1 ca-certificates bzip2 libglib2.0-0 libquazip-dev wget
RUN update-ca-certificates
RUN useradd sinusbot
RUN mkdir -p /sinusbot /sinusbot/TeamSpeak3-Client-linux_amd64/
RUN chown -R sinusbot:sinusbot /sinusbot
USER sinusbot
WORKDIR /sinusbot

RUN cd /sinusbot
RUN wget https://www.sinusbot.com/pre/sinusbot-0.9.11-ee30ef7.tar.bz2
RUN tar -xjf sinusbot-0.9.11-ee30ef7.tar.bz2

RUN wget http://dl.4players.de/ts/releases/3.0.18.2/TeamSpeak3-Client-linux_amd64-3.0.18.2.run
RUN chmod 0755 TeamSpeak3-Client-linux_amd64-3.0.18.2.run
RUN tail -c +25000 TeamSpeak3-Client-linux_amd64-3.0.18.2.run | tar -xzf- -C "TeamSpeak3-Client-linux_amd64/"
RUN cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins
RUN chmod 755 sinusbot
ADD config.ini config.ini
EXPOSE 8087
VOLUME "/sinusbot/data"
CMD ./sinusbot -RunningAsRootIsEvilAndIKnowThat
