# Do not change anything here except ARG. Real changes only in the main Dockerfile.
ARG NGINX_VERSION=1.9
FROM nginx:${NGINX_VERSION}
ENV TZ "Europe/Berlin"
ENV SSL_CERT_NAME "default.cert.name"
ENV SSL_REDIRECT "false"
RUN if [ `cat /etc/debian_version | cut -d . -f 1` -le 8 ]; then printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list; fi
RUN apt-get update && apt-get install -qy nginx openssl && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/
RUN rm /etc/nginx/conf.d/default.conf
ADD ./disable-ssl-redirect /usr/local/bin/
ADD ./enable-ssl-redirect /usr/local/bin/
ADD ./entrypoint.sh /usr/local/bin/
ADD ./nginx.conf /etc/nginx/conf.d/zz-default.conf
RUN chmod +x /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/disable-ssl-redirect && chmod +x /usr/local/bin/enable-ssl-redirect
ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
