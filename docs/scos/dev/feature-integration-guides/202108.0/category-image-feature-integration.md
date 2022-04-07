---
title: Category image feature integration
description: The guide walks you through the process of installing the Category Image feature in your project.
last_updated: Jun 16, 2021
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/category-image-feature-integration
originalArticleId: 0f3e0644-f1b6-4407-ae2c-e42fe2ee0396
redirect_from:
  - /2021080/docs/category-image-feature-integration
  - /2021080/docs/en/category-image-feature-integration
  - /docs/category-image-feature-integration
  - /docs/en/category-image-feature-integration
related:
  - title: Product image management
    link: docs/scos/user/features/page.version/product-feature-overview/product-images-overview.html
---

## Install feature core

### Prerequisites

Please overview and install the necessary features before beginning the integration step.

| NAME | VERSION |
| --- | --- |
| Category | {{page.version}} |
| Spryker Core | {{page.version}} |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/category-image:"{{page.version}}" --update-with-dependencies
```

{% info_block warningBox "Verification" %}

Make sure that the following modules were installed:

| MODULE | EXPECTED DIRECTORY |
| --- | --- |
| CategoryImage | vendor/spryker/category-image |
| CategoryImageGui | vendor/spryker/category-image-gui |
| CategoryImageStorage | vendor/spryker/category-image-storage |
| CategoryExtension | vendor/spryker/category-extension |

{% endinfo_block %}


### 2) Set up database schema and transfer objects
Adjust the schema definition so entity changes will trigger events.

| AFFECTED ENTITY | TRIGGERED EVENTS |
| --- | --- |
| spy_category_image_set | Entity.spy_category_image_set.create<br>Entity.spy_category_image_set.update<br>Entity.spy_category_image_set.delete |
| spy_category_image | Entity.spy_category_image_set.create<br>Entity.spy_category_image_set.update<br>Entity.spy_category_image_set.delete |
| spy_category_image_set_to_category_image | Entity.spy_category_image_set_to_category_image.create<br>Entity.spy_category_image_set_to_category_image.update<br>Entity.spy_category_image_set_to_category_image.delete |

**src/Pyz/Zed/CategoryImage/Persistence/Propel/Schema/spy_category_image.schema.xml**
    
```xml
<?xml version="1.0"?>
<database xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="zed" xsi:noNamespaceSchemaLocation="http://static.spryker.com/schema-01.xsd" namespace="Orm\Zed\CategoryImage\Persistence" package="src.Orm.Zed.CategoryImage.Persistence">
 
	<table name="spy_category_image_set">
		<behavior name="event">
			<parameter name="spy_category_image_set_all" column="*"/>
        </behavior>
    </table>
 
	<table name="spy_category_image">
		<behavior name="event">
			<parameter name="spy_category_image_all" column="*"/>
        </behavior>
    </table>
 
	<table name="spy_category_image_set_to_category_image">
		<behavior name="event">
			<parameter name="spy_category_image_set_to_category_image_all" column="*"/>
        </behavior>
    </table>
    </database>
```

Set up synchronization queue pools so that non-multistore entities (not store specific entities) are synchronized among stores:

**src/Pyz/Zed/CategoryImageStorage/Persistence/Propel/Schema/spy_category_image_storage.schema.xml**
    
```xml
<?xml version="1.0"?>
<database xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	name="zed"
	xsi:noNamespaceSchemaLocation="http://static.spryker.com/schema-01.xsd"
	namespace="Orm\Zed\CategoryImageStorage\Persistence"
	package="src.Orm.Zed.CategoryImageStorage.Persistence">
 
	<table name="spy_category_image_storage">
		<behavior name="synchronization">
			<parameter name="queue_pool" value="synchronizationPool" />
        </behavior>
	</table>
    </database>
```

Run the following commands to apply database changes and generate entity and transfer changes:

```bash
console transfer:generate
console propel:install
console transfer:generate
```

{% info_block warningBox "Verification" %}

Make sure that the following changes have been applied by checking your database.

| DATABASE ENTITY | TYPE | EVENT |
| --- | --- | --- |
| spy_category_image_set | table | created |
| spy_category_image | table | created |
| spy_category_image_set_to_category_image | table | created |
| spy_category_image_storage | table | created |

{% endinfo_block %}

{% info_block warningBox “Verification” %}


Make sure that propel entities have been generated successfully by checking their existence. Also, change the generated entity classes to extend from Spryker core classes.

| CLASS PATH | EXTENDS |
| --- | --- |
| src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImage.php | Spryker\\Zed\\CategoryImage\\Persistence\\Propel\\AbstractSpyCategoryImage |
| src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageQuery.php | Spryker\\Zed\\CategoryImage\\Persistence\\Propel\\AbstractSpyCategoryImageQuery |
| src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageSet.php | Spryker\\Zed\\CategoryImage\\Persistence\\Propel\\AbstractSpyCategoryImageSet |
| src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageSetQuery.php | Spryker\\Zed\\CategoryImage\\Persistence\\Propel\\AbstractSpyCategoryImageSetQuery |
| src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageSetToCategoryImage.php | Spryker\\Zed\\CategoryImage\\Persistence\\Propel\\AbstractSpyCategoryImageSetToCategoryImage |
| src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageSetToCategoryImageQuery.php | Spryker\\Zed\\CategoryImage\\Persistence\\Propel\\AbstractSpyCategoryImageSetToCategoryImageQuery |
| src/Orm/Zed/CategoryImageStorage/Persistence/Base/SpyCategoryImageStorage.php | Spryker\\Zed\\CategoryImageStorage\\Persistence\\Propel\\AbstractSpyCategoryImageStorage |
| src/Orm/Zed/CategoryImageStorage/Persistence/Base/SpyCategoryImageStorageQuery.php | Spryker\\Zed\\CategoryImageStorage\\Persistence\\Propel\\AbstractSpyCategoryImageStorageQuery |

{% endinfo_block %}

{% info_block warningBox "Verification" %}

Make sure that the following changes have been implemented in transfer objects:

| TRANSFER | TYPE | EVENT | PATH |
| --- | --- | --- | --- |
| CategoryImageSetTransfer | class | created | src/Generated/Shared/Transfer/CategoryImageSetTransfer.php |
| CategoryImageTransfer | class | created | src/Generated/Shared/Transfer/CategoryImageTransfer.php |
| CategoryTransfer | class | created | src/Generated/Shared/Transfer/CategoryTransfer.php |

{% endinfo_block %}


### 3) Configure export to Redis

#### Set up event listeners

{% info_block infoBox %}

In this step, you will enable publishing of table changes (create, edit, delete to `spy_category_image_storage` and synchronization of data to Storage.)

{% endinfo_block %}

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE |
| --- | --- | --- | --- |
| CategoryImageStorageEventSubscriber | Registers listeners that are responsible for publishing category image information to storage when a related entity changes. | None | Spryker\Zed\CategoryImageStorage\Communication\Plugin\Event\Subscriber |

**src/Pyz/Zed/Event/EventDependencyProvider.php**
    
```php
<?php
 
namespace Pyz\Zed\Event;
 
use Spryker\Zed\CategoryImageStorage\Communication\Plugin\Event\Subscriber\CategoryImageStorageEventSubscriber;
use Spryker\Zed\Event\EventDependencyProvider as SprykerEventDependencyProvider;
 
class EventDependencyProvider extends SprykerEventDependencyProvider
{
	public function getEventSubscriberCollection()
	{
		$eventSubscriberCollection = parent::getEventSubscriberCollection();
		$eventSubscriberCollection->add(new CategoryImageStorageEventSubscriber());
 
		return $eventSubscriberCollection;
	}
}
```

**src/Pyz/Zed/CategoryImageStorage/CategoryImageStorageConfig.php**

```php
<?php
  
namespace Pyz\Zed\CategoryImageStorage;
  
use Pyz\Zed\Synchronization\SynchronizationConfig;
use Spryker\Zed\CategoryImageStorage\CategoryImageStorageConfig as SprykerCategoryImageSTorageConfig;
  
class CategoryImageStorageConfig extends SprykerCategoryImageSTorageConfig
{
	/**
	* @return string|null
	*/
	public function getCategoryImageSynchronizationPoolName(): ?string
	{
		return SynchronizationConfig::DEFAULT_SYNCHRONIZATION_POOL_NAME;
	}
}
```

#### Set up data synchronization

Add the following plugins to your project:

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE |
| --- | --- | --- | --- |
| CategoryImageSynchronizationDataPlugin | Synchronizes all category image entries from the database to Redis. | None | Spryker\Zed\CategoryImageStorage\Communication\Plugin\Synchronization |

**src/Pyz/Zed/Synchronization/SynchronizationDependencyProvider.php**

```php
<?php
 
namespace Pyz\Zed\Synchronization;
 
use Spryker\Zed\CategoryImageStorage\Communication\Plugin\Synchronization\CategoryImageSynchronizationDataPlugin;
use Spryker\Zed\Synchronization\SynchronizationDependencyProvider as SprykerSynchronizationDependencyProvider;
 
class SynchronizationDependencyProvider extends SprykerSynchronizationDependencyProvider
{
	/**
	* @return \Spryker\Zed\SynchronizationExtension\Dependency\Plugin\SynchronizationDataPluginInterface[]
	*/
	protected function getSynchronizationDataPlugins(): array
	{
		return [
			new CategoryImageSynchronizationDataPlugin(),
		];
	}
}
```

{% info_block warningBox “Verification” %}

Make sure that when a category image is created, updated or deleted, it is exported or removed from Redis accordingly.

{% endinfo_block %}

| STORAGE TYPE | TARGET ENTITY | EXAMPLE EXPECTED DATA IDENTIFIER |
| --- | --- | --- |
| Redis | Category Image | `kv:category_image:en_us:1` |

**Example expected data fragment**

```json
{
  "id_category":1,
"image_sets": [
{
"name":"default",
"images": [
{
"id_category_image":1,
"external_url_large":"http://mysprykershop.com/image/url.jpg",
"external_url_small":"http://mysprykershop.com/image/url.jpg"
}
]
}
]
}
```

### 4) Import data

{% info_block infoBox %}

In this step, category template will be configured to be able to display category images.

{% endinfo_block %}

Prepare your data according to your requirements using our demo data:

**data/import/category_template.csv**

```csv
template_name,template_path
"Sub Categories grid","@CatalogPage/views/sub-categories-grid/sub-categories-grid.twig"
```

| COLUMN | IS REQUIRED | DATA TYPE | DATA EXAMPLE | DATA EXPLANATION |
| --- | --- | --- | --- | --- |
| template_name | mandatory | string | My category template | A human readable name of the category template. |
| template_path | mandatory | string | @ModuleName/path/to/category/template.twig | Category template path that is used to display a category page. |

Run the following console command to import data:

```bash
console data:import:category-template
```

{% info_block warningBox “Verification” %}

Make sure that in the database the configured data is added to the `spy_category_template` table.
{% endinfo_block %}

### 5) Set up behavior

Add the following plugins to your project:

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE |
| --- | --- | --- | --- |
| CategoryImageSetCreatorPlugin | Persists new category image sets into the database after the category creation. | None | \Spryker\Zed\CategoryImage\Communication\Plugin |
| CategoryImageSetExpanderPlugin | Hydrates category with image data after reading them from the database. | None | \Spryker\Zed\CategoryImage\Communication\Plugin |
| CategoryImageSetUpdaterPlugin | Persists category image set changes into the database after the category update. | None | \Spryker\Zed\CategoryImage\Communication\Plugin |
| RemoveCategoryImageSetRelationPlugin | Deletes category image sets when a category is deleted. | None | \Spryker\Zed\CategoryImage\Communication\Plugin |
| CategoryImageFormPlugin | Extends create/edit category forms with category image set related fields. | None | \Spryker\Zed\CategoryImageGui\Communication\Plugin |
| CategoryImageFormTabExpanderPlugin | Extends create/edit category tabs with category image set related item. | None | \Spryker\Zed\CategoryImageGui\Communication\Plugin |

**src/Pyz/Zed/Category/CategoryDependencyProvider.php**

```php
<?php
   
namespace Pyz\Zed\Category;
   
use Spryker\Zed\Category\CategoryDependencyProvider as SprykerDependencyProvider;
use Spryker\Zed\CategoryImage\Communication\Plugin\CategoryImageSetCreatorPlugin;
use Spryker\Zed\CategoryImage\Communication\Plugin\CategoryImageSetExpanderPlugin;
use Spryker\Zed\CategoryImage\Communication\Plugin\CategoryImageSetUpdaterPlugin;
use Spryker\Zed\CategoryImage\Communication\Plugin\RemoveCategoryImageSetRelationPlugin;
use Spryker\Zed\CategoryImageGui\Communication\Plugin\CategoryImageFormPlugin;
use Spryker\Zed\CategoryImageGui\Communication\Plugin\CategoryImageFormTabExpanderPlugin;
   
class CategoryDependencyProvider extends SprykerDependencyProvider
{
    /**
     * @return \Spryker\Zed\Category\Dependency\Plugin\CategoryRelationDeletePluginInterface[]
     */
    protected function getRelationDeletePluginStack()
    {
        $deletePlugins = array_merge(
            [
                new RemoveCategoryImageSetRelationPlugin(),
            ],
            parent::getRelationDeletePluginStack()
        );
   
        return $deletePlugins;
    }
   
    /**
     * @return \Spryker\Zed\CategoryExtension\Dependency\Plugin\CategoryTransferExpanderPluginInterface[]
     */
    protected function getCategoryPostReadPlugins(): array
    {
        return [
            new CategoryImageSetExpanderPlugin(),
        ];
    }
   
    /**
     * @return array
     */
    protected function getCategoryFormPlugins()
    {
        return array_merge(parent::getCategoryFormPlugins(), [
            new CategoryImageFormPlugin(),
        ]);
    }
   
    /**
     * @return \Spryker\Zed\CategoryExtension\Dependency\Plugin\CategoryUpdateAfterPluginInterface[]
     */
    protected function getCategoryPostUpdatePlugins(): array
    {
        return [
            new CategoryImageSetUpdaterPlugin(),
        ];
    }
   
    /**
     * @return \Spryker\Zed\CategoryExtension\Dependency\Plugin\CategoryCreateAfterPluginInterface[]
     */
    protected function getCategoryPostCreatePlugins(): array
    {
        return [
            new CategoryImageSetCreatorPlugin(),
        ];
    }
   
    /**
     * @return \Spryker\Zed\CategoryExtension\Dependency\Plugin\CategoryFormTabExpanderPluginInterface[]
     */
    protected function getCategoryFormTabExpanderPlugins(): array
    {
        return [
            new CategoryImageFormTabExpanderPlugin(),
        ];
    }
}
```

{% info_block warningBox “Verification” %}

Make sure that category image handling is integrated successfully by going to Zed and creating, editing, and deleting categories with images.

{% endinfo_block %}

## Install feature frontend

### Prerequisites

Please overview and install the necessary features before beginning the integration step.

| NAME | VERSION |
| --- | --- |
| Category | {{page.version}} |
| Spryker Core | {{page.version}} |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/category-image:"{{page.version}}" --update-with-dependencies
```

{% info_block warningBox "Verification" %}

Make sure that the following modules have been installed:

| MODULE | EXPECTED DIRECTORY |
| --- | --- |
| CategoryImageStorageWidget | vendor/spryker-shop/category-image-storage-widget |

{% endinfo_block %}

### 2) Set up widgets
Register the following global widgets:

| WIDGET | DESCRIPTION | NAMESPACE |
| --- | --- | --- |
| CategoryImageStorageWidget | Finds the given category image set in Storage and displays its first image in a given size format. | SprykerShop\Yves\CategoryImageStorageWidget\Widget |

**src/Pyz/Yves/ShopApplication/ShopApplicationDependencyProvider.php**

```php
<?php  
 
namespace Pyz\Yves\ShopApplication;  
 
use SprykerShop\Yves\ShopApplication\ShopApplicationDependencyProvider as SprykerShopApplicationDependencyProvider;
use SprykerShop\Yves\CategoryImageStorageWidget\Widget\CategoryImageStorageWidget;  
 
class ShopApplicationDependencyProvider extends SprykerShopApplicationDependencyProvider
{    
    /**     
    * @return string[]     
    */    
    protected function getGlobalWidgets(): array    
    {        
        return [            
            CategoryImageStorageWidget::class,        
        ];    
    }
}
```

{% info_block warningBox "Verification" %}

Make sure that the following widgets have been registered:

| MODULE | TEST |
| --- | --- |
| CategoryImageStorageWidget | Make sure you have category image data in your storage. Then, render the widget for all the categories that have images assigned. |

{% endinfo_block %}
