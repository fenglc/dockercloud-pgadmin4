FROM python:2.7-alpine

# runtime dependencies
RUN set -ex \
	&& apk add --no-cache --virtual .pgadmin4-rundeps \
		bash \
		postgresql

ENV PGADMIN4_VERSION 3.0
ENV PGADMIN4_DOWNLOAD_URL https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v3.0/pip/pgadmin4-3.0-py2.py3-none-any.whl

# Metadata
LABEL org.label-schema.name="pgAdmin4" \
      org.label-schema.version="$PGADMIN4_VERSION" \
      org.label-schema.license="PostgreSQL" \
      org.label-schema.url="https://www.pgadmin.org" \
      org.label-schema.vcs-url="https://github.com/fenglc/dockercloud-pgAdmin4"

RUN set -ex \
	&& apk add --no-cache --virtual .build-deps \
		gcc \
		musl-dev \
		postgresql-dev \
	&& pip --no-cache-dir install \
		$PGADMIN4_DOWNLOAD_URL \
	&& apk del .build-deps

VOLUME /var/lib/pgadmin

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5050
CMD ["pgadmin4"]
