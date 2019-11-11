#!/bin/bash

PORT=9292
LOG_FILE=./out.log

function tee_logs {
  echo "$@" | tee -a "${LOG_FILE}"
}

tee_logs "Starting txgh"
setsid bundle exec rackup --host 0.0.0.0 -E production -p ${PORT} &>> out.log &

tee_logs "Checking for nginx config changes"
NGINX_CHANGES=$(diff ./nginx/ssl.conf /etc/nginx/conf.d/ssl.conf)
if [[ -n ${NGINX_CHANGES} ]]; then
  tee_logs "Nginx changed.  Backing up config and copying new config into place."
  cp /etc/nginx/conf.d/ssl.conf{,.bak}
  cp ./nginx/ssl.conf /etc/nginx/conf.d/ssl.conf
fi

tee_logs "Reloading nginx"
docker exec ec2-user_nginx_1 nginx -s reload
