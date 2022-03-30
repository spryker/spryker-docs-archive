---
title: Product Groups feature integration
description: The guide describes the process of installing the Product Group feature in your project.
last_updated: Jun 16, 2021
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/product-groups-feature-integration
originalArticleId: 98619d19-9d48-41bc-be88-64ba15de9c2e
redirect_from:
  - /2021080/docs/product-groups-feature-integration
  - /2021080/docs/en/product-groups-feature-integration
  - /docs/product-groups-feature-integration
  - /docs/en/product-groups-feature-integration
---

## Install feature core

Follow the steps below to install Product group feature core.

### Prerequisites

To start feature integration, overview and install the necessary features:

| NAME | VERSION |
| --- | --- |
| Product | {{page.version}} |
| Spryker Core | {{page.version}} |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/product-groups: "{{page.version}}" --update-with-dependencies
```

{% info_block warningBox "Verification" %}

Make sure that the following modules have been installed:

| MODULE | EXPECTED DIRECTORY |
| --- | --- |
| spryker/product-group | vendor/spryker/product-group |
| spryker/product-group-storage | vendor/spryker/product-group-storage |

{% endinfo_block %}

## 2) Set up database schema and transfer objects

1. Adjust the schema definition so entity changes will trigger events.

| AFFECTED ENTITY | TRIGGERED EVENTS |
| --- | --- |
| spy_product_abstract_group | Entity.spy_product_abstract_group.create <br> Entity.spy_product_abstract_group.update<br> Entity.spy_product_abstract_group.delete |


**src/Pyz/Zed/ProductGroup/Persistence/Propel/Schema/spy_product_group.schema.xml**

```xml
<?xml version="1.0"?>
<database xmlns="spryker:schema-01" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          name="zed"
          xsi:schemaLocation="spryker:schema-01 https://static.spryker.com/schema-01.xsd"
          namespace="Orm\Zed\ProductGroup\Persistence"
          package="src.Orm.Zed.ProductGroup.Persistence">

    <table name="spy_product_abstract_group">
        <behavior name="event">
            <parameter name="spy_product_abstract_group_all" column="*"/>
        </behavior>
    </table>

</database>
```

2. Set up synchronization queue pools so non-multistore entities (not store specific entities) will be synchronized among stores:

**src/Pyz/Zed/ProductGroupStorage/Persistence/Propel/Schema/spy_product_group_storage.schema.xml**

```xml
<?xml version="1.0"?>
<database xmlns="spryker:schema-01"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          name="zed"
          xsi:schemaLocation="spryker:schema-01 https://static.spryker.com/schema-01.xsd"
          namespace="Orm\Zed\ProductGroupStorage\Persistence"
          package="src.Orm.Zed.ProductGroupStorage.Persistence">

    <table name="spy_product_abstract_group_storage">
        <behavior name="synchronization">
            <parameter name="queue_pool" value="synchronizationPool"/>
        </behavior>
    </table>

</database>
```


3. Run the following commands to apply database changes and generate entity and transfer changes:

```bash
console transfer:generate
console propel:install
console transfer:generate
```

{% info_block warningBox "Verification" %}

Make sure that the following changes have been applied by checking your database:

| DATABASE ENTITY | TYPE | EVENT |
| --- | --- | --- |
| spy_product_group | table | created |
| spy_product_abstract_group | table | created |
| spy_product_abstract_group_storage | table | created |

{% endinfo_block %}


{% info_block warningBox "Verification" %}

Make sure that the following changes took place in transfer objects:

| TRANSFER | TYPE | EVENT | PATH |
| --- | --- | --- | --- |
| ProductGroup | class | created | src/Generated/Shared/Transfer/ProductGroupTransfer |
| ProductAbstractGroups | class | created | src/Generated/Shared/Transfer/ProductAbstractGroupsTransfer |
| ProductAbstractGroupStorage | class | created | src/Generated/Shared/Transfer/ProductAbstractGroupStorageTransfer |

{% endinfo_block %}


{% info_block warningBox "Verification" %}

Make sure that the changes have been implemented successfully. To do it, trigger the following methods and make sure that the above events have been triggered:

| PATH | METHOD NAME |
| --- | --- |
| src/Orm/Zed/ProductGroup/Persistence/Base/SpyProductAbstractGroup.php | prepareSaveEventName() <br> addSaveEventToMemory() <br> addDeleteEventToMemory() |

{% endinfo_block %}

### 3) Configure Export to Redis

This step will publish tables on change (create, edit, delete) to the `spy_product_abstract_group_storage` table and synchronize the data to Storage.

#### Set up Event Listeners

Set up the following plugin(s):


| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| ProductGroupStorageEventSubscriber | Registers listeners that are responsible to publish product abstract group storage entity changes when a related entity change event occurs. | None | Spryker\Zed\ProductGroupStorage\Communication\Plugin\Event\Subscriber |

```php
<?php

namespace Pyz\Zed\Event;

use Spryker\Zed\Event\EventDependencyProvider as SprykerEventDependencyProvider;
use Spryker\Zed\ProductGroupStorage\Communication\Plugin\Event\Subscriber\ProductGroupStorageEventSubscriber;

class EventDependencyProvider extends SprykerEventDependencyProvider
{
    public function getEventSubscriberCollection()
    {
        $eventSubscriberCollection = parent::getEventSubscriberCollection();
        $eventSubscriberCollection->add(new ProductGroupStorageEventSubscriber());

        return $eventSubscriberCollection;
    }
}
```

#### Setup re-generate and re-sync features

Set up the following plugin(s):

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE |
| --- | --- | --- | --- |
| ProductGroupSynchronizationDataPlugin | Allows synchronizing the whole storage table content into Storage. | None | Spryker\Zed\ProductGroupStorage\Communication\Plugin\Synchronization |

```php
<?php

namespace Pyz\Zed\ProductGroupStorage;

use Pyz\Zed\Synchronization\SynchronizationConfig;
use Spryker\Zed\ProductGroupStorage\ProductGroupStorageConfig as SprykerProductGroupStorageConfig;

class ProductGroupStorageConfig extends SprykerProductGroupStorageConfig
{
    /**
     * @return string|null
     */
    public function getProductGroupSynchronizationPoolName(): ?string
    {
        return SynchronizationConfig::DEFAULT_SYNCHRONIZATION_POOL_NAME;
    }
}
```

```php
<?php

namespace Pyz\Zed\Synchronization;

use Spryker\Zed\ProductGroupStorage\Communication\Plugin\Synchronization\ProductGroupSynchronizationDataPlugin;
use Spryker\Zed\Synchronization\SynchronizationDependencyProvider as SprykerSynchronizationDependencyProvider;

class SynchronizationDependencyProvider extends SprykerSynchronizationDependencyProvider
{
    /**
     * @return \Spryker\Zed\SynchronizationExtension\Dependency\Plugin\SynchronizationDataPluginInterface[]
     */
    protected function getSynchronizationDataPlugins(): array
    {
        return [
            new ProductGroupSynchronizationDataPlugin(),
        ];
    }
}
```


### 4) Import data

Follow the steps to import product group data:

{% info_block infoBox "Demo data" %}

The following imported entities will be used as a product group in Spryker OS.

{% endinfo_block %}

1. Prepare data according to your requirements using the following demo data:

**data/import/product_group.csv**

```csv
group_key,abstract_sku,position
group_key_1,001,0
group_key_1,002,1
group_key_1,003,2
group_key_2,004,0
group_key_2,005,1
```


| COLUMN | REQUIRED? | DATA TYPE | DATA EXAMPLE | DATA EXPLANATION |
| --- | --- | --- | --- | --- |
| group_key | Yes | string | group_key_1 | Unique product group identifier. |
| abstract_sku | Yes | string  | 001 | SKU of an abstract product. |
| position | Yes | integer | 0 | The position of a product in the group. |


2. Run the following console commands to import data:

```bash
console data:import:product-group
```

{% info_block warningBox "Verification" %}

Make sure that the configured data has been added to the `spy_product_group` and  `spy_product_abstract_group` tables in the database.

{% endinfo_block %}

## Install feature front end

Follow the steps below to install Product group feature front end.

### Prerequisites

Overview and install the necessary features before beginning the integration step.

| NAME | VERSION |
| --- | --- |
| Product | {{page.version}} |
| Spryker Core | {{page.version}} |


### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/product-groups: "{{page.version}}" --update-with-dependencies
```

{% info_block warningBox "Verification" %}

Make sure that the following modules have been installed:

| MODULE | EXPECTED DIRECTORY |
| --- | --- |
| spryker-shop/product-group-widget | vendor/spryker-shop/product-group-widget |

{% endinfo_block %}


### 2) Set up widgets

1. Register the following plugins to enable widgets:

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE |
| --- | --- | --- | --- |
| ProductGroupWidget | Displays product group. | None | SprykerShop\Yves\ProductGroupWidget\Widget |
| ProductGroupColorWidget | Displays product group with color selector. | None | SprykerShop\Yves\ProductGroupWidget\Widget |

```php
<?php

namespace Pyz\Yves\ShopApplication;

use SprykerShop\Yves\ProductGroupWidget\Widget\ProductGroupColorWidget;
use SprykerShop\Yves\ProductGroupWidget\Widget\ProductGroupWidget;
use SprykerShop\Yves\ShopApplication\ShopApplicationDependencyProvider as SprykerShopApplicationDependencyProvider;

class ShopApplicationDependencyProvider extends SprykerShopApplicationDependencyProvider
{
    /**
     * @return string[]
     */
    protected function getGlobalWidgets(): array
    {
        return [
            ProductGroupWidget::class,
            ProductGroupColorWidget::class,
        ];
    }
}
```


2. Run the following command to enable Javascript and CSS changes:

```bash
console frontend:yves:build
```

{% info_block warningBox "Verification" %}

Make sure that `ProductGroupWidget` has been registered:

1.     Open `http://mysprykershop.com/en/product-sets`.
2.     Pick one of the product sets with more than one abstract product in it.
3.     You can see the product card of every product in the product set.

{% endinfo_block %}

{% info_block warningBox "Verification" %}

Make sure that `ProductGroupColorWidget` has been registered:

1.     Open `http://mysprykershop.com/`.
2.     Product cards on the homepage have circles showing the available colors.
3.     Hovering over a color circle changes the abstract product image, title, rating, label, and the price.

{% endinfo_block %}


## Related features

| FEATURE | FEATURE INTEGRATION GUIDE |
| --- | --- |
| Product Group + Product Labels | [Product Group + Product Labels feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/product-group-product-labels-feature-integration.html) |
| Product Group + Product Rating & Reviews | [Product Group + Product Rating & Reviews feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/product-group-product-rating-and-reviews-feature-integration.html) |
| Product Group + Cart | [Product Group + Cart feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/product-group-cart-feature-integration.html)  |
