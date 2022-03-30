---
title: Spryker Сore feature integration
description: The procedure to integrate Spryker Core feature into your project.
last_updated: Jun 17, 2021
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/spryker-core-feature-integration
originalArticleId: f99d3cf9-e933-4a3b-888e-72cf8f4ea31b
redirect_from:
  - /2021080/docs/spryker-core-feature-integration
  - /2021080/docs/en/spryker-core-feature-integration
  - /docs/spryker-core-feature-integration
  - /docs/en/spryker-core-feature-integration
  - /v20/docs/install-core-module
---

This document describes how to integrate the Spryker Core feature into a Spryker project.

{% info_block infoBox "Influded features" %}

The following feature integration guide expects the basic feature to be in place.
The current feature integration guide only adds the following functionalities:
* Vault
* Redis Session
* Store GUI
* Blocking too many failed login attempts

{% endinfo_block %}

## Install feature core

Follow the steps below to install the Spryker Core feature core.

### 1) Install the required modules using Composer

Run the following command to install the required modules:

```bash
composer require "spryker-feature/spryker-core":"{{page.version}}" --update-with-dependencies
```

{% info_block warningBox "Verification" %}

Make sure that the following modules have been installed:

| MODULE | EXPECTED DIRECTORY |
| --- | --- |
| UtilEncryption | vendor/spryker/util-encryption |
| Vault | vendor/spryker/vault |
| SessionExtension | vendor/spryker/session-extension |
| SessionRedis | vendor/spryker/session-redis |
| SessionFile | vendor/spryker/session-redis |
| StoreGui | vendor/spryker/store-gui |
| StorageExtension | vendor/spryker/storage-extension |
| StorageRedis | vendor/spryker/storage-redis |
| SecuritySystemUser | vendor/spryker/security-system-user |
| SecurityBlocker | vendor/spryker/security-blocker |

{% endinfo_block %}

### 2) Set up configuration

Set up the following configuration.

#### SecuritySystemUser

Add the configuration to your project:

| CONFIGURATION | SPECIFICATION | NAMESPACE |
| --- | --- | --- |
| SecuritySystemUserConstants::SYSTEM_USER_SESSION_REDIS_LIFE_TIME	 | Redis session lifetime | Spryker\Shared\SecuritySystemUser |
|SecuritySystemUserConstants::AUTH_DEFAULT_CREDENTIALS | Default credentials for Yves accessing Zed | Spryker\Shared\SecuritySystemUser |

{% info_block errorBox "Security measures" %}

Make sure that `SecuritySystemUserConstants::AUTH_DEFAULT_CREDENTIALS` is secured in your live environment. Otherwise, your backend system might be compromised by a malicious user.

{% endinfo_block %}


**config/Shared/config_local.php**

```php
<?php

use Spryker\Shared\SecuritySystemUser\SecuritySystemUserConstants;

$config[SecuritySystemUserConstants::SYSTEM_USER_SESSION_REDIS_LIFE_TIME] = 20;
$config[SecuritySystemUserConstants::AUTH_DEFAULT_CREDENTIALS] = [
    'yves_system' => [
        'token' => getenv('SPRYKER_ZED_REQUEST_TOKEN') ?: "ADJUST THIS TOKEN TO A SECURE ONE",
    ],
];
```

#### Vault

Add the configuration to your project:

| CONFIGURATION | SPECIFICATION | NAMESPACE |
| --- | --- | --- |
| VaultConstants::ENCRYPTION_KEY | Encrypts vault data. | Spryker\Shared\Vault |

{% info_block errorBox "Security measures" %}

Make sure that the encryption key is secured in your live environment. This key protects all the data stored in the Vault.

{% endinfo_block %}


**config/Shared/config_local.php**

```php
<?php

use Spryker\Shared\Vault\VaultConstants;

$config[VaultConstants::ENCRYPTION_KEY] = "ADJUST THIS ENCRYPTION KEY TO SECURE ONE"
```

Example

```php
$secret = "actual_secret";

$vaultFacade->store("secret_category", "secret_id", $secret);

assertSame($secret, $vaultFacade->retrieve("secret_category", "secret_id"));
```

#### Redis

Add the configuration to your project:

| CONFIGURATION | SPECIFICATION | NAMESPACE |
| --- | --- | --- |
| SessionRedisConstants::LOCKING_TIMEOUT_MILLISECONDS	 | Defines Redis lock timeout in milliseconds. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::LOCKING_RETRY_DELAY_MICROSECONDS	 | Defines the retry delay between the attempts to acquire Redis lock in microseconds. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::LOCKING_LOCK_TTL_MILLISECONDS	 | Defines the time to live for Redis lock in milliseconds. | Spryker\Shared\SessionRedis |
| SessionFileConstants::ZED_SESSION_FILE_PATH	 | Defines the filesystem path for storing Zed sessions. | Spryker\Shared\SessionFile |
| SessionRedisConstants::ZED_SESSION_REDIS_PROTOCOL	 | Defines the protocol used while connecting to Redis as Zed session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::ZED_SESSION_REDIS_PASSWORD	 | Defines the password used while connecting to Redis as Zed session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::ZED_SESSION_REDIS_HOST	 | Defines the host used while connecting to Redis as Zed session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::ZED_SESSION_REDIS_PORT	 | Defines the protocol used while connecting to Redis as Zed session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::ZED_SESSION_REDIS_DATABASE	 | Defines the database used while connecting to Redis as Zed session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::ZED_SESSION_REDIS_DATA_SOURCE_NAMES	 | Defines the list of DSNs used while connecting to Redis as Zed session storage in replication mode. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::ZED_SESSION_REDIS_CLIENT_OPTIONS	 | Defines the list of client options used while connecting to Redis as Zed session storage in replication mode. | Spryker\Shared\SessionRedis |
| StorageRedisConstants::STORAGE_REDIS_PROTOCOL	 | Defines the protocol used while connecting to Redis as key-value storage. | Spryker\Shared\StorageRedis |
| StorageRedisConstants::STORAGE_REDIS_PASSWORD	 | Defines the password used while connecting to Redis as key-value storage. | Spryker\Shared\StorageRedis |
| StorageRedisConstants::STORAGE_REDIS_HOST	 | Defines the host used while connecting to Redis as key-value storage. | Spryker\Shared\StorageRedis |
| StorageRedisConstants::STORAGE_REDIS_PORT	 | Defines the port used while connecting to Redis as key-value storage. | Spryker\Shared\StorageRedis |
| StorageRedisConstants::STORAGE_REDIS_DATABASE	 | Defines the database used while connecting to Redis as key-value storage. | Spryker\Shared\StorageRedis |
| StorageRedisConstants::STORAGE_REDIS_PERSISTENT_CONNECTION	 | Enables/disables data persistence for a Redis connection. | Spryker\Shared\StorageRedis |
| StorageRedisConstants::STORAGE_REDIS_DATA_SOURCE_NAMES	 | Specifies an array of DSN strings for a multi-instance cluster/replication Redis setup. | Spryker\Shared\StorageRedis |
| StorageRedisConstants::STORAGE_REDIS_CONNECTION_OPTIONS	 | Specifies an array of client options for connecting to Redis as key-value storage. | Spryker\Shared\StorageRedis |

#### General storage

* In case of a multi-instance Redis setup, extend your project with the following configuration:

**config/Shared/config_default.php**

```php
<?php

use Spryker\Shared\StorageRedis\StorageRedisConstants;

// ---------- KV storage
$config[StorageRedisConstants::STORAGE_REDIS_PERSISTENT_CONNECTION] = true;
$config[StorageRedisConstants::STORAGE_REDIS_PROTOCOL] = 'tcp';
$config[StorageRedisConstants::STORAGE_REDIS_HOST] = '127.0.0.1';
$config[StorageRedisConstants::STORAGE_REDIS_PORT] = 6379;
$config[StorageRedisConstants::STORAGE_REDIS_PASSWORD] = false;
$config[StorageRedisConstants::STORAGE_REDIS_DATABASE] = 0;
```

{% info_block warningBox "Note" %}

All the values in the examples above should be replaced with the real ones used in the corresponding environment.

{% endinfo_block %}

* In case of a single-instance Redis setup, extend your project with the following configuration:

**config/Shared/config_default.php**

```php
<?php

use Spryker\Shared\StorageRedis\StorageRedisConstants;

// ---------- KV storage
$config[StorageRedisConstants::STORAGE_REDIS_PERSISTENT_CONNECTION] = true;
$config[StorageRedisConstants::STORAGE_REDIS_PROTOCOL] = 'tcp';
$config[StorageRedisConstants::STORAGE_REDIS_HOST] = '127.0.0.1';
$config[StorageRedisConstants::STORAGE_REDIS_PORT] = 6379;
$config[StorageRedisConstants::STORAGE_REDIS_PASSWORD] = false;
$config[StorageRedisConstants::STORAGE_REDIS_DATABASE] = 0;
```

{% info_block warningBox "Note" %}

All the values in the examples above should be replaced with the real ones used in the corresponding environment.

{% endinfo_block %}

#### Session storage

If you're using Redis as session storage, extend your project with the following configuration:

**config/Shared/config_default.php**

```php
<?php

use Spryker\Shared\Session\SessionConfig;
use Spryker\Shared\Session\SessionConstants;
use Spryker\Shared\SessionRedis\SessionRedisConfig;
use Spryker\Shared\SessionRedis\SessionRedisConstants;

// ---------- Session
$config[SessionConstants::ZED_SESSION_SAVE_HANDLER] = SessionRedisConfig::SESSION_HANDLER_REDIS;
$config[SessionRedisConstants::ZED_SESSION_TIME_TO_LIVE] = SessionConfig::SESSION_LIFETIME_1_HOUR;
$config[SessionRedisConstants::LOCKING_TIMEOUT_MILLISECONDS] = 0;
$config[SessionRedisConstants::LOCKING_RETRY_DELAY_MICROSECONDS] = 0;
$config[SessionRedisConstants::LOCKING_LOCK_TTL_MILLISECONDS] = 0;
```

{% info_block warningBox "Note" %}

SessionRedisConfig::SESSION_HANDLER_REDIS_LOCKING and SessionRedisConfig::SESSION_HANDLER_REDIS can be used as values for SessionConstants::ZED_SESSION_SAVE_HANDLER.

{% endinfo_block %}

* In case of a multi-instance Redis setup, extend your project with the following configuration:

**config/Shared/config_default.php**

```php
<?php

use Spryker\Shared\SessionRedis\SessionRedisConstants;

$config[SessionRedisConstants::ZED_SESSION_REDIS_DATA_SOURCE_NAMES] = ['tcp://127.0.0.1:10009', 'tcp://10.0.0.1:6379'];
$config[SessionRedisConstants::ZED_SESSION_REDIS_CLIENT_OPTIONS] = [
    'replication' => 'sentinel',
    'service' => 'mymaster',
    'parameters' => [
        'password' => 'secret',
        'database' => 2,
    ],
];
```

{% info_block warningBox "Note" %}

This configuration is used exclusively. In other words, you can't use any other Redis configuration.

{% endinfo_block %}

* In case of a single-instance Redis setup, extend your project with the following configuration:

**config/Share/config_default.php**

```php
<?php

use Spryker\Shared\SessionRedis\SessionRedisConstants;

$config[SessionRedisConstants::ZED_SESSION_REDIS_PROTOCOL] = 'tcp';
$config[SessionRedisConstants::ZED_SESSION_REDIS_HOST] = '127.0.0.1';
$config[SessionRedisConstants::ZED_SESSION_REDIS_PORT] = 6379;
$config[SessionRedisConstants::ZED_SESSION_REDIS_PASSWORD] = false;
$config[SessionRedisConstants::ZED_SESSION_REDIS_DATABASE] = 2;
```

If you're using the file system as session storage, extend your project with the following configuration:

**config/Shared/config_default.php**

```php
<?php

use Spryker\Shared\Session\SessionConfig;
use Spryker\Shared\Session\SessionConstants;
use Spryker\Shared\SessionFile\SessionFileConfig;
use Spryker\Shared\SessionFile\SessionFileConstants;

// ---------- Session
$config[SessionConstants::ZED_SESSION_SAVE_HANDLER] = SessionFileConfig::SESSION_HANDLER_FILE;
$config[SessionFileConstants::ZED_SESSION_TIME_TO_LIVE] = SessionConfig::SESSION_LIFETIME_1_HOUR;
$config[SessionFileConstants::ZED_SESSION_FILE_PATH] = session_save_path();
```

{% info_block warningBox "Note" %}

All the values in the examples above should be replaced with the real ones used in the corresponding environment.

{% endinfo_block %}

#### Configuration for SecurityBlocker

SecurityBlocker stores the blocked accounts information in Redis. Thus, it needs the connection information to be provided. You can do it in the environment configuration of your project:

**config/Shared/config_default.php**

```php
$config[SecurityBlockerConstants::SECURITY_BLOCKER_REDIS_PERSISTENT_CONNECTION] = true;
$config[SecurityBlockerConstants::SECURITY_BLOCKER_REDIS_PROTOCOL] = 'tcp';
$config[SecurityBlockerConstants::SECURITY_BLOCKER_REDIS_HOST] = '127.0.0.1';
$config[SecurityBlockerConstants::SECURITY_BLOCKER_REDIS_PORT] = 6379;
$config[SecurityBlockerConstants::SECURITY_BLOCKER_REDIS_PASSWORD] = false;
$config[SecurityBlockerConstants::SECURITY_BLOCKER_REDIS_DATABASE] = 7;
```

Configure the blocking settings for the entity types you want to be blocking. You can set separate settings for a customer (default) and agent. `SecurityBlockerConstants::SECURITY_BLOCKER_BLOCKING_TTL`, `SecurityBlockerConstants::SECURITY_BLOCKER_BLOCK_FOR`, `SecurityBlockerConstants::SECURITY_BLOCKER_BLOCKING_NUMBER_OF_ATTEMPTS` are used as default, so if you use other entity types (like an agent) and do not provide this setting, the defaults will get applied.

`SecurityBlockerConstants::SECURITY_BLOCKER_BLOCKING_TTL` controls the period of time during which the `SecurityBlockerConstants::SECURITY_BLOCKER_BLOCKING_NUMBER_OF_ATTEMPTS` will be counted. In case the number is exceeded, the account will be locked for `SecurityBlockerConstants::SECURITY_BLOCKER_BLOCK_FOR` seconds.

Define your setting in your environment configuration files:

**config/Shared/config_default.php**

```php
$config[SecurityBlockerConstants::SECURITY_BLOCKER_BLOCKING_TTL] = 600;
$config[SecurityBlockerConstants::SECURITY_BLOCKER_BLOCK_FOR] = 300;
$config[SecurityBlockerConstants::SECURITY_BLOCKER_BLOCKING_NUMBER_OF_ATTEMPTS] = 10;

$config[SecurityBlockerConstants::SECURITY_BLOCKER_AGENT_BLOCKING_TTL] = 600;
$config[SecurityBlockerConstants::SECURITY_BLOCKER_AGENT_BLOCK_FOR] = 360;
$config[SecurityBlockerConstants::SECURITY_BLOCKER_AGENT_BLOCKING_NUMBER_OF_ATTEMPTS] = 9;
```

### 3) Set up database schema and transfer objects

Run the following commands to apply database changes, generate entity, and transfer changes:

```bash
console transfer:generate
console propel:install
console transfer:generate
```

{% info_block warningBox "Verificaiton" %}

Make sure that the following changes have been applied by checking your database:

| DATABASE ENTITY | TYPE | EVENT |
| --- | --- | --- |
| spy_vault_deposit | table | created |

{% endinfo_block %}


{% info_block warningBox "Verificaiton" %}

| TRANSFER | TYPE | EVENT | PATH |
| --- | --- | --- | --- |
| SpyVaultDepositEntityTransfer | class | created | src/Generated/Shared/Transfer/SpyVaultDepositEntityTransfer |
| VaultDepositTransfer | class | created | src/Generated/Shared/Transfer/VaultDepositTransfer |
| RedisConfigurationTransfer | class | created | src/Generated/Shared/Transfer/RedisConfigurationTransfer |
| RedisCredentialsTransfer | class | created | src/Generated/Shared/Transfer/RedisCredentialsTransfer |
| UserTransfer | class | created | src/Generated/Shared/Transfer/UserTransfer |
| MessageTransfer | class | created | src/Generated/Shared/Transfer/MessageTransfer |
| GroupCriteriaTransfer | class | created | src/Generated/Shared/Transfer/GroupCriteriaTransfer |
| GroupTransfer | class | created | src/Generated/Shared/Transfer/GroupTransfer |
| UserCriteriaTransfer | class | created | src/Generated/Shared/Transfer/UserCriteriaTransfer |
| SecurityCheckAuthContextTransfer | class | created | src/Generated/Shared/Transfer/SecurityCheckAuthContextTransfer |
| SecurityCheckAuthResponseTransfer | class | createdl | src/Generated/Shared/Transfer/SecurityCheckAuthResponseTransfer |
| SecurityBlockerConfigurationSettingsTransfer | class | created | src/Generated/Shared/Transfer/SecurityBlockerConfigurationSettingsTransfer |

{% endinfo_block %}

### 4) Set up behavior

Set up behavior as follows:

1. Install the following plugins with modules:

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE |
| --- | --- | --- | --- |
| SecurityApplicationPlugin | Extends Zed global container with required services for security functionality. | None | Spryker\Zed\Security\Communication\Plugin\Application |
| SessionHandlerFileProviderPlugin | Provides a file-based session handler implementation for Zed sessions. | None | Spryker\Zed\SessionFile\Communication\Plugin\Session |
| SessionHandlerRedisLockingProviderPlugin | Provides a Redis-based session handler implementation with session locking for Zed sessions. | None | Spryker\Zed\SessionRedis\Communication\Plugin\Session |
| SessionHandlerRedisProviderPlugin	 | Provides a Redis-based session handler implementation for Zed sessions. | None | Spryker\Zed\SessionRedis\Communication\Plugin\Session |
| StorageRedisPlugin | Provides a Redis-based storage implementation. | None | Spryker\Client\StorageRedis\Plugin |
| SystemUserSecurityPlugin | Sets security firewalls (rules, handlers) for system users (Yves access to Zed). | None | Spryker\Zed\SecurityGui\Communication\Plugin\Security |
| ZedSessionRedisLockReleaserPlugin | Removes session lock from Redis by session id for Zed sessions. It's used when removing previously created locks by running the ```session:lock:remove``` console command. | None | Spryker\Zed\SessionRedis\Communication\Plugin\Session |

**src/Pyz/Zed/Application/ApplicationDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\Application;

use Spryker\Zed\Application\ApplicationDependencyProvider as SprykerApplicationDependencyProvider;
use Spryker\Zed\Security\Communication\Plugin\Application\SecurityApplicationPlugin;

class ApplicationDependencyProvider extends SprykerApplicationDependencyProvider
{
    /**
     * @return \Spryker\Shared\ApplicationExtension\Dependency\Plugin\ApplicationPluginInterface[]
     */
    protected function getApplicationPlugins(): array
    {
        return [
            new SecurityApplicationPlugin(),
        ];
    }
}
```

**src/Pyz/Zed/Security/SecurityDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\Security;

use Spryker\Zed\Security\SecurityDependencyProvider as SprykerSecurityDependencyProvider;

class SecurityDependencyProvider extends SprykerSecurityDependencyProvider
{
    /**
     * @return \Spryker\Shared\SecurityExtension\Dependency\Plugin\SecurityPluginInterface[]
     */
    protected function getSecurityPlugins(): array
    {
        return [
            new SystemUserSecurityPlugin(),
        ];
    }
}
```

**src/Pyz/Zed/Session/SessionDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\Session;

use Spryker\Zed\Session\SessionDependencyProvider as SprykerSessionDependencyProvider;
use Spryker\Zed\SessionFile\Communication\Plugin\Session\SessionHandlerFileProviderPlugin;
use Spryker\Zed\SessionRedis\Communication\Plugin\Session\SessionHandlerRedisLockingProviderPlugin;
use Spryker\Zed\SessionRedis\Communication\Plugin\Session\SessionHandlerRedisProviderPlugin;
use Spryker\Zed\SessionRedis\Communication\Plugin\Session\ZedSessionRedisLockReleaserPlugin;

class SessionDependencyProvider extends SprykerSessionDependencyProvider
{
    /**
     * @return \Spryker\Shared\SessionExtension\Dependency\Plugin\SessionHandlerProviderPluginInterface[]
     */
    protected function getSessionHandlerPlugins(): array
    {
        return [
            new SessionHandlerRedisProviderPlugin(),
            new SessionHandlerRedisLockingProviderPlugin(),
            new SessionHandlerFileProviderPlugin(),
        ];
    }

    /**
     * @return \Spryker\Zed\SessionExtension\Dependency\Plugin\SessionLockReleaserPluginInterface[]
     */
    protected function getZedSessionLockReleaserPlugins(): array
    {
        return [
            new ZedSessionRedisLockReleaserPlugin(),
        ];
    }
}
```

**src/Pyz/Client/Storage/StorageDependencyProvider.php**

```php
<?php

namespace Pyz\Client\Storage;

use Spryker\Client\Storage\StorageDependencyProvider as SprykerStorageDependencyProvider;
use Spryker\Client\StorageExtension\Dependency\Plugin\StoragePluginInterface;
use Spryker\Client\StorageRedis\Plugin\StorageRedisPlugin;

class StorageDependencyProvider extends SprykerStorageDependencyProvider
{
    /**
     * @return \Spryker\Client\StorageExtension\Dependency\Plugin\StoragePluginInterface|null
     */
    protected function getStoragePlugin(): ?StoragePluginInterface
    {
        return new StorageRedisPlugin();
    }
}
```

{% info_block warningBox "Verification" %}

Visit zed.mysprykershop.com and make sure that Zed boots up without errors.

{% endinfo_block %}

2. Set up the console commands:

| COMMAND | SPECIFICATION | PREREQUISITES | NAMESPACE |
| --- | --- | --- | --- |
| StorageRedisExportRdbConsole | Exports a Redis database as an .rdb file. | None | Spryker\Zed\StorageRedis\Communication\Console |
| StorageRedisImportRdbConsole	 | Imports an rdb file.	 | None | Spryker\Zed\StorageRedis\Communication\Console |

**Pyz\Zed\Console\ConsoleDependencyProvider**

```php
<?php

namespace Pyz\Zed\Console;

use Spryker\Zed\Kernel\Container;
use Spryker\Zed\Console\ConsoleDependencyProvider as SprykerConsoleDependencyProvider;
use Spryker\Zed\StorageRedis\Communication\Console\StorageRedisExportRdbConsole;
use Spryker\Zed\StorageRedis\Communication\Console\StorageRedisImportRdbConsole;

class ConsoleDependencyProvider extends SprykerConsoleDependencyProvider
{
    /**
     * @param \Spryker\Zed\Kernel\Container $container
     *
     * @return \Symfony\Component\Console\Command\Command[]
     */
    protected function getConsoleCommands(Container $container)
    {
        $commands = [
            new StorageRedisExportRdbConsole(),
            new StorageRedisImportRdbConsole(),
        ];

        return $commands;
    }
}
```

{% info_block warningBox "Verification" %}

To verify that `StorageRedisExportRdbConsole` and `StorageRedisImportRdbConsole` are activated, check if the `vendor/bin/console storage:redis:export-rdb` and `vendor/bin/console storage:redis:import-rdb` console commands exist.

{% endinfo_block %}

3. Run the following command to build the navigation cache:

```bash
vendor/bin/console navigation:build-cache
```

{% info_block warningBox "Verification" %}

Make sure that the navigation for Store GUI is successfully generated by checking that, in the Back Office, the Administration menu item is present in the side bar and it has the Stores sub-item.

{% endinfo_block %}

### 5) Set up Publish and Synchronize

Follow the steps to set up Publish and Synchronize:

1. Update `RabbitMqConfig`:

**Pyz/Client/RabbitMq/RabbitMqConfig.php**

```php
<?php

namespace Pyz\Client\RabbitMq;

use Spryker\Client\RabbitMq\RabbitMqConfig as SprykerRabbitMqConfig;
use Spryker\Shared\Event\EventConfig;
use Spryker\Shared\Event\EventConstants;
use Spryker\Shared\GlossaryStorage\GlossaryStorageConfig;
use Spryker\Shared\Log\LogConstants;
use Spryker\Shared\UrlStorage\UrlStorageConstants;

class RabbitMqConfig extends SprykerRabbitMqConfig
{
    /**
     *  QueueNameFoo, // Queue => QueueNameFoo, (Queue and error queue will be created: QueueNameFoo and QueueNameFoo.error)
     *  QueueNameBar => [
     *       RoutingKeyFoo => QueueNameBaz, // (Additional queues can be defined by several routing keys)
     *   ],
     *
     * @see https://www.rabbitmq.com/tutorials/amqp-concepts.html
     *
     * @return array
     */
    protected function getQueueConfiguration(): array
    {
        return [
            EventConstants::EVENT_QUEUE => [
                EventConfig::EVENT_ROUTING_KEY_RETRY => EventConstants::EVENT_QUEUE_RETRY,
                EventConfig::EVENT_ROUTING_KEY_ERROR => EventConstants::EVENT_QUEUE_ERROR,
            ],
            GlossaryStorageConfig::SYNC_STORAGE_TRANSLATION,
            UrlStorageConstants::URL_SYNC_STORAGE_QUEUE,
            $this->get(LogConstants::LOG_QUEUE_NAME),
            // ...
        ];
    }

    /**
     * @return string
     */
    protected function getDefaultBoundQueueNamePrefix(): string
    {
        return 'error';
    }
}
```

2. Add `PublisherTriggerEventsConsole` to `ConsoleDependencyProvider`:

**Pyz/Zed/Console/ConsoleDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\Console;

use Spryker\Zed\Console\ConsoleDependencyProvider as SprykerConsoleDependencyProvider;
use Spryker\Zed\Publisher\Communication\Console\PublisherTriggerEventsConsole;

class ConsoleDependencyProvider extends SprykerConsoleDependencyProvider
{
    /**
     * @param \Spryker\Zed\Kernel\Container $container
     *
     * @return \Symfony\Component\Console\Command\Command[]
     */
    protected function getConsoleCommands(Container $container)
    {
        $commands = [
            // ...
            new PublisherTriggerEventsConsole(),
            // ...
        ];
        // ...
    }
}
```

3.  Add `PublisherSubscriber` to `EventDependencyProvider`:

**src/Pyz/Zed/Event/EventDependencyProvidder.php**

```php
<?php

namespace Pyz\Zed\Event;

use Spryker\Zed\Event\EventDependencyProvider as SprykerEventDependencyProvider;
use Spryker\Zed\Publisher\Communication\Plugin\Event\PublisherSubscriber;

class EventDependencyProvider extends SprykerEventDependencyProvider
{
    /**
     * @return \Spryker\Zed\Event\Dependency\EventSubscriberCollectionInterface
     */
    public function getEventSubscriberCollection()
    {
        $eventSubscriberCollection = parent::getEventSubscriberCollection();
        $eventSubscriberCollection->add(new GlossaryStorageEventSubscriber());
        $eventSubscriberCollection->add(new UrlStorageEventSubscriber());
        // ...
        $eventSubscriberCollection->add(new PublisherSubscriber());

        return $eventSubscriberCollection;
    }
}
```

## Install feature front end

Follow the steps below to install the front end of the Spryker Core feature.

### 1) Install the required modules using Composer

Run the following command to install the required modules:

```bash
composer require "spryker-feature/spryker-core": "{{page.version}}"
```

### 2) Set up configuration

Add the following configuration to your project:

| CONFIGURATION | SPECIFICATION | NAMESPACE |
| --- | --- | --- |
| SessionFileConstants::YVES_SESSION_FILE_PATH | Defines the filesystem path for storing Yves sessions. | Spryker\Shared\SessionFile |
| SessionRedisConstants::YVES_SESSION_REDIS_PROTOCOL | Defines the protocol used while connecting to Redis as Yves session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::YVES_SESSION_REDIS_PASSWORD | Defines the password used while connecting to Redis as Yves session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::YVES_SESSION_REDIS_HOST | Defines the host used while connecting to Redis as Yves session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::YVES_SESSION_REDIS_PORT | Defines the port used while connecting to Redis as Yves session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::YVES_SESSION_REDIS_DATABASE | Defines the database used while connecting to Redis as Yves session storage. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::YVES_SESSION_REDIS_DATA_SOURCE_NAMES | Defines the list of DSNs used while connecting to Redis as Yves session storage in replication mode. | Spryker\Shared\SessionRedis |
| SessionRedisConstants::YVES_SESSION_REDIS_CLIENT_OPTIONS | Defines the list of client options used while connecting to Redis as Yves session storage in replication mode. | Spryker\Shared\SessionRedis |

**config/Shared/config_default.php**

```php
<?php

use Spryker\Shared\Session\SessionConfig;
use Spryker\Shared\Session\SessionConstants;
use Spryker\Shared\SessionRedis\SessionRedisConfig;
use Spryker\Shared\SessionRedis\SessionRedisConstants;

// ---------- Session
$config[SessionConstants::YVES_SESSION_SAVE_HANDLER] = SessionRedisConfig::SESSION_HANDLER_REDIS_LOCKING;
$config[SessionRedisConstants::YVES_SESSION_TIME_TO_LIVE] = SessionConfig::SESSION_LIFETIME_1_HOUR;
```

{% info_block warningBox "Note" %}

`SessionRedisConfig::SESSION_HANDLER_REDIS_LOCKING` and `SessionRedisConfig::SESSION_HANDLER_REDIS` can be used as values for the session handler configuration option.

{% endinfo_block %}

* In case of a multi-instance Redis setup, extend your project with the following configuration:

**config/Shared/config_default.php**

```php
<?php

use Spryker\Shared\SessionRedis\SessionRedisConstants;

$config[SessionRedisConstants::YVES_SESSION_REDIS_DATA_SOURCE_NAMES] = ['tcp://127.0.0.1:10009', 'tcp://10.0.0.1:6379'];
$config[SessionRedisConstants::YVES_SESSION_REDIS_CLIENT_OPTIONS] = [
    'replication' => 'sentinel',
    'service' => 'mymaster',
    'parameters' => [
        'password' => 'secret',
        'database' => 1,
    ],
];
```

{% info_block warningBox "Note" %}

This configuration is used exclusively. In other words, you can't use any other Redis configuration.

{% endinfo_block %}


* In case of a single-instance Redis setup, extend your project with the following configuration:

**config/Share/config_default.php**

```php
<?php

use Spryker\Shared\SessionRedis\SessionRedisConstants;

$config[SessionRedisConstants::YVES_SESSION_REDIS_PROTOCOL] = 'tcp';
$config[SessionRedisConstants::YVES_SESSION_REDIS_HOST] = '127.0.0.1';
$config[SessionRedisConstants::YVES_SESSION_REDIS_PORT] = 6379;
$config[SessionRedisConstants::YVES_SESSION_REDIS_PASSWORD] = false;
$config[SessionRedisConstants::YVES_SESSION_REDIS_DATABASE] = 1;
```

{% info_block warningBox "Verification" %}

Make sure you don't use the same Redis database for Yves and Zed sessions.

{% endinfo_block %}

If you're using the file system as session storage, extend your project with the following configuration:

**config/Shared/config_default.php**

```php
<?php

use Spryker\Shared\Session\SessionConfig;
use Spryker\Shared\Session\SessionConstants;
use Spryker\Shared\SessionFile\SessionFileConfig;
use Spryker\Shared\SessionFile\SessionFileConstants;

// ---------- Session
$config[SessionConstants::YVES_SESSION_SAVE_HANDLER] = SessionFileConfig::SESSION_HANDLER_FILE;
$config[SessionFileConstants::YVES_SESSION_TIME_TO_LIVE] = SessionConfig::SESSION_LIFETIME_1_HOUR;
$config[SessionFileConstants::YVES_SESSION_FILE_PATH] = session_save_path();
```

{% info_block warningBox "Note" %}

All the values in the examples above should be replaced with the real ones used in the corresponding environment.

{% endinfo_block %}

#### SecurityBlocker

Let SecurityBlocker know the locale is used in the login check path:

**src/Pyz/Yves/SecurityBlockerPage/SecurityBlockerPageConfig.php**

```php
<?php

namespace Pyz\Yves\SecurityBlockerPage;

use SprykerShop\Yves\SecurityBlockerPage\SecurityBlockerPageConfig as SprykerSecurityBlockerPageConfig;

class SecurityBlockerPageConfig extends SprykerSecurityBlockerPageConfig
{
    /**
     * @return bool
     */
    public function isLocaleInCustomerLoginCheckPath(): bool
    {
        return true;
    }

    /**
     * @return bool
     */
    public function isLocaleInAgentLoginCheckPath(): bool
    {
        return true;
    }
}
```

{% info_block warningBox "Verification" %}

Make sure that when the login form for the customer or agent is submitted, the URL it uses contains a locale code. For example, `/de/login_check` would be the default value for the customer and `/de/agent/login_check` for the agent.

{% endinfo_block %}

{% info_block warningBox "Note" %}

Note that all of the locale-related configs in `CustomerPage`, `AgentPage`, and `SecurityBlockerPage` are deprecated and in future releases, only locale-specific URLs are going to be used.

{% endinfo_block %}

### 3) Add translations

Add translations as follows:

1. Append glossary according to your configuration:

**src/data/import/glossary.csv**

```yaml
error.429,Zu viele Anfragen,de_DE
error.429,Too Many Requests,en_US
security_blocker_page.error.account_blocked,"Too many log in attempts from your address. Please wait %minutes% minutes before trying again.",en_US
security_blocker_page.error.account_blocked,"Warten Sie bitte %minutes% Minuten, bevor Sie es erneut versuchen.",de_DE
```

2. Run the following command(s) to add the glossary keys:

```bash
console data:import:glossary
```

{% info_block warningBox "Verification" %}

Ensure that, in the database, the configured data has been added to the `spy_glossary_key` and `spy_glossary_translation` table.

{% endinfo_block %}

### 4) Set up behavior

Find the list of all the plugins and modules to install:

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE |
| --- | --- | --- | --- |
| SessionHandlerRedisProviderPlugin | Provides a Redis-based session handler implementation for Yves sessions. | None | Spryker\Yves\SessionRedis\Plugin\Session |
| SessionHandlerRedisLockingProviderPlugin | Provides a Redis-based session handler implementation with session locking for Yves sessions. | None | Spryker\Yves\SessionRedis\Plugin\Session |
| SessionHandlerFileProviderPlugin | Provides a file-based session handler implementation for Yves sessions. | None | Spryker\Yves\SessionFile\Plugin\Session |
| YvesSessionRedisLockReleaserPlugin | Removes session lock from Redis by session id for Yves sessions. It is used when removing previously created locks by running the `session:lock:remove` console command. | None | Spryker\Zed\SessionRedis\Communication\Plugin\Session
 |
| SecurityBlockerCustomerEventDispatcherPlugin | Adds subscribers for request and authentication failure events to control the customers' failed login attempts. | None | SprykerShop\Yves\SecurityBlockerPage\Plugin\EventDispatcher |
| SecurityBlockerAgentEventDispatcherPlugin | Adds subscribers for request and authentication failure events to control the agents' failed login attempts. | None | SprykerShop\Yves\SecurityBlockerPage\Plugin\EventDispatcher |

**src/Pyz/Yves/Session/SessionDependencyProvider.php**

```php
<?php

namespace Pyz\Yves\Session;

use Spryker\Yves\Session\SessionDependencyProvider as SprykerSessionDependencyProvider;
use Spryker\Yves\SessionFile\Plugin\Session\SessionHandlerFileProviderPlugin;
use Spryker\Yves\SessionRedis\Plugin\Session\SessionHandlerRedisLockingProviderPlugin;
use Spryker\Yves\SessionRedis\Plugin\Session\SessionHandlerRedisProviderPlugin;

class SessionDependencyProvider extends SprykerSessionDependencyProvider
{
    /**
     * @return \Spryker\Shared\SessionExtension\Dependency\Plugin\SessionHandlerProviderPluginInterface[]
     */
    protected function getSessionHandlerPlugins(): array
    {
        return [
            new SessionHandlerRedisProviderPlugin(),
            new SessionHandlerRedisLockingProviderPlugin(),
            new SessionHandlerFileProviderPlugin(),
        ];
    }
}
```

**src/Pyz/Zed/Session/SessionDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\Session;

use Spryker\Zed\Session\SessionDependencyProvider as SprykerSessionDependencyProvider;
use Spryker\Zed\SessionFile\Communication\Plugin\Session\SessionHandlerFileProviderPlugin;
use Spryker\Zed\SessionRedis\Communication\Plugin\Session\SessionHandlerRedisLockingProviderPlugin;
use Spryker\Zed\SessionRedis\Communication\Plugin\Session\SessionHandlerRedisProviderPlugin;
use Spryker\Zed\SessionRedis\Communication\Plugin\Session\YvesSessionRedisLockReleaserPlugin;
use Spryker\Zed\SessionRedis\Communication\Plugin\Session\ZedSessionRedisLockReleaserPlugin;

class SessionDependencyProvider extends SprykerSessionDependencyProvider
{
    /**
     * @return \Spryker\Zed\SessionExtension\Dependency\Plugin\SessionLockReleaserPluginInterface[]
     */
    protected function getYvesSessionLockReleaserPlugins(): array
    {
        return [
            new YvesSessionRedisLockReleaserPlugin(),
        ];
    }
}
```

{% info_block warningBox "Verification" %}

Visit mysprykershop.com and make sure that Yves boots up without errors.

{% endinfo_block %}

**src/Pyz/Yves/EventDispatcher/EventDispatcherDependencyProvider.php**

```php
<?php

namespace Pyz\Yves\EventDispatcher;

use Spryker\Yves\EventDispatcher\EventDispatcherDependencyProvider as SprykerEventDispatcherDependencyProvider;
use SprykerShop\Yves\SecurityBlockerPage\Plugin\EventDispatcher\SecurityBlockerAgentEventDispatcherPlugin;
use SprykerShop\Yves\SecurityBlockerPage\Plugin\EventDispatcher\SecurityBlockerCustomerEventDispatcherPlugin;

class EventDispatcherDependencyProvider extends SprykerEventDispatcherDependencyProvider
{
    /**
     * @return \Spryker\Shared\EventDispatcherExtension\Dependency\Plugin\EventDispatcherPluginInterface[]
     */
    protected function getEventDispatcherPlugins(): array
    {
        return [
            new SecurityBlockerCustomerEventDispatcherPlugin(),
            new SecurityBlockerAgentEventDispatcherPlugin(),
        ];
    }
}
```

{% info_block warningBox "Validation" %}

Make sure the `SecurityBlockerCustomerEventDispatcherPlugin` is activated correctly by attempting to sign in with the wrong credentials as a customer. After making the number of attempts you specified in `SecurityBlockerConstants::SECURITY_BLOCKER_BLOCKING_NUMBER_OF_ATTEMPTS`, the account should be blocked for `SecurityBlockerConstants::SECURITY_BLOCKER_BLOCK_FOR` seconds. Check that with the consequent login attempts you get the `429 Too many requests` error.

Repeat the same actions for the agent sign-in to check `SecurityBlockerAgentEventDispatcherPlugin`. The agent should get the blocking configuration specific for agents if you specified the agent-specific settings in step 2 of the feature core integration.

{% endinfo_block %}
