FROM pluswerk/php-dev:nginx-7.2

RUN rm -rf /var/lib/apt/lists/* && \
  apt-get update && \
  apt-get install -y nginx-extras && \
  rm -rf /var/lib/apt/lists/*

COPY fancyindexing/ /opt/fancyindexing/

COPY nginx_vhost.conf /opt/docker/etc/nginx/vhost.conf
COPY nginx_10-location-root.conf /opt/docker/etc/nginx/vhost.common.d/10-location-root.conf

