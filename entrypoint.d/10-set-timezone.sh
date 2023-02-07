#!/usr/bin/env sh

if [[ -n "${PHP_DATE_TIMEZONE+x}" ]]; then
  export TZ=${PHP_DATE_TIMEZONE}
fi

export PHP_DATE_TIMEZONE=${TZ}

echo ${TZ} >/etc/timezone

ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime

#dpkg-reconfigure -f noninteractive tzdata &> /dev/null
