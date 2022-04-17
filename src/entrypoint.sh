#!/bin/bash

if [ -z "$maildomain" ]; then
  export maildomain=localhost
  echo "WARNING: setting maildomain to localhost"
fi

/app/bin/setup-supervisor.sh
/app/bin/setup-postfix.sh
/app/bin/setup-sasl.sh
/app/bin/setup-tls.sh
/app/bin/setup-opendkim.sh

touch /etc/postfix/sasl_passwd
chmod 600 /etc/postfix/sasl_passwd
chmod 770 /etc/postfix
postmap /etc/postfix/sasl_passwd

if [ -x /app/opt/setup-postfix.sh ]; then
  /app/opt/setup-postfix.sh
fi

if [ "$*" != "" ]; then
  exec "$@"
  exit $?
fi

/etc/init.d/saslauthd restart
chmod a+rx /var/run/saslauthd
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
