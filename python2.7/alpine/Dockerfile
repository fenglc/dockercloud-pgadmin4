FROM python:2.7-alpine

ENV PGADMIN4_VERSION 2.1

# Metadata
LABEL org.label-schema.name="pgAdmin4" \
      org.label-schema.version="$PGADMIN4_VERSION" \
      org.label-schema.license="PostgreSQL" \
      org.label-schema.url="https://www.pgadmin.org" \
      org.label-schema.vcs-url="https://github.com/fenglc/dockercloud-pgAdmin4"

RUN set -ex \
	&& apk add --no-cache --virtual .run-deps \
		bash \
		postgresql \
		postgresql-libs \
	&& apk add --no-cache --virtual .build-deps \
		gcc \
		musl-dev \
		openssl \
		postgresql-dev \
	&& pip --no-cache-dir install \
		flask_htmlmin \
		https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v2.1/pip/pgadmin4-2.1-py2.py3-none-any.whl \
	&& apk del .build-deps

VOLUME /var/lib/pgadmin

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5050
CMD ["pgadmin4"]
