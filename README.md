Requires docker/docker-compose. Then run `docker-compose up weeslack` to launch the container. Next, attach to the container in a new terminal with `docker attach weeslack`.

On your first run, you'll need to get a slack token with `/slack register`. Follow the instructions. Finally, save all your changes with `/save` so that when you restart the container, all your settings/sessions are saved.

To take a backup of your weeslack configuration, run `docker-compose up backup`. This will create a directory in your pwd with a tarball of your weeslack configs.

To restore a backup of your weeslack configuration, run `docker-compose up restore`. This will search pwd for a directory called `backup` that has the weeslack tarball in it and expand it into the weeslack docker volume.

The mouse works (Alt+m) but sometimes gets into an unknown state on startup. Try toggling it a couple of times to get it to work.

If you would like to get notified about chats, execute the included weeslacknotify.sh script with your nick as the only param, such as `./weeslacknotify.sh "@wahly"`. You may need to sudo the command. This will keep the script in the foreground. Include a "&" to background it, such as `./weeslacknotify.sh "@wahly" &`. If you background the script and want to stop/kill all the background processes that it spawns, you can call the script with the "stop" param like `./weeslacknotify.sh stop` and it will kill all the subprocesses it spawns. The notifier works by watch the chat log files. In order to get timely notifications, you may want to set your log flush to "0" by sending the following command to weechat `/set logger.file.flush_delay 0`.
