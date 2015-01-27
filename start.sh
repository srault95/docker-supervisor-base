#!/bin/sh

echo "--> start.sh script running..."

run-parts -v --report /etc/setup.d

envtpl /etc/supervisor/supervisord.conf.tpl  --allow-missing --keep-template

echo "---> Starting supervisord..."
exec /usr/local/bin/supervisord --nodaemon -c /etc/supervisor/supervisord.conf
