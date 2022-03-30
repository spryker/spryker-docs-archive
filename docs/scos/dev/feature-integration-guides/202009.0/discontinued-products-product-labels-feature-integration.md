---
title: Discontinued Products + Product Labels feature integration
description: This guide provides step-by-step instruction on integrating Discontinued Products + Product Labels feature into a Spryker-based project.
last_updated: Sep 21, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v6/docs/discontinued-products-product-labels-feature-integration
originalArticleId: 2ec3cb7c-f514-4815-9850-0ddd9abf59a1
redirect_from:
  - /v6/docs/discontinued-products-product-labels-feature-integration
  - /v6/docs/en/discontinued-products-product-labels-feature-integration
related:
  - title: Product labels feature integration
    link: docs/scos/dev/feature-integration-guides/page.version/product-labels-feature-integration.html
  - title: Discontinued product overview
    link: docs/scos/user/features/page.version/product-feature-overview/discontinued-products-overview.html
---

## Install Feature Core
Follow the steps below to install the feature core.


### Prerequisites
To start feature integration, overview, and install the necessary features:

| Name | Version |
| --- | --- |
| Discontinued Products | 202009.0 |
| Product Labels | 202009.0 |
| Spryker Core | 202009.0 |

### 1) Import Data
Follow the steps to import product label data:

{% info_block infoBox %}

The following imported entities will be used as a product label in Spryker OS.

{% endinfo_block %}

Prepare data according to your requirements using the following demo data:

**data/import/product_label.csv**

```yaml
name,is_active,is_dynamic,is_exclusive,front_end_reference,valid_from,valid_to,name.en_US,product_abstract_skus,priority
Discontinued,1,1,0,discontinued,,,Discontinued,Abgesetzt,,3
```

2. Run the command to import data:
3. 
```bash
console data:import product-label
``` 

{% info_block warningBox "Verification" %}

Ensure that the configured data has been added to the spy_product_label  table in the database.

{% endinfo_block %}

### 2) Set up Behaviour

Set up the following behavior:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| ProductDiscontinuedLabelUpdaterPlugin | Returns the list of relations of product labels to abstract products to assign or deassign product labels for. The results are used to persist product label relation changes into the database. The plugin is called by the `ProductLabelRelationUpdaterConsole` command. | None | Spryker\Zed\ProductDiscontinuedProductLabelConnector\Communication\Plugin |

**src/Pyz/Zed/ProductLabel/ProductLabelDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\ProductLabel;

use Spryker\Zed\ProductLabel\ProductLabelDependencyProvider as SprykerProductLabelDependencyProvider;
use Spryker\Zed\ProductDiscontinuedProductLabelConnector\Communication\Plugin\ProductDiscontinuedLabelUpdaterPlugin;

class ProductLabelDependencyProvider extends SprykerProductLabelDependencyProvider
{
    /**
     * @return \Spryker\Zed\ProductLabel\Dependency\Plugin\ProductLabelRelationUpdaterPluginInterface[]
     */
    protected function getProductLabelRelationUpdaterPlugins()
    {
        return [
            new ProductDiscontinuedLabelUpdaterPlugin(),
        ];
    }
}
```

{% info_block warningBox "Verification" %}

Ensure that, on the Storefront, the Discontinued product label is displayed on the *Catalog* and *Product Details* pages for all the products to which it is assigned.

{% endinfo_block %}
