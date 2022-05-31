---
title: Configuring New Relic logging
template: howto-guide-template
---

This document describes how to configure different types of New Relic logging.

## Configuring request logging

Every request is automatically logged by New Relic. The name of the requests is the name of the used route for Yves and the `[module]/[controller]/[action]` for Zed. Also, the URL request and the host are stored as custom parameters for each request.

To enable the New Relic monitoring extension, add it to the `MonitoringDependencyProvider` in your project:

```php
<?php
namespace Pyz\Service\Monitoring;

use Spryker\Service\Monitoring\MonitoringDependencyProvider as SprykerMonitoringDependencyProvider;
use SprykerEco\Service\NewRelic\Plugin\NewRelicMonitoringExtensionPlugin;

class MonitoringDependencyProvider extends SprykerMonitoringDependencyProvider
{
    /**
     * @return \Spryker\Service\MonitoringExtension\Dependency\Plugin\MonitoringExtensionPluginInterface[]
     */
    protected function getMonitoringExtensions(): array
    {
        return [
            new NewRelicMonitoringExtensionPlugin(),
        ];
    }
}
```

Additionally, you can add ignorable transactions in your config file - for example, `config/Shared/config_default.php`:

```php
use Spryker\Shared\Monitoring\MonitoringConstants;

// ---------- Monitoring
$config[MonitoringConstants::IGNORABLE_TRANSACTIONS] = [
    '_profiler',
    '_wdt',
    'page/catalog/my-endpoint',
];
```

## Error Logging

Every error is logged in New Relic along with its detailed stack trace.

## Configuring console command logging

To enable the Monitoring for console commands, edit `src/Pyz/Zed/Console/ConsoleDependencyProvider.php`:

```php
protected function getConsoleCommands(Container $container)
{
    $commands = [
        ...
        new \SprykerEco\Zed\NewRelic\Communication\Console\RecordDeploymentConsole(),
    ];
}

/**
 * @param \Spryker\Zed\Kernel\Container $container
 *
 * @return \Symfony\Component\EventDispatcher\EventSubscriberInterface[]
 */
public function getEventSubscriber(Container $container)
{
    $eventSubscriber = parent::getEventSubscriber($container);

    if (extension_loaded('newrelic')) {
        $eventSubscriber[] = new \Spryker\Zed\Monitoring\Communication\Plugin\MonitoringConsolePlugin();
    }

    return $eventSubscriber;
}
```

### Configuring deployment Logging

To use the deployment recording feature of New Relic, add your `api_key` and `deployment_api_url` to the project config. The API key is generated in your New Relic account. Open your account settings in New Relic and enable the API Access on the Data Sharing page. Once done, you get your API key. For more details, see [API Explorer](https://rpm.newrelic.com/api/explore).

```php
$config[\SprykerEco\Shared\NewRelic\NewRelicEnv::NEW_RELIC_API_KEY] = 'YOUR_API_KEY';
$config[\SprykerEco\Shared\NewRelic\NewRelicEnv::NEW_RELIC_DEPLOYMENT_API_URL] = 'NEW_RELIC_DEPLOYMENT_API_URL';
```

To retrieve `NEW_RELIC_DEPLOYMENT_API_URL`, see the official documentation about [Record Deployment](https://docs.newrelic.com/docs/apm/new-relic-apm/maintenance/record-deployments). The document should contain the environment application ID you want to register the deployment for.

For example: `https://api.newrelic.com/v2/applications/12345/deployments.json`

However, the latest version (1.1.0)  of the module allows passing a list of IDs to be able to record multiple deployments (for example, Yves and Zed for different stores) at once. In that case, the config has to be modified using the %s as a placeholder in the deployment URL:

```
$config[\SprykerEco\Shared\NewRelic\NewRelicEnv::NEW_RELIC_DEPLOYMENT_API_URL] =
    'https://api.newrelic.com/v2/applications/%s/deployments.json';
$config[\SprykerEco\Shared\NewRelic\NewRelicEnv::NEW_RELIC_APPLICATION_ID_ARRAY] = [
    'yves_de'   => '12345',
    'zed_de'    => '12346',
    'yves_us'   => '12347',
    'zed_us'    => '12348',
];
```
Therefore, you can use the record deployment functionality built-in in the console commands, as follows:

```
$ vendor/bin/console newrelic:record-deployment <app_name> <user> <revision> [<description>] [<changelog>]
```

where the first three arguments are mandatory. A real example of usage would be as follows:

```
$ vendor/bin/console newrelic:record-deployment MyStore user@gmail.com v1.2.0 "New version 1.2.0" "Fixed bugs in controller"
```
