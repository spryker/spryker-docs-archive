---
title: Migration guide - ProductConfigurationsPriceProductVolumesRestApi
description: Learn how to upgrade the ProductConfigurationsPriceProductVolumesRestApi module to a newer version.
template: module-migration-guide-template
redirect_from:
  - /docs/scos/dev/module-migration-guides/202200.0/migration-guide-productconfigurationspriceproductvolumesrestapi.html
---

## Upgrading from version 0.1.* to version 0.2.*

*Estimated migration time: 10 minutes*

To upgrade the `ProductConfigurationsPriceProductVolumesRestApi` module from version 0.1.* to version 0.2.*, do the following:

1. Update the `ProductConfigurationsPriceProductVolumesRestApi` module to version 0.2.0:

```bash
composer require spryker/product-configurations-price-product-volumes-rest-api:"^0.2.0" --update-with-dependencies
```

2. From `\Pyz\Glue\ProductConfigurationsRestApi\ProductConfigurationsRestApiDependencyProvider`, remove the plugins:

    - `ProductConfigurationVolumePriceRestCartItemProductConfigurationMapperPlugin`
    - `ProductConfigurationVolumePriceCartItemProductConfigurationMapperPlugin`

3. In `\Pyz\Glue\ProductConfigurationsRestApi\ProductConfigurationsRestApiDependencyProvider`, on the project level, register the mapping plugins:

```php
<?php

namespace Pyz\Glue\ProductConfigurationsRestApi;

use Spryker\Glue\ProductConfigurationsPriceProductVolumesRestApi\Plugin\ProductConfigurationsRestApi\ProductConfigurationVolumePriceProductConfigurationPriceMapperPlugin;
use Spryker\Glue\ProductConfigurationsPriceProductVolumesRestApi\Plugin\ProductConfigurationsRestApi\ProductConfigurationVolumePriceRestProductConfigurationPriceMapperPlugin;
use Spryker\Glue\ProductConfigurationsRestApi\ProductConfigurationsRestApiDependencyProvider as SprykerProductConfigurationsRestApiDependencyProvider;

class ProductConfigurationsRestApiDependencyProvider extends SprykerProductConfigurationsRestApiDependencyProvider
{
    /**
     * @return \Spryker\Glue\ProductConfigurationsRestApiExtension\Dependency\Plugin\ProductConfigurationPriceMapperPluginInterface[]
     */
    protected function getProductConfigurationPriceMapperPlugins(): array
    {
        return [
            new ProductConfigurationVolumePriceProductConfigurationPriceMapperPlugin(),
        ];
    }

    /**
     * @return \Spryker\Glue\ProductConfigurationsRestApiExtension\Dependency\Plugin\RestProductConfigurationPriceMapperPluginInterface[]
     */
    protected function getRestProductConfigurationPriceMapperPlugins(): array
    {
        return [
            new ProductConfigurationVolumePriceRestProductConfigurationPriceMapperPlugin(),
        ];
    }
}
```
