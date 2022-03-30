---
title: Scheduled Prices feature integration
description: Learn how to integrate the Scheduled prices feature into your project.
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v3/docs/scheduled-prices-feature-integration-201907
originalArticleId: ae10b89a-c59e-4950-a5e6-e494d8b1f1af
redirect_from:
  - /v3/docs/scheduled-prices-feature-integration-201907
  - /v3/docs/en/scheduled-prices-feature-integration-201907
---


## Install Feature Core

### Prerequisites

To start feature integration, review and install the necessary features:

| Name | Version |
| --- | --- |
| Spryker Core | 201907.0 |
| Product | 201907.0 |
| Price | 201907.0 |

### 1) Install the required modules using Composer

Run the following command to install the required modules:

```bash
composer require spryker-feature/scheduled-prices:"^201907.0" --update-with-dependencies
```

{% info_block warningBox "Verification" %}
Make sure that the following module has been installed:<table><thead><tr><th>Module</th><th>Expected Directory</th></tr></thead><tbody><tr><td>`PriceProductSchedule`</td><td>`vendor/spryker/price-product-schedule`</td></tr><tr><td>`PriceProductScheduleDataImport`</td><td>`vendor/spryker/price-product-schedule-data-import`</td></tr><tr><td>`PriceProductScheduleGui`</td><td>`vendor/spryker/price-product-schedule-gui`</td></tr></tbody></table>
{% endinfo_block %}

### 2) Set up Database Schema and Transfer Objects

Run the following commands to:

* apply database changes
* generate entity and transfer changes

```bash
console transfer:generate
console propel:install
console transfer:generate
```

 {% info_block warningBox "Verification" %}
Make sure that the following changes have been applied by checking your database:<table><thead><tr><th>Database Entity</th><th>Type</th><th>Event</th></tr></thead><tbody><tr><td>`spy_price_product_schedule`</td><td>table</td><td>created</td></tr><tr><td>`spy_price_product_schedule_list`</td><td>table</td><td>created</td></tr></tbody></table>
{% endinfo_block %}

{% info_block warningBox "Verification" %}
Make sure that the following changes in transfer objects have been applied:<table><thead><tr><th>Transfer</th><th>Type</th><th>Event</th><th>Path</th></tr></thead><tbody><tr><td>`PriceProductScheduleTransfer`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/PriceProductScheduleTransfer`</td></tr><tr><td>`PriceProductScheduleListTransfer`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/PriceProductScheduleListTransfer`</td></tr><tr><td>`PriceProductScheduleCriteriaFilterTransfer`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/PriceProductScheduleCriteriaFilterTransfer`</td></tr><tr><td>`SpyPriceProductScheduleEntityTransfer`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/SpyPriceProductScheduleEntityTransfer`</td></tr><tr><td>`SpyPriceProductScheduleListEntityTransfer`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/SpyPriceProductScheduleListEntityTransfer`</td></tr></tbody></table>
{% endinfo_block %}

### 3) Import Data

#### Import Price Product Schedules

{% info_block infoBox "Info" %}
The following imported entities will be used as product price schedules in Spryker OS.
{% endinfo_block %}

Prepare your data according to your requirements using our demo data:

<details open>
    <summary markdown='span'>vendor/spryker/spryker/Bundles/PriceProductScheduleDataImport/data/import</summary>

```yaml
abstract_sku,concrete_sku,price_type,store,currency,value_net,value_gross,from_included,to_included
001,,DEFAULT,DE,CHF,9832,10924,2019-01-01T00:00:00-00:00,2019-12-31T23:59:59-00:00
001,,DEFAULT,DE,CHF,7762,8624,2019-05-01T00:00:00-00:00,2019-06-30T23:59:59-00:00
001,,DEFAULT,DE,CHF,3881,4312,2019-06-23T00:00:00-00:00,2019-07-19T23:59:59-00:00
001,,DEFAULT,DE,EUR,8549,9499,2019-01-01T00:00:00-00:00,2019-12-31T23:59:59-00:00
001,,DEFAULT,DE,EUR,6749,7499,2019-05-01T00:00:00-00:00,2019-06-30T23:59:59-00:00
001,,DEFAULT,DE,EUR,3375,3750,2019-06-23T00:00:00-00:00,2019-07-19T23:59:59-00:00
,060_26027598,DEFAULT,DE,CHF,30902,34337,2019-05-01T00:00:00-00:00,2019-06-30T23:59:59-00:00
,060_26027598,DEFAULT,DE,CHF,15451,17169,2019-06-23T00:00:00-00:00,2019-07-19T23:59:59-00:00
,060_26175504,DEFAULT,AT,CHF,32909,36566,2019-01-01T00:00:00-00:00,2019-12-31T23:59:59-00:00
,060_26175504,DEFAULT,AT,CHF,25981,28868,2019-05-01T00:00:00-00:00,2019-06-30T23:59:59-00:00
,060_26175504,DEFAULT,AT,CHF,12991,14434,2019-06-23T00:00:00-00:00,2019-07-19T23:59:59-00:00
,060_26175504,DEFAULT,AT,EUR,28616,31797,2019-01-01T00:00:00-00:00,2019-12-31T23:59:59-00:00
,060_26175504,DEFAULT,AT,EUR,22592,25103,2019-05-01T00:00:00-00:00,2019-06-30T23:59:59-00:00
,060_26175504,DEFAULT,AT,EUR,11296,12552,2019-06-23T00:00:00-00:00,2019-07-19T23:59:59-00:00
```
<br>
</details>
    
| Column | REQUIRED? | Data Type | Data Example | Data Explanation |
| --- | --- | --- | --- | --- |
|  `abstract_sku` | optional | string | 001 | Existing abstract product SKU of scheduled price. |
|  `concrete_sku` | optional | string | 060_26027598 | Existing concrete product SKU of scheduled price. |
|  `price_type` | mandatory | string | DEFAULT | Name of a price type. By default, it's "DEFAULT", but can be project specific (strike, sale,...). |
|  `store` | mandatory | string | DE | Store name of scheduled price. |
|  `currency` | mandatory | string | CHF | Currency ISO code. |
|  `currency` | mandatory | string | CHF | Currency ISO code. |
|  `value_net` | optional | integer | 9832 | Net price in cents. |
|  `value_gross` | optional | integer | 10924 | Gross price in cents. |
|  `from_included` | mandatory | datetime | 2019-01-01T00:00:00-00:00 | Start date of scheduled price (should be less than `to_included`). |
|  `to_included` | mandatory | datetime | 2019-12-31T23:59:59-00:00 | End date of scheduled price. |

Register the following plugin to enable data import:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `PriceProductScheduleDataImportPlugin` | Imports scheduled prices data into database. | None |  `\Spryker\Zed\PriceProductScheduleDataImport\Communication\Plugin` |

<details open>
    <summary markdown='span'>src/Pyz/Zed/DataImport/DataImportDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\DataImport;

use Spryker\Zed\DataImport\DataImportDependencyProvider as SprykerDataImportDependencyProvider;
use Spryker\Zed\PriceProductScheduleDataImport\Communication\Plugin\PriceProductScheduleDataImportPlugin;

class DataImportDependencyProvider extends SprykerDataImportDependencyProvider
{
    /**
     * @return array
     */
    protected function getDataImporterPlugins(): array
    {
        return [
            new PriceProductScheduleDataImportPlugin(),
        ];
    }
}
```
<br>
</details>

Run the following console command to import data:

```bash
console data:import:product-price-schedule
```

{% info_block warningBox "Verification" %}
Make sure that in the database the configured data has been added to the `spy_price_product_schedule` table.
{% endinfo_block %}

### 4) Set up Behavior

Enable the following behaviors by registering the console commands, view and tab plugins:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `PriceProductScheduleApplyConsole` | <ul><li>Applies scheduled prices for the current store.</li><li>Persists a price product store for the applied scheduled product price.</li><li>Disables irrelevant product price schedules for the applied scheduled products price.</li><li>Reverts product prices from the fallback price type for scheduled product prices that are finished.</li></ul> | None |  `Spryker\Zed\PriceProductSchedule\Communication\Console` |
|  `PriceProductScheduleCleanupConsole` | Deletes scheduled prices that have ended for the number of days provided as a parameter starting from the current date. | None |  `Spryker\Zed\PriceProductSchedule\Communication\Console` |
|  `ScheduledPriceProductConcreteFormEditTabsExpanderPlugin` | Expands product concrete *Edit Product* page with the **Scheduled Prices** tab. | None |  `Spryker\Zed\PriceProductScheduleGui\Communication\Plugin\ProductManagement` |
|  `ScheduledPriceProductAbstractFormEditTabsExpanderPlugin` | Expands product abstract *Edit Product* page with the **Scheduled Prices** tab. | None |  `Spryker\Zed\PriceProductScheduleGui\Communication\Plugin\ProductManagement` |
|  `ScheduledPriceProductAbstractEditViewExpanderPlugin` | Expands the  **Scheduled Prices** tab of the *Edit Product abstract* page with scheduled prices data. | None |  `Spryker\Zed\PriceProductScheduleGui\Communication\Plugin\ProductManagement` |
| `ScheduledPriceProductConcreteEditViewExpanderPlugin` | Expands the **Scheduled Prices** tab of the *Edit Product concrete* page with the scheduled prices data. | None | `Spryker\Zed\PriceProductScheduleGui\Communication\Plugin\ProductManagement` |

<details open>
<summary markdown='span'> src/Pyz/Zed/Console/ConsoleDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\Console;

use Spryker\Zed\Console\ConsoleDependencyProvider as SprykerConsoleDependencyProvider;
use Spryker\Zed\DataImport\Communication\Console\DataImportConsole;
use Spryker\Zed\PriceProductScheduleDataImport\PriceProductScheduleDataImportConfig;
use Spryker\Zed\PriceProductSchedule\Communication\Console\PriceProductScheduleApplyConsole;
use Spryker\Zed\PriceProductSchedule\Communication\Console\PriceProductScheduleCleanupConsole;

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
			new DataImportConsole(DataImportConsole::DEFAULT_NAME . ':' . PriceProductScheduleDataImportConfig::IMPORT_TYPE_PRODUCT_PRICE_SCHEDULE),
    		new PriceProductScheduleApplyConsole(),
            new PriceProductScheduleCleanupConsole()
		];

		return $commands;
    }
}
```
<br>
</details>

<details open>
<summary markdown='span'> src/Pyz/Zed/PriceProductScheduleDataImport/PriceProductScheduleDataImportConfig.php</summary>

```php
<?php

namespace Pyz\Zed\PriceProductScheduleDataImport;

use Spryker\Zed\PriceProductScheduleDataImport\PriceProductScheduleDataImportConfig as SprykerPriceProductScheduleDataImportConfig;

class PriceProductScheduleDataImportConfig extends SprykerPriceProductScheduleDataImportConfig
{
    /**
     * @return string
     */
    protected function getModuleRoot(): string
    {
        $moduleRoot = realpath(APPLICATION_ROOT_DIR);

        return $moduleRoot . DIRECTORY_SEPARATOR;
    }
}
```
<br>
</details>

<details open>
<summary markdown='span'> src/Pyz/Zed/ProductManagement/ProductManagementDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\ProductManagement;

use Spryker\Zed\ProductManagement\ProductManagementDependencyProvider as SprykerProductManagementDependencyProvider;
use Spryker\Zed\PriceProductScheduleGui\Communication\Plugin\ProductManagement\ScheduledPriceProductAbstractEditViewExpanderPlugin;
use Spryker\Zed\PriceProductScheduleGui\Communication\Plugin\ProductManagement\ScheduledPriceProductAbstractFormEditTabsExpanderPlugin;
use Spryker\Zed\PriceProductScheduleGui\Communication\Plugin\ProductManagement\ScheduledPriceProductConcreteEditViewExpanderPlugin;
use Spryker\Zed\PriceProductScheduleGui\Communication\Plugin\ProductManagement\ScheduledPriceProductConcreteFormEditTabsExpanderPlugin;

class ProductManagementDependencyProvider extends SprykerProductManagementDependencyProvider
{

    /**
     * @return \Spryker\Zed\ProductManagementExtension\Dependency\Plugin\ProductConcreteFormEditTabsExpanderPluginInterface[]
     */
    protected function getProductConcreteFormEditTabsExpanderPlugins(): array
    {
        return [
            new ScheduledPriceProductConcreteFormEditTabsExpanderPlugin(),
        ];
    }

    /**
     * @return \Spryker\Zed\ProductManagementExtension\Dependency\Plugin\ProductAbstractFormEditTabsExpanderPluginInterface[]
     */
    protected function getProductAbstractFormEditTabsExpanderPlugins(): array
    {
        return [
            new ScheduledPriceProductAbstractFormEditTabsExpanderPlugin(),
        ];
    }

    /**
     * @return \Spryker\Zed\ProductManagementExtension\Dependency\Plugin\ProductAbstractEditViewExpanderPluginInterface[]
     */
    protected function getProductAbstractEditViewExpanderPlugins(): array
    {
        return [
            new ScheduledPriceProductAbstractEditViewExpanderPlugin(),
        ];
    }

    /**
     * @return \Spryker\Zed\ProductManagementExtension\Dependency\Plugin\ProductConcreteEditViewExpanderPluginInterface[]
     */
    protected function getProductConcreteEditViewExpanderPlugins(): array
    {
        return [
            new ScheduledPriceProductConcreteEditViewExpanderPlugin(),
        ];
    }
}
```
<br>
</details>

Run the following console command to apply scheduled prices:

```bash
console price-product-schedule:apply
```

{% info_block warningBox "Verification" %}
Make sure that:<ul><li> Scheduled prices have been correctly applied in the **Back Office > Products > Products** section.</li><li>You can edit any abstract or concrete product.</li><li>On the Edit Product page, you can find the *Scheduled prices* tab with your scheduled prices.</li></ul>
{% endinfo_block %}

Run the following console command to clear applied scheduled prices:

```bash
console price-product-schedule:clean-up 1
```

{% info_block warningBox "Vreification" %}
Make sure that applied scheduled prices have been correctly removed from the database by checking the `spy_price_product_schedule` table.
{% endinfo_block %}

### 5) Set up Cron Job

Enable the `apply-price-product-schedule` console command in the cron-job list:

<details open>
<summary markdown='span'> config/Zed/cronjobs/jobs.php</summary>

```php
<?php

/**
 * Notes:
 *
 * - jobs[]['name'] must not contains spaces or any other characters, that have to be urlencode()'d
 * - jobs[]['role'] default value is 'admin'
 */

$stores = require(APPLICATION_ROOT_DIR . '/config/Shared/stores.php');

$allStores = array_keys($stores);

/* PriceProductSchedule */
$jobs[] = [
    'name' => 'apply-price-product-schedule',
    'command' => '$PHP_BIN vendor/bin/console price-product-schedule:apply',
    'schedule' => '0 6 * * *',
    'enable' => true,
    'run_on_non_production' => true,
    'stores' => $allStores,
];
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make sure that scheduled prices have been correctly applied in the **Back Office > Products > Products** section. 
{% endinfo_block %}
