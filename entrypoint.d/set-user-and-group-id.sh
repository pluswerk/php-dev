#!/usr/bin/env sh
if ! id ${APPLICATION_UID} >/dev/null 2>&1; then
    usermod -u ${APPLICATION_UID} application
    groupmod -g ${APPLICATION_GID} application
fi
