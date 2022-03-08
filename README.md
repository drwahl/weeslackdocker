Requires docker/docker-compose. Then run `docker-compose up weeslack` to launch the container. Next, attach to the container in a new terminal with `docker attach weeslackdocker_weeslack_1`.

On your first run, you'll need to get a slack token with `/slack register`. Follow the instructions. Finally, save all your changes with `/save` so that when you restart the container, all your settings/sessions are saved.

To take a backup of your weeslack configuration, run `docker-compose up backup`. This will create a directory in your pwd with a tarball of your weeslack configs.

To restore a backup of your weeslack configuration, run `docker-compose up restore`. This will search pwd for a directory called `backup` that has the weeslack tarball in it and expand it into the weeslack docker volume.
