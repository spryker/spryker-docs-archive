---
title: Sales Data Export feature integration
search: exclude
description: Integrate the Sales Data Export feature into your project.
last_updated: Jul 24, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v5/docs/sales-data-export-feature-integration
originalArticleId: 2a966512-34e2-4668-bb9d-ecc62989354d
redirect_from:
  - /v5/docs/sales-data-export-feature-integration
  - /v5/docs/en/sales-data-export-feature-integration
---

## Install Feature Core
Follow the steps below to install feature core.

### 1) Install Required Modules Using Composer
Run the following command to install the required modules:
```bash
composer require spryker/data-export:"^0.1.0" spryker/data-export-extension:"^0.1.0" spryker/sales-data-export:"^0.1.0" --update-with-dependencies
```

{% info_block warningBox "Verification" %}

Make sure that the following modules have been installed:

| Module | Expected directory |
| --- | --- |
| DataExport | vendor/spryker/data-export |
| DataExportExtension | vendor/spryker/data-export-extension |
| SalesDataExport | vendor/spryker/sales-data-export |

{% endinfo_block %}

### 2) Set up Transfer Objects

1. Run the following command to generate transfer changes:

```bash
vendor/bin/console transfer:generate
```

{% info_block warningBox "Verification" %}

Make sure that the following changes are present in transfer objects::


| Transfer | Type | Event | Path |
| --- | --- | --- | --- |
| DataExportBatch | class | created | src/Generated/Shared/Transfer/DataExportBatchTransfer.php |
| DataExportConfiguration | class | created |src/Generated/Shared/Transfer/DataExportConfigurationTransfer.php |
| DataExportConfigurations | class | created | src/Generated/Shared/Transfer/DataExportConfigurationsTransfer.php |
| DataExportConnectionConfiguration | class | created | src/Generated/Shared/Transfer/DataExportConnectionConfigurationTransfer.php |
| DataExportFormatConfiguration | class | created | src/Generated/Shared/Transfer/DataExportFormatConfigurationTransfer.php |
| DataExportFormatResponse | class | created | src/Generated/Shared/Transfer/DataExportFormatResponseTransfer.php |
| DataExportReport | class | created | src/Generated/Shared/Transfer/DataExportReportTransfer.php |
| DataExportResult | class | created | src/Generated/Shared/Transfer/DataExportResultTransfer.php |
| DataExportWriteResponse | class | created | src/Generated/Shared/Transfer/DataExportWriteResponseTransfer.php |

{% endinfo_block %}

### 3) Set up Behavior
1. Register the console command in `ConsoleDependencyProvider`

| Command | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| DataExportConsole | Runs data export. | None | Spryker\Zed\DataExport\Communication\Console |

**src/Pyz/Zed/Console/ConsoleDependencyProvider.php**
```php
<?php

namespace Pyz\Zed\Console;

use Spryker\Zed\Console\ConsoleDependencyProvider as SprykerConsoleDependencyProvider;
use Spryker\Zed\DataExport\Communication\Console\DataExportConsole;
use Spryker\Zed\Kernel\Container;

class ConsoleDependencyProvider extends SprykerConsoleDependencyProvider
{
    /**
     * @param \Spryker\Zed\Kernel\Container $container
     *
     * @return \Symfony\Component\Console\Command\Command[]
     */
    protected function getConsoleCommands(Container $container): array
    {
        $commands = [
            new DataExportConsole(),
        ];

        return $commands;
    }
}
```

{% info_block warningBox "Verification" %}

Run `vendor/bin/console list` and make sure that data:export command is on the list of the available commands.

{% endinfo_block %}
2. Add the data export configuration .yml file to the `data/export/config` folder:
```yml
version: 1

defaults:
    filter_criteria: &default_filter_criteria
        order_created_at:
            type: between
            from: '2020-05-01 00:00:00'
            to: '2020-12-31 23:59:59'

actions:
    - data_entity: order-expense
      destination: '{data_entity}s_DE_{timestamp}.{extension}'
      filter_criteria:
          <<: *default_filter_criteria
          store_name: [DE]
    - data_entity: order-expense
      destination: '{data_entity}s_AT_{timestamp}.{extension}'
      filter_criteria:
          <<: *default_filter_criteria
          store_name: [AT]

    - data_entity: order-item
      destination: '{data_entity}s_DE_{timestamp}.{extension}'
      filter_criteria:
          <<: *default_filter_criteria
          store_name: [DE]
    - data_entity: order-item
      destination: '{data_entity}s_AT_{timestamp}.{extension}'
      filter_criteria:
          <<: *default_filter_criteria
          store_name: [AT]

    - data_entity: order
      destination: '{data_entity}s_DE_{timestamp}.{extension}'
      filter_criteria:
          <<: *default_filter_criteria
          store_name: [DE]
    - data_entity: order
      destination: '{data_entity}s_AT_{timestamp}.{extension}'
      filter_criteria:
          <<: *default_filter_criteria
          store_name: [AT]
 ```
 3. Activate the following plugins:
 
| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| OrderDataEntityExporterPlugin | Adds the `order` data exporter. | None | Spryker\Zed\SalesDataExport\Communication\Plugin\DataExport |
| OrderExpenseDataEntityExporterPlugin | Adds the `order-expense` data exporter. | None | Spryker\Zed\SalesDataExport\Communication\Plugin\DataExport |
| OrderItemDataEntityExporterPlugin | Adds the `order-item` data exporter. | None | Spryker\Zed\SalesDataExport\Communication\Plugin\DataExport |

**src/Pyz/Zed/DataExport/DataExportDependencyProvider.php**
```php
<?php

namespace Pyz\Zed\DataExport;

use Spryker\Zed\DataExport\DataExportDependencyProvider as SprykerDataExportDependencyProvider;
use Spryker\Zed\SalesDataExport\Communication\Plugin\DataExport\OrderDataEntityExporterPlugin;
use Spryker\Zed\SalesDataExport\Communication\Plugin\DataExport\OrderExpenseDataEntityExporterPlugin;
use Spryker\Zed\SalesDataExport\Communication\Plugin\DataExport\OrderItemDataEntityExporterPlugin;

class DataExportDependencyProvider extends SprykerDataExportDependencyProvider
{
    /**
     * @return \Spryker\Zed\DataExportExtension\Dependency\Plugin\DataEntityExporterPluginInterface[]
     */
    protected function getDataEntityExporterPlugins(): array
    {
        return [
            new OrderDataEntityExporterPlugin(),
            new OrderItemDataEntityExporterPlugin(),
            new OrderExpenseDataEntityExporterPlugin(),
        ];
    }
}
```
{% info_block warningBox "Verification" %}

To verify that plugins are activated, run console command `vendor/bin/console data:export -c order_export_config.yml` and check that files with the exported data were created in the `data/export` folder.

{% endinfo_block %}
