---
title: CMS + product lists + catalog feature integration
last_updated: Mar 10, 2021
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v6/docs/cms-page-search-product-lists-catalog-feature-integration
originalArticleId: ccda72ae-7a95-4e61-bcde-ae73fe8c77c8
redirect_from:
  - /v6/docs/cms-page-search-product-lists-catalog-feature-integration
  - /v6/docs/en/cms-page-search-product-lists-catalog-feature-integration
related:
  - title: CMS pages in search results
    link: docs/scos/user/features/page.version/cms-feature-overview/cms-pages-in-search-results-overview.html
  - title: CMS page
    link: docs/scos/user/features/page.version/cms-feature-overview/cms-pages-overview.html
---

## Install Feature Core

### Prerequisites

Please overview and install the necessary features before beginning the integration step.

| Name | Version |
| --- | --- |
| Cms | master |
| Product lists | master |
| Catalog | master |
| Customer | master |

### 1) Install the required modules using Composer

Run the following command to install the required modules:
```bash
composer require spryker/customer-catalog:"^1.0.0" --update-with-dependencies
```
{% info_block warningBox "Verification" %}

Make sure that the following modules were installed:

| Module | Expected Directory |
| --- | --- |
| CustomerCatalog | vendor/spryker/customer-catalog |

{% endinfo_block %}

## Set up Behavior

#### Configure the Catalog Search Count Query

Add the following plugins to your project:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `ProductListQueryExpanderPlugin` | Extends a search query by filtering down results to match the current customer's product restrictions. | None |  `\Spryker\Client\CustomerCatalog\Plugin\Search\ProductListQueryExpanderPlugin` |

**src/Pyz/Client/Catalog/CatalogDependencyProvider.php**
    
 ```php
 <?php

namespace Pyz\Client\Catalog;

use Spryker\Client\Catalog\CatalogDependencyProvider as SprykerCatalogDependencyProvider;
use Spryker\Client\CustomerCatalog\Plugin\Search\ProductListQueryExpanderPlugin;

class CatalogDependencyProvider extends SprykerCatalogDependencyProvider
{
        /**
        * @return \Spryker\Client\Search\Dependency\Plugin\QueryExpanderPluginInterface[]
        */
         protected function createCatalogSearchCountQueryExpanderPlugins():             array
                    {
                             return [
                                        new ProductListQueryExpanderPlugin(),
                             ];
                 }
}
 ```

{% info_block warningBox "Verification" %}
Make sure that the number of products on the catalog tab item is correct according to the customer's assigned product lists.
{% endinfo_block %}
