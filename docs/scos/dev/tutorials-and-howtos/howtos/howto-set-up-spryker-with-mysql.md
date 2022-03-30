---
title: HowTo - Set up Spryker with MySQL
description: Use the guide to install Spryker to run with MySQL.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/ht-setup-spryker-with-mysql
originalArticleId: aab5461c-ee4c-4502-b70d-eafa4ed690e4
redirect_from:
  - /2021080/docs/ht-setup-spryker-with-mysql
  - /2021080/docs/en/ht-setup-spryker-with-mysql
  - /docs/ht-setup-spryker-with-mysql
  - /docs/en/ht-setup-spryker-with-mysql
  - /v6/docs/ht-setup-spryker-with-mysql
  - /v6/docs/en/ht-setup-spryker-with-mysql
  - /v5/docs/ht-setup-spryker-with-mysql
  - /v5/docs/en/ht-setup-spryker-with-mysql
  - /v4/docs/ht-setup-spryker-with-mysql
  - /v4/docs/en/ht-setup-spryker-with-mysql
  - /v3/docs/ht-setup-spryker-with-mysql
  - /v3/docs/en/ht-setup-spryker-with-mysql
  - /v2/docs/ht-setup-spryker-with-mysql
  - /v2/docs/en/ht-setup-spryker-with-mysql
  - /v1/docs/ht-setup-spryker-with-mysql
  - /v1/docs/en/ht-setup-spryker-with-mysql
---

Spryker supports MySQL database. To install it with this database, follow these instructions to adjust the configuration.

## MySQL Version
Currently Spryker works only with MySQL version 5.7 or higher.

##  Adjusting Spryker to Run with MySQL
To run the Spryker Demoshop with MySQL, adjust some parts in our configs:

1. Go to `config/Shared/config_default.php` and modify the database configuration:

```bash
$config[PropelConstants::ZED_DB_PORT] = 3306;
$config[PropelConstants::ZED_DB_ENGINE] = $config[PropelConstants::ZED_DB_ENGINE_MYSQL];
$config[PropelQueryBuilderConstants::ZED_DB_ENGINE] = $config[PropelConstants::ZED_DB_ENGINE_MYSQL];
```
2. Go to `deploy/setup/params.sh` and modify `DATABASE_DEFAULT_ENGINE` to MySQL:

```yaml
DATABASE_DEFAULT_ENGINE='mysql'
```
3. That's it. Now, run `vendor/bin/install` to install Spryker with MySQL.

## MySQL GroupBy Setting
In some MySQL servers, there is the `ONLY_FULL_GROUP_BY` option which forces all columns to be present in `group_by`. This option should be removed from your configurations of MySQL:

**Wrong setting:**

```bash
[mysqld]

# server mode
sql-mode = STRICT_ALL_TABLES,ONLY_FULL_GROUP_BY
```

**Correct setting:**

```bash
[mysqld]

# server mode
sql-mode = STRICT_ALL_TABLES
```
