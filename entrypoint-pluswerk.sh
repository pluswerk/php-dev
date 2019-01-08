#!/usr/bin/env sh

# Copy SSH from application to root; Only if application SSH exists and root SSH folder is empty or not exists
if [ -d /home/application/.ssh ] && { [ ! -d /root/.ssh ] || [ -z "$(ls -A /root/.ssh)" ] ;}; then
    rsync -av /home/application/.ssh/ /root/.ssh/
    chown -R root:root /root/.ssh
fi;
