#!/bin/bash
set -e

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
		elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

if [ "$1" = 'pgadmin4' ]; then
	cd "$(python -c 'import os; print(os.path.dirname(os.__file__))')/site-packages/pgadmin4"

	if [ ! -f "config_local.py" ]; then
		cp config.py config_local.py
		sed -i "s/DEFAULT_SERVER = 'localhost'/DEFAULT_SERVER = '0.0.0.0'/g" config_local.py

		DATA_DIR="/var/lib/pgadmin4/data"
		mkdir -p $DATA_DIR
		sed -i "s:os.path.realpath(os.path.expanduser(u'~/.pgadmin/')):'${DATA_DIR}':" config_local.py

		file_env 'MAIL_SERVER' 'localhost'
		file_env 'MAIL_PORT'  "25"
		file_env 'MAIL_USE_SSL' "False"
		file_env 'MAIL_USE_TLS' "False"
		file_env 'MAIL_USERNAME' ''
		file_env 'MAIL_PASSWORD' ''

		sed -i "s/^MAIL_SERVER.*/MAIL_SERVER = '${MAIL_SERVER}'/; \
		        s/^MAIL_PORT.*/MAIL_PORT = ${MAIL_PORT}/; \
		        s/^MAIL_USE_SSL.*/MAIL_USE_SSL = ${MAIL_USE_SSL}/; \
		        s/^MAIL_USE_TLS.*/MAIL_USE_TLS = ${MAIL_USE_TLS}/; \
		        s/^MAIL_USERNAME.*/MAIL_USERNAME = '${MAIL_USERNAME}'/; \
		        s/^MAIL_PASSWORD.*/MAIL_PASSWORD = '${MAIL_PASSWORD}'/" \
		    config_local.py

		file_env 'DEFAULT_USER' 'pgadmin4@pgadmin.org'
		file_env 'DEFAULT_PASSWORD' 'admin'
		export PGADMIN_SETUP_EMAIL=${DEFAULT_USER}
		export PGADMIN_SETUP_PASSWORD=${DEFAULT_PASSWORD}

		python setup.py

		echo
		echo "pgAdmin4 init process done. Ready for start up."
		echo
	fi

	exec python pgAdmin4.py
else
	exec "$@"
fi
