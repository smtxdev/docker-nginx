#!/usr/bin/env bash
set -e

if [ ! -f "/certs/$SSL_CERT_NAME" ]; then
     mkdir -p /etc/nginx/ssl/ && openssl req \
        -x509 \
        -subj "/CN=${SSL_CERT_NAME}" \
        -nodes \
        -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.cert
    mkdir -p /certs
    touch /certs/$SSL_CERT_NAME
fi

if [ "$SSL_REDIRECT" == "true" ]; then
    enable-ssl-redirect
else
    disable-ssl-redirect
fi
exec "$@"
