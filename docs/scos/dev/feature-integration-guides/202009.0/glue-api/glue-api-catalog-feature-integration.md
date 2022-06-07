---
title: Glue API - Catalog feature integration
search: exclude
description: Use the guide to install the Glue Catalog feature in your project.
last_updated: Aug 27, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v6/docs/catalog-api-feature-integration
originalArticleId: fd69f851-19fb-475c-b3c0-56ce30448fb0
redirect_from:
  - /v6/docs/catalog-api-feature-integration
  - /v6/docs/en/catalog-api-feature-integration
related:
  - title: Catalog Search
    link: docs/scos/dev/glue-api-guides/page.version/searching-the-product-catalog.html
---

## Install Feature API
### Prerequisites

To start feature integration, overview and install the necessary features:

| Name | Version | Integration guide |
| --- | --- | --- |
| Spryker Core | 202009.0 | [Glue Application feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-glue-application-feature-integration.html) |
| Search | 202009.0 |  |
| Catalog | 202009.0 |  |
| Product | 202009.0 | [Product API feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-product-feature-integration.html) |
| Catalog + Price | 202009.0 |  |

### 1) Install the required modules using Composer
Run the following command to install the required modules:

```bash
composer require spryker/catalog-search-rest-api:"^2.1.2" spryker/catalog-search-products-resource-relationship:"^1.1.0" --update-with-dependencies
```

{% info_block warningBox “Verification” %}

Make sure that the following modules are installed:

{% endinfo_block %}

| Module | Expected Directory |
| --- | --- |
| `CatalogSearchRestApi` | `vendor/spryker/catalog-search-rest-api` |
| `CatalogSearchProductsResourceRelationship` | `vendor/spryker/catalog-search-products-resource-relationship` |

### 2) Set up Transfer Objects
Run the following command to generate transfer changes:

```bash
console transfer:generate
```

{% info_block warningBox “Verification” %}

Make sure that the following changes have occurred in transfer objects:

{% endinfo_block %}

| Transfer | Type | Event | Path |
| --- | --- | --- | --- |
| `RestCatalogSearchAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestCatalogSearchAttributesTransfer` |
| `RestCatalogSearchSortTransfer` | class | created | `src/Generated/Shared/Transfer/RestCatalogSearchSortTransfer` |
| `RestCatalogSearchPaginationTransfer` | class | created | `src/Generated/Shared/Transfer/RestCatalogSearchPaginationTransfer` |
| `RestCatalogSearchAbstractProductsTransfer` | class | created | `src/Generated/Shared/Transfer/RestCatalogSearchAbstractProductsTransfer` |
| `RestCatalogSearchProductImageTransfer` | class | created | `src/Generated/Shared/Transfer/RestCatalogSearchProductImageTransfer` |
| `RestRangeSearchResultTransfer`| class| created | `src/Generated/Shared/Transfer/RestRangeSearchResultTransfer`|
| `RestFacetSearchResultTransfer`| class| created | `src/Generated/Shared/Transfer/RestFacetSearchResultTransfer`|
| `RestCatalogSearchSuggestionsAttributesTransfer`| class	| created | `src/Generated/Shared/Transfer/RestCatalogSearchSuggestionsAttributesTransfer` |
| `RestCatalogSearchSuggestionAbstractProductsTransfer`| class|	created | `src/Generated/Shared/Transfer/RestCatalogSearchSuggestionAbstractProductsTransfer`|
| `RestCatalogSearchSuggestionProductImageTransfer`| class| created | `src/Generated/Shared/Transfer/RestCatalogSearchSuggestionProductImageTransfer`|
| `RestPriceProductTransfer` | class | created | `src/Generated/Shared/Transfer/RestPriceProductTransfer`|
| `PriceModeConfigurationTransfer`| class | created | `src/Generated/Shared/Transfer/PriceModeConfigurationTransfer`|
| `RestCurrencyTransfer`| class| created | `src/Generated/Shared/Transfer/RestCurrencyTransfer`|
| `RestFacetConfigTransfer`| class | created | `src/Generated/Shared/Transfer/RestFacetConfigTransfer`|

### 3) Set Up Behavior
#### Enable resources and relationships
Activate the following plugins:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `CatalogSearchAbstractProductsResourceRelationshipPlugin` | Adds the `abstract-products` resource relationship to search results. | None | `Spryker\Glue\CatalogSearchProductsResourceRelationship\Plugin` |
| `CatalogSearchSuggestionsAbstractProductsResourceRelationshipPlugin` | Adds the `abstract-products` resource relationship to search suggestions results. | None | `Spryker\Glue\CatalogSearchProductsResourceRelationship\Plugin` |
| `CatalogSearchResourceRoutePlugin` | Registers the `search` resource. | None | `Spryker\Glue\CatalogSearchRestApi\Plugin` |
| `CatalogSearchSuggestionsResourceRoutePlugin` | Registers the `search-suggestions` resource. | None | `Spryker\Glue\CatalogSearchRestApi\Plugin` |

src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php

```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\CatalogSearchProductsResourceRelationship\Plugin\CatalogSearchAbstractProductsResourceRelationshipPlugin;
use Spryker\Glue\CatalogSearchProductsResourceRelationship\Plugin\CatalogSearchSuggestionsAbstractProductsResourceRelationshipPlugin;
use Spryker\Glue\CatalogSearchRestApi\CatalogSearchRestApiConfig;
use Spryker\Glue\CatalogSearchRestApi\Plugin\CatalogSearchResourceRoutePlugin;
use Spryker\Glue\CatalogSearchRestApi\Plugin\CatalogSearchSuggestionsResourceRoutePlugin;
use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
	/**
	* @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
	*/
	protected function getResourceRoutePlugins(): array
	{
		return [
			new CatalogSearchResourceRoutePlugin(),
			new CatalogSearchSuggestionsResourceRoutePlugin(),
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
			CatalogSearchRestApiConfig::RESOURCE_CATALOG_SEARCH,
			new CatalogSearchAbstractProductsResourceRelationshipPlugin()
		);
		$resourceRelationshipCollection->addRelationship(
			CatalogSearchRestApiConfig::RESOURCE_CATALOG_SEARCH_SUGGESTIONS,
			new CatalogSearchSuggestionsAbstractProductsResourceRelationshipPlugin()
		);

		return $resourceRelationshipCollection;
	}
}
```

{% info_block warningBox “Verification” %}

If `CatalogSearchResourceRoutePlugin` and `CatalogSearchSuggestionsResourceRoutePlugin` are installed correctly, the following endpoints should now be available:
- https://glue.mysprykershop.com/catalog-search?q={% raw %}{{{% endraw %}q_term{% raw %}}}{% endraw %}
- https://glue.mysprykershop.com/catalog-search-suggestions?q={% raw %}{{{% endraw %}q_term{% raw %}}}{% endraw %}

{% endinfo_block %}

{% info_block warningBox “Verification” %}

To make sure that `CatalogSearchAbstractProductsResourceRelationshipPlugin` and `CatalogSearchSuggestionsAbstractProductsResourceRelationshipPlugin` are functioning correctly, do the following:
- Send a request to `https://glue.mysprykershop.com/catalog-search?q={% raw %}{{{% endraw %}q_term{% raw %}}}{% endraw %}&include=abstract-products` and verify that the response includes relationships to `abstract-products` resources.
- Send a request to `https://glue.mysprykershop.com/catalog-search-suggestions?q={% raw %}{{{% endraw %}q_term{% raw %}}}{% endraw %}&include=abstract-products` and verify that the response includes relationships to `abstract-products` resources.
- 
{% endinfo_block %}
