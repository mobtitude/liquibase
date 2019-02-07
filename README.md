===================
mobtitude/liquibase
===================

The [Liquibase](http://www.liquibase.org) image, based on `java:jre-alpine` with mysql driver.

This image is inspired by `webdevops/liquibase`, but it's smaller and easier to maintain.


Usage
-----

Expecting the `changelog.xml` is inside the current directory the update process can be started with:

```
docker run --rm \
    -v "$(pwd)":/liquibase/ \
    -e LIQUIBASE_URL=jdbc:mysql://host/app \
    -e LIQUIBASE_USERNAME=root \
    -e LIQUIBASE_PASSWORD=root \
    mobtitude/liquibase update
```


Environment variables
---------------------

| Environment variable  | Description                        | Default                               |
|-----------------------|------------------------------------|---------------------------------------|
| `LIQUIBASE_VERSION`   | Installed Liquibase version        | *not changeable*                      |
| `LIQUIBASE_URL`       | DB url                             | *empty* (eg. `jdbc:mysql://host/app`) |
| `LIQUIBASE_USERNAME`  | DB username                        | *empty*                               |
| `LIQUIBASE_PASSWORD`  | DB password                        | *empty*                               |
| `LIQUIBASE_CHANGELOG` | Changelog file                     | `/liquibase/changelog.xml`            |
| `LIQUIBASE_CONTEXTS`  | Server contexts                    | *empty*                               |
| `LIQUIBASE_OPTS`      | Additional options                 | *empty*                               |


