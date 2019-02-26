#!/usr/bin/env sh
if ! id ${APPLICATION_UID} >/dev/null 2>&1; then
    useradd --shell /bin/bash -u ${APPLICATION_UID} -G sudo -o -c '' -m ${APPLICATION_UID} -p ${APPLICATION_UID}
    rsync -av /home/application/ /home/${APPLICATION_UID}/
    chown -R ${APPLICATION_UID}:${APPLICATION_UID} /home/${APPLICATION_UID}
fi
