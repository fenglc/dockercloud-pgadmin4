FROM alpine
MAINTAINER fenglc <fenglc89@gmail.com>

ENV PGADMIN4_VERSION 		1.0-beta1
ENV PGADMIN4_DOWNLOAD_URL	https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v1.0-beta1/pip/pgadmin4-1.0_beta1-py2-none-any.whl

RUN set -x \
	&& apk add --no-cache python-dev \
			py-pip \
			postgresql-dev \
			gcc \
			musl-dev  \
	&& 	pip install $PGADMIN4_DOWNLOAD_URL \
	&&	apk	del gcc musl-dev py-pip \
	&&	cd /usr/lib/python2.7/site-packages/pgadmin4 \
	&&	cp config.py config_local.py \
	&&	sed -i "s/SERVER_MODE = True/SERVER_MODE = False/g;s/DEFAULT_SERVER = 'localhost'/DEFAULT_SERVER = '0.0.0.0'/g" config_local.py \
	&&	rm -rf "/tmp/*" "/root/.cache"

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5050
