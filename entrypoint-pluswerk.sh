#!/usr/bin/env bash

rsync -av /home/application/.ssh/ /root/.ssh/
chown -R root:root /root/.ssh
