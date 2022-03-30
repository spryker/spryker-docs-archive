---
title: Redis Configuration
description: In Spryker, Redis is used as the key-value storage and the session data storage.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/redis-configruation
originalArticleId: ea89b3d3-30a2-41b6-8af7-cbd890ff5d18
redirect_from:
  - /2021080/docs/redis-configruation
  - /2021080/docs/en/redis-configruation
  - /docs/redis-configruation
  - /docs/en/redis-configruation
  - /v6/docs/redis-configruation
  - /v6/docs/en/redis-configruation
  - /v5/docs/redis-configruation
  - /v5/docs/en/redis-configruation
  - /v4/docs/redis-configruation
  - /v4/docs/en/redis-configruation
  - /v3/docs/redis-configruation
  - /v3/docs/en/redis-configruation
  - /v2/docs/redis-configruation
  - /v2/docs/en/redis-configruation
---

In Spryker, Redis is used in two scenarios:

* key-value storage (modules: `Spryker.Storage`, `Spryker.Collector` and `Spryker.Heartbeat`)
* session data storage (modules: `Spryker.Session`)

Each scenario uses a separate set of configuration values.

Advanced configuration allows to use Redis in replication mode, including support for Redis Sentinel.

## Standard configuration

Standard Redis client configuration uses the environment configuration values set under keys which are defined as constants in `config/Shared/config_default.php`. The standard environment configuration would look like this:

```php
$config[StorageConstants::STORAGE_REDIS_PROTOCOL] = 'tcp';
$config[StorageConstants::STORAGE_REDIS_HOST] = '127.0.0.1';
$config[StorageConstants::STORAGE_REDIS_PORT] = '10009';
$config[StorageConstants::STORAGE_REDIS_PASSWORD] = false;
$config[StorageConstants::STORAGE_REDIS_DATABASE] = 0;
```

## Advanced configuration for Redis key-value storage

To be able to use Redis replication, you need to define connection parameters using `StorageConstants::STORAGE_PREDIS_CLIENT_CONFIGURATION` value as key. Under this key, an array of DSN strings, which identify specific Redis nodes, should be set. In addition to configuration parameters, a set of configuration options has to be specified to enable Redis replication facilities. These options need to be stored under the `StorageConstants::STORAGE_PREDIS_CLIENT_OPTIONS` key.

Example (regular master-slave replication):

```php
$config[StorageConstants::STORAGE_PREDIS_CLIENT_CONFIGURATION] = [
    'tcp://10.0.0.1?alias=master',
    'tcp://10.0.0.2',
    'tcp://10.0.0.3',
];

$config[StorageConstants::STORAGE_PREDIS_CLIENT_OPTIONS] = [
    'replication' => true',
];
```

{% info_block infoBox %}

For this configuration, one of the Redis servers should be identified as master using the parameter `alias`.

{% endinfo_block %}

Configuration setup for Redis Sentinel would look like this:

```php
$config[StorageConstants::STORAGE_PREDIS_CLIENT_CONFIGURATION] = [
    'tcp://10.0.0.1',
    'tcp://10.0.0.2',
    'tcp://10.0.0.3',
];

$config[StorageConstants::STORAGE_PREDIS_CLIENT_OPTIONS] = [
    'replication' => 'sentinel',
    'service' => 'mymaster',
];
```

The configuration under `StorageConstants::STORAGE_PREDIS_CLIENT_CONFIGURATION` is to be used exclusively, for example, no other storage configuration will be used for the Redis client. If the configuration parameters are not set under the `StorageConstants::STORAGE_PREDIS_CLIENT_CONFIGURATION` key, the Redis client will fall back to the regular configuration described above.

## Advanced configuration for Redis session storage

All the configuration concepts described above are relevant for configuring Redis as a session storage. Two things to be considered are the name of configuration constants and the fact that Yves and Zed sessions have separate storages with distinct configuration sets. Redis session configuration uses constants from `\Spryker\Shared\Session\SessionConstants`. Configuration for Yves session to use Redis Sentinel would look like this:

```php
$config[SessionConstants::YVES_SESSION_PREDIS_CLIENT_CONFIGURATION] = [
    'tcp://10.0.0.1',
    'tcp://10.0.0.2',
    'tcp://10.0.0.3',
];

$config[SessionConstants::YVES_SESSION_PREDIS_CLIENT_OPTION] = [
    'replication' => 'sentinel',
    'service' => 'mymaster',
];
```

For Zed, it would look as follows:

```php
$config[SessionConstants::ZED_SESSION_PREDIS_CLIENT_CONFIGURATION] = [
    'tcp://10.0.0.1',
    'tcp://10.0.0.2',
    'tcp://10.0.0.3',
];

$config[SessionConstants::ZED_SESSION_PREDIS_CLIENT_OPTION] = [
    'replication' => 'sentinel',
    'service' => 'mymaster',
];
```

<!-- Last review date: Feb 19, 2019by Pavlo Asaulenko, Andrii Tserkovnyi -->
