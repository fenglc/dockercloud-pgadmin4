FROM python:2-alpine
MAINTAINER fenglc <fenglc89@gmail.com>

COPY pgadmin4 /pgadmin4	

RUN set -x \
	&&  apk add --no-cache postgresql-libs \
	&&  apk add --no-cache --virtual .build-deps \
			gcc \
			postgresql-dev \
			musl-dev \
	&&  pip install -r /pgadmin4/requirements.txt \
	&&  cd /pgadmin4/web/ \
	&&  cp config.py config_local.py \
	&&  sed -i "s/SERVER_MODE = True/SERVER_MODE = False/g" config_local.py \
	&&  sed -i "s/DEFAULT_SERVER = 'localhost'/DEFAULT_SERVER = '0.0.0.0'/g" config_local.py \
	&&  apk del .build-deps \
	&&  rm -rf /root/.cache

# Metadata
LABEL org.label-schema.url="https://www.pgadmin.org" \
      org.label-schema.license="PostgreSQL" \
      org.label-schema.name="pgAdmin" \
      org.label-schema.version="4"

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5050
