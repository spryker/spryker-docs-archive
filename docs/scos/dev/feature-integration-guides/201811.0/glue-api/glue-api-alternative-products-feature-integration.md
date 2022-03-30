---
title: Glue API - Alternative products feature integration
description: This guide will navigate you through the process of installing and configuring the Alternative Products API feature in Spryker OS.
last_updated: May 19, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v1/docs/alternative-products-api-feature-integration
originalArticleId: 180d8b0d-1c47-4617-8ee7-6491710d04ec
redirect_from:
  - /v1/docs/alternative-products-api-feature-integration
  - /v1/docs/en/alternative-products-api-feature-integration
---

## Install Feature API

### Prerequisites

To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Spryker Core | {{page.version}} |
| Alternative Products | {{page.version}} |
| ProductsRestApi | 2.3.0 |

## 1) Install the required modules using Composer

Run the following command to install the required modules:
`composer require spryker/alternative-products-rest-api:"^1.0.0" --update-with-dependencies`

<section contenteditable="false" class="warningBox"><div class="content">
    Make sure that the following module is installed:

| Module | Expected Directory |
| --- | --- |
| `AlternativeProductsRestApi` | `vendor/spryker/alternative-products-rest-api` |
</div></section>

## 2) Set up Behavior

Activate the following plugins:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `AbstractAlternativeProductsResourceRoutePlugin` | Registers the abstract alternative products resource. | None | `Spryker\Glue\AlternativeProductsRestApi\Plugin\GlueApplication` |
| `ConcreteAlternativeProductsResourceRoutePlugin` | Registers the concrete alternative products resource. | None | `Spryker\Glue\AlternativeProductsRestApi\Plugin\GlueApplication` |

**`src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php`**
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
            new AbstractAlternativeProductsResourceRoutePlugin(),
            new ConcreteAlternativeProductsResourceRoutePlugin(),
        ];
    }
}
```
{% info_block warningBox "Warning" %}

Make sure that the following endpoints are available:

* `http://mysprykershop.com/concrete-products/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %}/abstract-alternative-products`
* `http://mysprykershop.com/concrete-products/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %}/abstract-alternative-products`

{% endinfo_block %}


**See also:**
[Retrieving Alternative Products](/docs/scos/dev/glue-api-guides/{{page.version}}/retrieving-alternative-products.html)

