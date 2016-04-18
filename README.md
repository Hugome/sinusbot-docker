# sinusbot-docker
Simple usage :
```bash
docker run -d -p 8087:8087 -v /<yourdatafile>:/sinusbot/data hugome/sinusbot-docker
```
If you want custom config.ini :
```bash
docker run -d -p 8087:8087 -v /<yourdatafile>:/sinusbot/data -v /<yourconfigini>:/sinusbot/config.ini hugome/sinusbot-docker
```
