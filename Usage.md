## What is pgAdmin?

[pgAdmin](https://www.pgadmin.org) is an open source administration and management tool for the PostgreSQL database.

It is Free Software released under the [PostgreSQL License](https://www.pgadmin.org/licence.php).

## How to use

[![](https://img.shields.io/docker/pulls/fenglc/pgadmin4.svg)](https://hub.docker.com/r/fenglc/pgadmin4 "Click to view the image on Docker Hub") [![](https://images.microbadger.com/badges/image/fenglc/pgadmin4.svg)](http://microbadger.com/images/fenglc/pgadmin4 "Download size and number of layers") [![](https://images.microbadger.com/badges/license/fenglc/pgadmin4.svg)](https://www.pgadmin.org/licence.php "Click to view the license for this image")

In order to run a container with our image, execute:

```
docker run --name some-pgadmin4 \
           --link some-postgres:postgres \
           -p 5050:5050 \
           -d fenglc/pgadmin4
```

Then you can hit http://localhost:5050 or http://host-ip:5050 in your browser.

Use default administrator account to log in:

- user: pgadmin4@pgadmin.org
- password: admin

## Environment Variables

- ### DEFAULT_USER 
default 'pgadmin4@pgadmin.org'

- ### DEFAULT_PASSWORD
default 'admin'

- ### MAIL_SERVER
default 'localhost'

- ### MAIL_PORT
default 25

- ### MAIL_USE_SSL
default False

- ### MAIL_USE_TLS
default False

- ### MAIL_USERNAME
default None

- ### MAIL_PASSWORD
default None

## Screenshot

![dashboard](https://www.pgadmin.org/static/img/screenshots/pgadmin4-dashboard.png)

