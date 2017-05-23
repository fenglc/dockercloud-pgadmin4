FROM python:2-alpine
MAINTAINER fenglc <fenglc89@gmail.com>

# Metadata
LABEL org.label-schema.url="https://www.pgadmin.org" \
      org.label-schema.license="PostgreSQL" \
      org.label-schema.name="pgAdmin" \
      org.label-schema.version="4"
      
ENV SERVER_MODE=True
ENV DEFAULT_SERVER=0.0.0.0

ENV MAIL_SERVER=localhost
ENV MAIL_PORT=25
ENV MAIL_USE_SSL=False
ENV MAIL_USE_TLS=False
ENV MAIL_USERNAME=''
ENV MAIL_PASSWORD=''
ENV MAIL_DEBUG=False

COPY pgadmin4 /pgadmin4	

RUN set -x \
	&&  apk add --no-cache postgresql-libs \
	&&  apk add --no-cache --virtual .build-deps \
			gcc \
			postgresql-dev \
			musl-dev \
	&&  pip install -r /pgadmin4/requirements.txt \
	&&  apk del .build-deps \
	&&  rm -rf /root/.cache

# Configure
RUN set -x \
	&&  cd /pgadmin4/web/ \
	&&  cp config.py config_local.py \
	&&  sed -i "s/SERVER_MODE = True/SERVER_MODE = ${SERVER_MODE}/g" config_local.py \	
	&&  sed -i "s/DEFAULT_SERVER = 'localhost'/DEFAULT_SERVER = '${DEFAULT_SERVER}'/g" config_local.py \
	&&  sed -i "s/MAIL_SERVER = 'localhost'/MAIL_SERVER = '${MAIL_SERVER}'/g" config_local.py \ 
	&&  sed -i "s/MAIL_PORT = 25/MAIL_PORT = ${MAIL_PORT}/g" config_local.py \
	&&  sed -i "s/MAIL_USE_SSL = False/MAIL_USE_SSL = ${MAIL_USE_SSL}/g" config_local.py \
	&&  sed -i "s/MAIL_USE_TLS = False/MAIL_USE_TLS = ${MAIL_USE_TLS}/g" config_local.py \
	&&  sed -i "s/MAIL_USERNAME = ''/MAIL_USERNAME = '${MAIL_USERNAME}'/g" config_local.py \
	&&  sed -i "s/MAIL_PASSWORD = ''/MAIL_PASSWORD = '${MAIL_PASSWORD}'/g" config_local.py \
	&&  sed -i "s/MAIL_DEBUG = False/MAIL_DEBUG = ${MAIL_DEBUG}/g" config_local.py

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5050
