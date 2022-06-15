---
title: Category Image feature integration
search: exclude
description: The guide walks you through the process of installing the Category Image feature in your project.
last_updated: Jan 28, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v3/docs/category-image-feature-integration
originalArticleId: 83cd5c55-1844-4d6f-b424-90c1ecbcc1e6
redirect_from:
  - /v3/docs/category-image-feature-integration
  - /v3/docs/en/category-image-feature-integration
---

## Install Feature Core
### Prerequisites
Please overview and install the necessary features before beginning the integration step.

| Name | Version |
| --- | --- |
| Category | 201907.0 |
| Spryker Core | 201907.0 |

### 1) Install the required modules using Composer
Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/category-image:"^201907.0" --update-with-dependencies
```
{% info_block warningBox "Verification" %}
Make sure that the following modules were installed:<table><thead><tr><th>Module</th><th>Expected Directory</th></tr></thead><tbody><tr><td>`CategoryImage`</td><td>`vendor/spryker/category-image`</td></tr><tr><td>`CategoryImageGui`</td><td>`vendor/spryker/category-image-gui`</td></tr><tr><td>`CategoryImageStorage`</td><td>`vendor/spryker/category-image-storage`</td></tr><tr><td>`CategoryExtension`</td><td>`vendor/spryker/category-extension`</td></tr></tbody></table>
{% endinfo_block %}


### 2) Set up Database Schema and Transfer Objects
Adjust the schema definition so entity changes will trigger events.

| Affected entity | Triggered events |
| --- | --- |
| `spy_category_image_set` | `Entity.spy_category_image_set.create`<br>`Entity.spy_category_image_set.update`<br>`Entity.spy_category_image_set.delete` |
| `spy_category_image` | `Entity.spy_category_image_set.create`<br>`Entity.spy_category_image_set.update`<br>`Entity.spy_category_image_set.delete` |
| `spy_category_image_set_to_category_image` | `Entity.spy_category_image_set_to_category_image.create`<br>`Entity.spy_category_image_set_to_category_image.update`<br>`Entity.spy_category_image_set_to_category_image.delete` |

<details open>
   <summary markdown='span'>src/Pyz/Zed/CategoryImage/Persistence/Propel/Schema/spy_category_image.schema.xml</summary>
    
```html
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
    
<br>
</details>

Set up synchronization queue pools so non-multistore entities (not store specific entities) are synchronized among stores:

<details open>
<summary markdown='span'>src/Pyz/Zed/CategoryImageStorage/Persistence/Propel/Schema/spy_category_image_storage.schema.xml</summary>
    
```html
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
    
<br>
</details>

Run the following commands to apply database changes and generate entity and transfer changes:

```bash
console transfer:generate
console propel:install
console transfer:generate
```


{% info_block warningBox "Verification" %}
Make sure that the following changes have been applied by checking your database.<table><thead><tr><th>Database Entity</th><th>Type</th><th>Event</th></tr></thead><tbody><tr><td>`spy_category_image_set`</td><td>table</td><td>created</td></tr><tr><td>`spy_category_image`</td><td>table</td><td>created</td></tr><tr><td>`spy_category_image_set_to_category_image`</td><td>table</td><td>created</td></tr><tr><td>`spy_category_image_storage`</td><td>table</td><td>created</td></tr></tbody></table>
{% endinfo_block %}

{% info_block warningBox “Verification” %}

Make sure that propel entities have been generated successfully by checking their existence. Also, change the generated entity classes to extend from Spryker core classes.<table><thead><tr><th>Class path</th><th>Extends</th></tr></thead><tbody><tr><td>`src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImage.php`</td><td>`Spryker\Zed\CategoryImage\Persistence\Propel\AbstractSpyCategoryImage`</td></tr><tr><td>`src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageQuery.php`</td><td>`Spryker\Zed\CategoryImage\Persistence\Propel\AbstractSpyCategoryImageQuery`</td></tr><tr><td>`src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageSet.php`</td><td>`Spryker\Zed\CategoryImage\Persistence\Propel\AbstractSpyCategoryImageSet`</td></tr><tr><td>`src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageSetQuery.php`</td><td>`Spryker\Zed\CategoryImage\Persistence\Propel\AbstractSpyCategoryImageSetQuery`</td></tr><tr><td>`src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageSetToCategoryImage.php`</td><td>`Spryker\Zed\CategoryImage\Persistence\Propel\AbstractSpyCategoryImageSetToCategoryImage`</td></tr><tr><td>`src/Orm/Zed/CategoryImage/Persistence/Base/SpyCategoryImageSetToCategoryImageQuery.php`</td><td>`Spryker\Zed\CategoryImage\Persistence\Propel\AbstractSpyCategoryImageSetToCategoryImageQuery`</td></tr><tr><td>`src/Orm/Zed/CategoryImageStorage/Persistence/Base/SpyCategoryImageStorage.php`</td><td>`Spryker\Zed\CategoryImageStorage\Persistence\Propel\AbstractSpyCategoryImageStorage`</td></tr><tr><td>`src/Orm/Zed/CategoryImageStorage/Persistence/Base/SpyCategoryImageStorageQuery.php`</td><td>`Spryker\Zed\CategoryImageStorage\Persistence\Propel\AbstractSpyCategoryImageStorageQuery`</td></tr></tbody></table>
{% endinfo_block %}

{% info_block warningBox "Verification" %}
Make sure that the following changes have been implemented in transfer objects:<table><thead><tr><th>Transfer</th><th>Type</th><th>Event</th><th>Path</th></tr></thead><tbody><tr><td>`CategoryImageSetTransfer`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/CategoryImageSetTransfer.php`</td></tr><tr><td>`CategoryImageTransfer`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/CategoryImageTransfer.php`</td></tr><tr><td>`CategoryTransfer`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/CategoryTransfer.php`</td></tr></tbody></table>
{% endinfo_block %}


### 3) Configure Export to Redis
#### Set up Event Listeners

{% info_block infoBox %}
In this step, you will enable publishing of table changes (create, edit, delete
{% endinfo_block %} to `spy_category_image_storage` and synchronization of data to Storage.)

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `CategoryImageStorageEventSubscriber` | Registers listeners that are responsible for publishing category image information to storage when a related entity changes. | None | `Spryker\Zed\CategoryImageStorage\Communication\Plugin\Event\Subscriber` |

<details open>
<summary markdown='span'>src/Pyz/Zed/Event/EventDependencyProvider.php</summary>
    
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
<br>
</details>

<details open>
<summary markdown='span'>src/Pyz/Zed/CategoryImageStorage/CategoryImageStorageConfig.php</summary>

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
<br>
</details>

#### Set up Data Synchronization
Add the following plugins to your project:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `CategoryImageSynchronizationDataPlugin` | Synchronizes all category image entries from the database to Redis. | None | `Spryker\Zed\CategoryImageStorage\Communication\Plugin\Synchronization` |

<details open>
<summary markdown='span'>src/Pyz/Zed/Synchronization/SynchronizationDependencyProvider.php</summary>

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
<br>
</details>

{% info_block warningBox “Verification” %}

Make sure that when a category image is created, updated or deleted, it is exported (or removed
{% endinfo_block %} to Redis accordingly.)

| Storage type | Target entity | Example expected data identifier |
| --- | --- | --- |
| Redis | Category Image | `kv:category_image:en_us:1` |

**Example expected data fragment**

```
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

### 4) Import Data

{% info_block infoBox %}
In this step, category template will be configured to be able to display category images.
{% endinfo_block %}

Prepare your data according to your requirements using our demo data:

<details open>
<summary markdown='span'>data/import/category_template.csv</summary>

```bash
template_name,template_path
"Sub Categories grid","@CatalogPage/views/sub-categories-grid/sub-categories-grid.twig"
```
<br>
</details>

| Column | Is obligatory? | Data type | Data example | Data explanation |
| --- | --- | --- | --- | --- |
| `template_name` | mandatory | string | My category template | A human readable name of the category template. |
| `template_path` | mandatory | string | `@ModuleName/path/to/category/template.twig` | Category template path that is used to display a category page. |

Run the following console command to import data:

```bash
console data:import:category-template
```

{% info_block warningBox “Verification” %}

Make sure that in the database the configured data is added to the `spy_category_template` table.
{% endinfo_block %}

### 5) Set up Behavior

Add the following plugins to your project:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `CategoryImageSetCreatorPlugin` | Persists new category image sets into the database after the category creation. | None | `\Spryker\Zed\CategoryImage\Communication\Plugin` |
| `CategoryImageSetExpanderPlugin` | Hydrates category with image data after reading them from the database. | None | `\Spryker\Zed\CategoryImage\Communication\Plugin` |
| `CategoryImageSetUpdaterPlugin` | Persists category image set changes into the database after the category update. | None | `\Spryker\Zed\CategoryImage\Communication\Plugin` |
| `RemoveCategoryImageSetRelationPlugin` | Deletes category image sets when a category is deleted. | None | `\Spryker\Zed\CategoryImage\Communication\Plugin` |
| `CategoryImageFormPlugin` | Extends create/edit category forms with category image set related fields. | None | `\Spryker\Zed\CategoryImageGui\Communication\Plugin` |
| `CategoryImageFormTabExpanderPlugin` | Extends create/edit category tabs with category image set related item. | None | `\Spryker\Zed\CategoryImageGui\Communication\Plugin` |

<details open>
<summary markdown='span'>src/Pyz/Zed/Category/CategoryDependencyProvider.php</summary>

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

<br>
</details>

{% info_block warningBox “Verification” %}

Make sure that category image handling is integrated successfully by going to Zed and creating, editing, and deleting categories with images.
{% endinfo_block %}

## Install Feature Frontend
### Prerequisites

Please overview and install the necessary features before beginning the integration step.

| Name | Version |
| --- | --- |
| Category | 201907.0 |
| Spryker Core | 201907.0 |

### 1) Install the required modules using Composer
Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/category-image:"^201907.0" --update-with-dependencies
```

{% info_block warningBox "Verification" %}
Make sure that the following modules have been installed:<table><thead><tr><th>Module</th><th>Expected Directory</th></tr></thead><tbody><tr><td>`CategoryImageStorageWidget`</td><td>`vendor/spryker-shop/category-image-storage-widget`</td></tr></tbody></table>
{% endinfo_block %}

### 2) Set up Widgets
Register the following global widgets:

| Widget | Description | Namespace |
| --- | --- | --- |
| `CategoryImageStorageWidget` | Finds the given category image set in Storage and displays its first image in a given size format. | `SprykerShop\Yves\CategoryImageStorageWidget\Widget` |

<details open>
<summary markdown='span'>src/Pyz/Yves/ShopApplication/ShopApplicationDependencyProvider.php</summary>

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
<br>
</details>


{% info_block warningBox "Verification" %}
Make sure that the following widgets have been registered:<table><thead><tr><th>Module</th><th>Test</th></tr></thead><tbody><tr><td>`CategoryImageStorageWidget`</td><td>Make sure you have category image data in your storage. Then, render the widget for all the categories that have images assigned.</td></tr></tbody></table>
{% endinfo_block %}

