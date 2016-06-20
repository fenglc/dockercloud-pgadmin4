FROM alpine
MAINTAINER fenglc <fenglc89@gmail.com>

COPY pgadmin4 /pgadmin4	

RUN set -x \
	&& apk add --no-cache python-dev \
		py-pip \
		postgresql-dev \
		gcc \
		musl-dev \
	&& pip install -r /pgadmin4/requirements_py2.txt \
	&& apk del gcc musl-dev py-pip \
	&& rm -rf "/tmp/*" "/root/.cache" \
	&& cd /pgadmin4/web/ \
	&& cp config.py config_local.py \
	&& sed -i "s/SERVER_MODE = True/SERVER_MODE = False/g;s/DEFAULT_SERVER = 'localhost'/DEFAULT_SERVER = '0.0.0.0'/g" config_local.py
	
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5050
