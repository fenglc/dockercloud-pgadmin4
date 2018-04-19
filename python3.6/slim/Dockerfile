FROM python:3.6-slim

# hack to make postgresql-client install work on slim
RUN mkdir -p /usr/share/man/man1 \
    && mkdir -p /usr/share/man/man7

# runtime dependencies
RUN set -ex \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		postgresql-client \
	&& rm -rf /var/lib/apt/lists/*

ENV PGADMIN4_VERSION 3.0
ENV PGADMIN4_DOWNLOAD_URL https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v3.0/pip/pgadmin4-3.0-py2.py3-none-any.whl

# Metadata
LABEL org.label-schema.name="pgAdmin4" \
      org.label-schema.version="$PGADMIN4_VERSION" \
      org.label-schema.license="PostgreSQL" \
      org.label-schema.url="https://www.pgadmin.org" \
      org.label-schema.vcs-url="https://github.com/fenglc/dockercloud-pgAdmin4"

RUN set -ex \
	&& buildDeps="dpkg-dev \
		gcc \
		libssl-dev" \
	&& apt-get update \
	&& apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& pip --no-cache-dir install --upgrade pip \
	&& pip --no-cache-dir install $PGADMIN4_DOWNLOAD_URL \
	&& apt-get purge -y --auto-remove $buildDeps

VOLUME /var/lib/pgadmin

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5050
CMD ["pgadmin4"]
