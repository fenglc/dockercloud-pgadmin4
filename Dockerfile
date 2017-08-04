FROM python:3-alpine

ENV PGADMIN4_VERSION 1.6

# Metadata
LABEL org.label-schema.name="pgAdmin4" \
      org.label-schema.version="$PGADMIN4_VERSION" \
      org.label-schema.license="PostgreSQL" \
      org.label-schema.url="https://www.pgadmin.org" \
      org.label-schema.vcs-url="https://github.com/fenglc/dockercloud-pgAdmin4"

RUN set -ex \
	&& apk add --no-cache --virtual .run-deps \
		bash \
		postgresql-libs \
	&& apk add --no-cache --virtual .build-deps \
		openssl \
		gcc \
		postgresql-dev \
    postgresql-client \
		musl-dev \
	&& wget "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v$PGADMIN4_VERSION/pip/pgadmin4-$PGADMIN4_VERSION-py2.py3-none-any.whl" \
	&& pip install pgadmin4-$PGADMIN4_VERSION-py2.py3-none-any.whl \
	&& apk del .build-deps \
	&& rm pgadmin4-$PGADMIN4_VERSION-py2.py3-none-any.whl \
	&& rm -rf /root/.cache

VOLUME /var/lib/pgadmin4

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5050
CMD ["pgadmin4"]
