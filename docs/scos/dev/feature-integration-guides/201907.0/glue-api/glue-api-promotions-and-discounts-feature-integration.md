---
title: GLUE API - Promotions and Discounts feature integration
search: exclude
description: The guide walks you through the process of installing Promotions&Discounts feature into the project
last_updated: Feb 7, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v3/docs/promotions-and-discounts-feature-integration-201907
originalArticleId: b85fcb26-9181-4f62-90e2-b2d91f63936c
redirect_from:
  - /v3/docs/promotions-and-discounts-feature-integration-201907
  - /v3/docs/en/promotions-and-discounts-feature-integration-201907
  - /docs/scos/dev/feature-integration-guides/201907.0/glue-api/glue-promotions-and-discounts-feature-integration.html
related:
  - title: Glue Application feature integration
    link: docs/scos/dev/feature-integration-guides/page.version/glue-api/glue-application-feature-integration.html
  - title: Product feature integration
    link: docs/scos/dev/feature-integration-guides/page.version/glue-api/glue-api-product-feature-integration.html
---

## Install Feature API
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version | Integration guide |
| --- | --- | --- |
| Spryker Core | 201907.0 | Glue Application feature integration |
| Product | 201907.0 | Products feature integration |
| Promotions & Discounts | 201907.0 | None |

### 1) Install the required modules using Composer
Run the following command(s) to install the required modules:

```bash
composer require spryker/product-labels-rest-api:"^1.0.0" --update-with-dependencies
```

{% info_block warningBox "Verification" %}

Make sure that the following modules were installed:

| Module | Expected Directory |
| --- | --- |
| `ProductLabelsRestApi` | `vendor/spryker/product-labels-rest-api` |

{% endinfo_block %}

### 2) Set up Transfer Objects
Run the following commands to generate transfer changes:

```bash
console transfer:generate
```

{% info_block warningBox "Verification" %}

Make sure that the following changes have been applied in transfer objects:

| Transfer | Type | Event | Path |
| --- | --- | --- | --- |
| `RestProductLabelsAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestProductLabelsAttributesTransfer` |

{% endinfo_block %}

### 3) Set up Behavior
#### Enable resources and relationships
Activate the following plugin:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `ProductLabelsRelationshipByResourceIdPlugin` | Adds a product labels resource as a relationship to the abstract product resource. | None | `Spryker\Glue\ProductLabelsRestApi\Plugin\GlueApplication` |
| `ProductLabelsResourceRoutePlugin` | Registers a product labels resource. | None | `Spryker\Glue\ProductLabelsRestApi\Plugin\GlueApplication` |

<details open>
<summary markdown='span'>src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\ProductLabelsRestApi\Plugin\GlueApplication\ProductLabelsRelationshipByResourceIdPlugin;
use Spryker\Glue\ProductLabelsRestApi\Plugin\GlueApplication\ProductLabelsResourceRoutePlugin;
use Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface;
use Spryker\Glue\ProductsRestApi\ProductsRestApiConfig;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
	/**
	* @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
	*/
	protected function getResourceRoutePlugins(): array
	{
		return [
			new ProductLabelsResourceRoutePlugin(),
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
			new ProductLabelsRelationshipByResourceIdPlugin()
		);

		return $resourceRelationshipCollection;
	}
}
```

<br>
</details>


{% info_block warningBox "Verification" %}

Make sure that the following endpoint is available: `https://glue.mysprykershop.comm/product-labels/{% raw %}{{{% endraw %}abstract_sku{% raw %}}}{% endraw %}`<br>Send a request to https://glue.mysprykershop.comom/abstract-products/{% raw %}{{{% endraw %}sku{% raw %}}}{% endraw %}?include=product-labels` and verify if the abstract product with a given SKU has at least one assigned product label and the response includes relationships to product-labels resources.)

{% endinfo_block %}
