FROM weechat/weechat

# install deps
USER root
RUN apt update && apt install -y weechat-python python3-websocket curl libnotify-bin

# download weeslack
USER user
RUN mkdir -m 0777 -p ~/.local/share/weechat/python/autoload && chown -R user:user ~/.local/share/weechat
## download/autoload weeslack
RUN cd ~/.local/share/weechat/python && curl -O https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py && ln -s ../wee_slack.py autoload/
