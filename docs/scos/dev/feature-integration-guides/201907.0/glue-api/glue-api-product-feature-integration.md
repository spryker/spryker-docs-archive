---
title: Glue API - Product feature integration
description: This guide will navigate you through the process of installing and configuring the Product API feature in Spryker OS.
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v3/docs/products-feature-integration
originalArticleId: 1384ece4-b7f7-4dbb-bd19-de42b38cc8ae
redirect_from:
  - /v3/docs/products-feature-integration
  - /v3/docs/en/products-feature-integration
  - /docs/scos/dev/feature-integration-guides/201907.0/glue-api/products-feature-integration.html
  - /docs/scos/dev/feature-integration-guides/201907.0/glue-api/product-api-feature-integration.html
---

## Install Feature API
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version | Integration guide |
| --- | --- | --- |
| Spryker Core | 201907.0 | Feature API |
| Product | 201907.0 |  |
| Price | 201907.0 |  |

### 1) Install the required modules using Composer
Run the following command(s) to install the required modules:

```bash
composer require spryker/products-rest-api:"^2.4.1" spryker/product-image-sets-rest-api:"^1.0.3" spryker/product-prices-rest-api:"^1.1.0" spryker/products-categories-resource-relationship:"^1.0.0" --update-with-dependencies
```

{% info_block warningBox “Verification” %}

Make sure that the following modules were installed:
{% endinfo_block %}

| Module | Expected Directory |
| --- | --- |
| `ProductsRestApi` | `vendor/spryker/products-rest-api` |
| `ProductsRestApiExtension` | `vendor/spryker/products-rest-api-extension` |
| `ProductImageSetsRestApi` | `vendor/spryker/product-image-sets-rest-api` |
| `ProductPricesRestApi` | `vendor/spryker/product-prices-rest-api` |
| `ProductsCategoriesResourceRelationship` | `vendor/spryker/products-categories-resource-relationship` |

### 2) Set up Database Schema and Transfer Objects
Run the following commands to apply database changes and generate entity and transfer changes:

```bash
console transfer:generate
console propel:install
console transfer:generate
```

{% info_block warningBox “Verification” %}

Make sure that the following changes have been applied in transfer objects:
{% endinfo_block %}


| Transfer | Type | Event | Path |
| --- | --- | --- | --- |
| `AbstractProductsRestAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/AbstractProductsRestAttributesTransfer` |
| `ConcreteProductsRestAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/ConcreteProductsRestAttributesTransfer` |
| `RestProductImageSetsAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestProductImageSetsAttributesTransfer` |
| `RestProductImageSetTransfer` | class | created | `src/Generated/Shared/Transfer/RestProductImageSetTransfer` |
| `RestImagesAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestImagesAttributesTransfer` |
| `RestProductPriceAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestProductPriceAttributesTransfer` |
| `RestProductPricesAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestProductPricesAttributesTransfer` |
| `RestCurrencyTransfer` | class | created | `src/Generated/Shared/Transfer/RestCurrencyTransfer` |

{% info_block warningBox “Verification” %}

Make sure that `SpyProductAbstractStorage` and `SpyProductConcreteStorage` are extended by synchronization behavior with these methods:
{% endinfo_block %}

| Entity | Type | Event | Path | Methods |
| --- | --- | --- | --- | --- |
| `SpyProductAbstractStorage` | class | extended | `src/Orm/Zed/ProductStorage/Persistence/Base/SpyProductAbstractStorage` | `syncPublishedMessageForMappings()`,<br>`syncUnpublishedMessageForMappings()` |
| `SpyProductConcreteStorage` | class | extended | `src/Orm/Zed/ProductStorage/Persistence/Base/SpyProductConcreteStorage` | `syncPublishedMessageForMappings()`,<br>`syncUnpublishedMessageForMappings()` |

### 3) Set up Behavior
#### Reload Data to Storage
Run the following commands to reload abstract and product data to storage.

```bash
console event:trigger -r product_abstract
console event:trigger -r product_concrete
```

{% info_block warningBox “Verification” %}

Make sure that there is data in Redis with keys:<br>`kv:product_abstract:{% raw %}{{{% endraw %}store_name{% raw %}}}{% endraw %}:{% raw %}{{{% endraw %}locale_name{% raw %}}}{% endraw %}:sku:{% raw %}{{{% endraw %}sku_product_abstract{% raw %}}}{% endraw %}`<br>`kv:product_concrete:{% raw %}{{{% endraw %}locale_name{% raw %}}}{% endraw %}:sku:{% raw %}{{{% endraw %}sku_product_concrete{% raw %}}}{% endraw %}`
{% endinfo_block %}

#### Enable resources
Activate the following plugins:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `AbstractProductsResourceRoutePlugin` | Registers the abstract product resource. | None | `Spryker\Glue\ProductsRestApi\Plugin` |
| `ConcreteProductsResourceRoutePlugin` | Registers the concrete product resource. | None | `Spryker\Glue\ProductsRestApi\Plugin` |

<details open>
<summary markdown='span'>src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\ProductsRestApi\Plugin\AbstractProductsResourceRoutePlugin;
use Spryker\Glue\ProductsRestApi\Plugin\ConcreteProductsResourceRoutePlugin;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
	/**
	* @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
	*/
	protected function getResourceRoutePlugins(): array
	{
		return [
			new AbstractProductsResourceRoutePlugin(),
			new ConcreteProductsResourceRoutePlugin(),
		];
	}
}
```

<br>
</details>

{% info_block warningBox “Verification” %}

Make sure that the following endpoints are available:<ul><li>https://glue.mysprykershop.com/abstract-products/{% raw %}{{{% endraw %}abstract_sku{% raw %}}}{% endraw %} </li><li>https://glue.mysprykershop.com/concrete-products/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %}</li></ul>
{% endinfo_block %}

#### Enable resources and relationships
Activate the following plugin:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `AbstractProductImageSetsRoutePlugin` | Registers the abstract product image sets resource. | None | `Spryker\Glue\ProductImageSetsRestApi\Plugin` |
| `ConcreteProductImageSetsRoutePlugin` | Registers the concrete product image sets resource. | None | `Spryker\Glue\ProductImageSetsRestApi\Plugin` |
| `AbstractProductsProductImageSetsResourceRelationshipPlugin` | Adds the abstract product image sets resource as a relationship to the abstract product resource. | None | `Spryker\Glue\ProductImageSetsRestApi\Plugin\Relationship` |
| `ConcreteProductsProductImageSetsResourceRelationshipPlugin` | Adds the concrete product image sets resource as a relationship to the concrete product resource. | None | `Spryker\Glue\ProductImageSetsRestApi\Plugin\Relationship` |

<details open>
<summary markdown='span'>src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface;
use Spryker\Glue\ProductImageSetsRestApi\Plugin\AbstractProductImageSetsRoutePlugin;
use Spryker\Glue\ProductImageSetsRestApi\Plugin\ConcreteProductImageSetsRoutePlugin;
use Spryker\Glue\ProductImageSetsRestApi\Plugin\Relationship\AbstractProductsProductImageSetsResourceRelationshipPlugin;
use Spryker\Glue\ProductImageSetsRestApi\Plugin\Relationship\ConcreteProductsProductImageSetsResourceRelationshipPlugin;
use Spryker\Glue\ProductsRestApi\ProductsRestApiConfig;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
	/**
	* @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
	*/
	protected function getResourceRoutePlugins(): array
	{
		return [
			new AbstractProductImageSetsRoutePlugin(),
			new ConcreteProductImageSetsRoutePlugin(),
		];
	}

	/**
	* @param \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface $resourceRelationshipCollection
	*
	* @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface
	*/
	protected function getResourceRelationshipPlugins(
		ResourceRelationshipCollectionInterface $resourceRelationshipCollection
	): ResourceRelationshipCollectionInterface {
		$resourceRelationshipCollection->addRelationship(
			ProductsRestApiConfig::RESOURCE_ABSTRACT_PRODUCTS,
			new AbstractProductsProductImageSetsResourceRelationshipPlugin()
		);
		$resourceRelationshipCollection->addRelationship(
			ProductsRestApiConfig::RESOURCE_CONCRETE_PRODUCTS,
			new ConcreteProductsProductImageSetsResourceRelationshipPlugin()
		);

		return $resourceRelationshipCollection;
	}
}
```

<br>
</details>

{% info_block warningBox “Verification” %}

Make sure that the following endpoints are available:<ul><li>https://glue.mysprykershop.com/abstract-products/{% raw %}{{{% endraw %}abstract_sku{% raw %}}}{% endraw %}/abstract-product-image-sets</li><li>https://glue.mysprykershop.com/concrete-products/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %}/concrete-product-image-sets</li></ul>Send a request to "https://glue.mysprykershop.com/abstract-products/{% raw %}{{{% endraw %}abstract_sku{% raw %}}}{% endraw %}?include=abstract-product-image-sets". An abstract product with a given SKU should have at least one image set. Make sure that the response includes relationships to the `abstract-product-image-sets` resources.<br>Send a request to "https://glue.mysprykershop.com/concrete-products/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %}?include=abstract-product-image-sets". A concrete product with a given SKU should have at least one image set. Make sure that the response includes relationships to the "concrete-product-image-sets" resources.
{% endinfo_block %}

#### Enable resources and relationships
Activate the following plugins:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `AbstractProductPricesRoutePlugin` | Registers the abstract product prices resource. | None | `Spryker\Glue\ProductPricesRestApi\Plugin` |
| `ConcreteProductPricesRoutePlugin` | Registers the concrete product prices resource. | None | `Spryker\Glue\ProductPricesRestApi\Plugin` |
| `AbstractProductPricesByResourceIdResourceRelationshipPlugin` | Adds the abstract product prices resource as a relationship to the abstract product resource. | None | `Spryker\Glue\ProductPricesRestApi\Plugin\GlueApplication` |
| `ConcreteProductPricesByResourceIdResourceRelationshipPlugin` | `Adds the concrete product prices resource as a relationship to the concrete product resource.` | None | `Spryker\Glue\ProductPricesRestApi\Plugin\GlueApplication` |

<details open>
<summary markdown='span'>src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface;
use Spryker\Glue\ProductPricesRestApi\Plugin\AbstractProductPricesRoutePlugin;
use Spryker\Glue\ProductPricesRestApi\Plugin\ConcreteProductPricesRoutePlugin;
use Spryker\Glue\ProductPricesRestApi\Plugin\GlueApplication\AbstractProductPricesByResourceIdResourceRelationshipPlugin;
use Spryker\Glue\ProductPricesRestApi\Plugin\GlueApplication\ConcreteProductPricesByResourceIdResourceRelationshipPlugin;
use Spryker\Glue\ProductsRestApi\ProductsRestApiConfig;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
	/**
	* @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
	*/
	protected function getResourceRoutePlugins(): array
	{
		return [
			new AbstractProductPricesRoutePlugin(),
			new ConcreteProductPricesRoutePlugin(),
		];
	}

	/**
	* @param \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface $resourceRelationshipCollection
	*
	* @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface
	*/
	protected function getResourceRelationshipPlugins(
		ResourceRelationshipCollectionInterface $resourceRelationshipCollection
	): ResourceRelationshipCollectionInterface {
		$resourceRelationshipCollection->addRelationship(
			ProductsRestApiConfig::RESOURCE_ABSTRACT_PRODUCTS,
			new AbstractProductPricesByResourceIdResourceRelationshipPlugin()
		);
		$resourceRelationshipCollection->addRelationship(
			ProductsRestApiConfig::RESOURCE_CONCRETE_PRODUCTS,
			new ConcreteProductPricesByResourceIdResourceRelationshipPlugin()
		);

		return $resourceRelationshipCollection;
	}
}
```

<br>
</details>

{% info_block warningBox “Verification” %}

Make sure that the following endpoints are available:<ul><li>https://glue.mysprykershop.com/abstract-products/{% raw %}{{{% endraw %}abstract_sku{% raw %}}}{% endraw %}/abstract-product-prices</li><li>https://glue.mysprykershop.com/concrete-products/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %}/concrete-product-prices</li></ul>Send a request to "https://glue.mysprykershop.com/abstract-products/{% raw %}{{{% endraw %}abstract_sku{% raw %}}}{% endraw %}?include=abstract-product-prices". Make sure that the response includes relationships to the `abstract-product-prices` resources.<br>Make a request to "https://glue.mysprykershop.com/concrete-products/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %}?include=concrete-product-prices". Make sure that the response includes relationships to the `concrete-product-prices` resources.
{% endinfo_block %}

#### Enable resources and relationships
Activate the following plugin:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `AbstractProductsCategoriesResourceRelationshipPlugin` | Adds the categories resource as a relationship to the abstract product. | None | `Spryker\Glue\ProductsCategoriesResourceRelationship\Plugin` |

<details open>
<summary markdown='span'>src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface;
use Spryker\Glue\ProductsCategoriesResourceRelationship\Plugin\AbstractProductsCategoriesResourceRelationshipPlugin;
use Spryker\Glue\ProductsRestApi\ProductsRestApiConfig;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
	/**
	* @param \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface $resourceRelationshipCollection
	*
	* @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface
	*/
	protected function getResourceRelationshipPlugins(
		ResourceRelationshipCollectionInterface $resourceRelationshipCollection
	): ResourceRelationshipCollectionInterface {
		$resourceRelationshipCollection->addRelationship(
			ProductsRestApiConfig::RESOURCE_ABSTRACT_PRODUCTS,
			new AbstractProductsCategoriesResourceRelationshipPlugin()
		);

		return $resourceRelationshipCollection;
	}
}
```

<br>
</details>

{% info_block warningBox “Verification” %}

Send a request to https://glue.mysprykershop.com/abstract-products/{% raw %}{{{% endraw %}abstract_sku{% raw %}}}{% endraw %}?include=category-nodes.<br>Make sure that the response contains `category-nodes` as a relationship and `category-nodes` data included.
{% endinfo_block %}

<details open>
<summary markdown='span'>Example:</summary>

```json
{  
	"data":{  
		"type":"abstract-products",
		"id":"001",
		"attributes":{  
			...
		},
		"links":{  
			"self":"https://glue.mysprykershop.com/abstract-products/001"
		},
		"relationships":{  
			"category-nodes":{  
				"data":[  
					{  
						"type":"category-nodes",
						"id":"4"
					},
					{  
						"type":"category-nodes",
						"id":"2"
					}
				]
			}
		}
	},
	"included":[  
		{  
			"type":"category-nodes",
			"id":"4",
			"attributes":{  
				...
			},
			"links":{  
				"self":"https://glue.mysprykershop.com/category-nodes/4"
			}
		},
		{  
			"type":"category-nodes",
			"id":"2",
			"attributes":{  
				...
			},
			"links":{  
				"self":"https://glue.mysprykershop.com/category-nodes/2"
			}
		}
	]
}
```

<br>
</details>

*Last review date: Aug 05, 2019*

<!--by Tihran Voitov, Yuliia Boiko-->
