FROM weechat/weechat

# install deps
USER root
RUN apt update && apt install -y weechat-python python3-websocket curl

# download weeslack
USER user
RUN mkdir -m 0777 -p ~/.weechat/python/autoload && chown -R user:user ~/.weechat/
## download/autoload weeslack
RUN cd ~/.weechat/python && curl -O https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py && ln -s ../wee_slack.py autoload/
## download/autoload remote-notify
RUN cd ~/.weechat/python && curl -O https://raw.githubusercontent.com/bahamas10/remote-notify/master/remote-notify.py && ln -s ../remote-notify.py autoload/
