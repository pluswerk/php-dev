#!/usr/bin/env sh

updateFiles='0'
if ! getent group ${APPLICATION_GID} >/dev/null 2>&1; then
    groupmod -g ${APPLICATION_GID} application
    updateFiles='1'
fi

if ! getent passwd ${APPLICATION_UID} >/dev/null 2>&1; then
    usermod -u ${APPLICATION_UID} application
    updateFiles='1'
fi

if [ "${updateFiles}" == "1" ]; then
    # Find directories and exclude mounted device
    find /home/${APPLICATION_USER} -xdev -type d -print0 | while IFS= read -r -d '' directory; do
        if ! mountpoint -q "${directory}"; then
            chown "${APPLICATION_USER}":"${APPLICATION_GROUP}" ${directory}

            # Find files and symlinks in current directory
            find ${directory} -maxdepth 1 \( -type f -o -type l \) -print0 | while IFS= read -r -d '' filename; do
                if ! mountpoint -q "${filename}"; then
                    chown -h "${APPLICATION_USER}":"${APPLICATION_GROUP}" ${filename}
                fi
            done
        fi
    done
fi
