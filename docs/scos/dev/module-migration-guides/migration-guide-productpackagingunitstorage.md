---
title: Migration guide - ProductPackagingUnitStorage
description: Use the guide to migrate to a newer version of the ProductPackagingUnitStorage module.
last_updated: Jun 16, 2021
template: module-migration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/mg-product-packaging-unit-storage
originalArticleId: 1c3ca2bd-bec2-4090-bf25-13da1bb9eb06
redirect_from:
  - /2021080/docs/mg-product-packaging-unit-storage
  - /2021080/docs/en/mg-product-packaging-unit-storage
  - /docs/mg-product-packaging-unit-storage
  - /docs/en/mg-product-packaging-unit-storage
  - /v2/docs/mg-product-packaging-unit-storage
  - /v2/docs/en/mg-product-packaging-unit-storage
  - /v3/docs/mg-product-packaging-unit-storage
  - /v3/docs/en/mg-product-packaging-unit-storage
  - /v4/docs/mg-product-packaging-unit-storage
  - /v4/docs/en/mg-product-packaging-unit-storage
  - /v5/docs/mg-product-packaging-unit-storage
  - /v5/docs/en/mg-product-packaging-unit-storage
  - /v6/docs/mg-product-packaging-unit-storage
  - /v6/docs/en/mg-product-packaging-unit-storage
  - /docs/scos/dev/module-migration-guides/201903.0/migration-guide-productpackagingunitstorage.html
  - /docs/scos/dev/module-migration-guides/201907.0/migration-guide-productpackagingunitstorage.html
  - /docs/scos/dev/module-migration-guides/202001.0/migration-guide-productpackagingunitstorage.html
  - /docs/scos/dev/module-migration-guides/202005.0/migration-guide-productpackagingunitstorage.html
  - /docs/scos/dev/module-migration-guides/202009.0/migration-guide-productpackagingunitstorage.html
  - /docs/scos/dev/module-migration-guides/202108.0/migration-guide-productpackagingunitstorage.html
---

## Upgrading from Version 4.* to Version 5.0.0

In this new version of the **ProductPackagingUnitStorage** module, we have added support of decimal stock. You can find more details about the changes on the [ProductPackagingUnitStorage module](https://github.com/spryker/product-packaging-unit-storage/releases) release page.

{% info_block errorBox %}

This release is a part of the **Decimal Stock** concept migration. When you upgrade this module version, you should also update all other installed modules in your project to use the same concept as well as to avoid inconsistent behavior. For more information, see [Decimal Stock Migration Concept](/docs/scos/dev/migration-concepts/decimal-stock-migration-concept.html).

{% endinfo_block %}

**To upgrade to the new version of the module, do the following:**

1. Upgrade the **ProductPackagingUnitStorage** module to the new version:

```bash
composer require spryker/product-packaging-unit-storage: "^5.0.0" --update-with-dependencies
```
2. Rename the `spy_product_abstract_packaging_storage.schema.xml` to `spy_product_packaging_unit_storage.schema.xml` and do the following changes:

**src/Pyz/Zed/ProductPackagingUnitStorage/Persistence/Propel/Schema/spy_product_packaging_unit_storage.schema.xml**

```xml
<?xml version="1.0"?>
<database xmlns="spryker:schema-01"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          name="zed"
          xsi:schemaLocation="spryker:schema-01 https://static.spryker.com/schema-01.xsd"
          namespace="Orm\Zed\ProductPackagingUnitStorage\Persistence"
          package="src.Orm.Zed.ProductPackagingUnitStorage.Persistence">

    <table name="spy_product_packaging_unit_storage">
        <behavior name="synchronization">
            <parameter name="queue_pool" value="synchronizationPool"/>
        </behavior>
    </table>

</database>
```

3. Update the database entity schema for **each store** in the system:

```bash
APPLICATION_STORE=DE console propel:schema:copy
APPLICATION_STORE=US console propel:schema:copy
...
```

4. Run the database migration:

```bash
console propel:install
console transfer:generate
```

5. Run the following command to republish all the packaging units to storage:

```bash
console event:trigger -r product_packaging_unit
```

6. Run the following - or create a bash file for it - to clean up the Redis storage from the entries with the old data:

```bash
for k in $(redis-cli -p 10009 --scan --pattern "*:product_abstract_packaging:*"); do
  echo "deleting key '$k'";
  redis-cli -p 10009 DEL $k;
done
```

7. Add the following plugin to the project dependency provider, if applicable, and remove the old `ProductAbstractPackagingEventResourceRepositoryPlugin` plugin.

**src/Pyz/Zed/EventBehavior/EventBehaviorDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\EventBehavior;

use Spryker\Zed\EventBehavior\EventBehaviorDependencyProvider as SprykerEventBehaviorDependencyProvider;
use Spryker\Zed\ProductPackagingUnitStorage\Communication\Plugin\Event\ProductPackagingUnitEventResourceBulkRepositoryPlugin;

class EventBehaviorDependencyProvider extends SprykerEventBehaviorDependencyProvider
{
    /**
     * @return \Spryker\Zed\EventBehavior\Dependency\Plugin\EventResourcePluginInterface[]
     */
    protected function getEventTriggerResourcePlugins()
    {
        return [
            new ProductPackagingUnitEventResourceBulkRepositoryPlugin(),
        ];
    }
}
```

*Estimated migration time: 15 min*


## Upgrading from Version 2.* to Version 4.0.0

{% info_block infoBox %}

In order to dismantle the Horizontal Barrier and enable partial module updates on projects, Technical Release took place. Public API of source and target major versions are equal. No migration efforts are required. Please contact us if you have any questions.

{% endinfo_block %}

## Upgrading from Version 1.* to Version  2.*

The only one major change of **ProductPackagingUnitStorage 2.x.x** is adding dependency to `spryker/product-measurement-unit-storage:^1.0.0` which requires DB changes.

To perform the migration, follow the steps:

1. Install `spryker/product-measurement-unit-storage:^1.0.0`
2. Run database migration:

```bash
vendor/bin/console propel:install
```
3. Generate transfers:

```bash
vendor/bin/console transfer:generate
```

*Estimated migration time: ~1h.*
