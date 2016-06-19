# dockercloud-pgAdmin4

## What is pgAdmin?

pgAdmin is an open source administration and management tool for the PostgreSQL database.

It is Free Software released under the [PostgreSQL License](https://www.pgadmin.org/licence.php).

## How to Build

Fork, then clone this repository.

```
cd dockercloud-pgAdmin4
git submodule init
git submodule update

docker build -t pgadmin4:latest .
docker run --name some-pgadmin4 -p 5050:5050 -d pgadmin4
```
Then you can hit http://localhost:5050 or http://host-ip:5050 in your browser.

## Screenshot
![dashboard](https://www.pgadmin.org/images/pgadmin4-dashboard.png)
