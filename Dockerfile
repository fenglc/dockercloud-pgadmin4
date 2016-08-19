FROM python:2-alpine
MAINTAINER fenglc <fenglc89@gmail.com>

ENV PGADMIN4_VERSION 		1.0-beta4
ENV PGADMIN4_DOWNLOAD_URL	https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v1.0-beta4/pip/pgadmin4-1.0b4-py2-none-any.whl

RUN set -x \
	&&  apk add --no-cache postgresql-libs \
	&&  apk add --no-cache --virtual .build-deps \
			gcc \
			postgresql-dev \
			musl-dev \
	&&  pip install $PGADMIN4_DOWNLOAD_URL \
	&&  cd /usr/local/lib/python2.7/site-packages/pgadmin4 \
	&&  cp config.py config_local.py \
	&&  sed -i "s/SERVER_MODE = True/SERVER_MODE = False/g" config_local.py \
	&&  sed -i "s/DEFAULT_SERVER = 'localhost'/DEFAULT_SERVER = '0.0.0.0'/g" config_local.py \
	&&  apk del .build-deps \
	&&  rm -rf /root/.cache

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5050
