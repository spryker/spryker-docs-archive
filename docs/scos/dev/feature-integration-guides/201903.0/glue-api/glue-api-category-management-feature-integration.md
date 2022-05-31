---
title: Glue API - Category Management feature integration
description: This guide will navigate you through the process of installing and configuring the Category API feature in Spryker OS.
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v2/docs/category-api-feature-integration-201903
originalArticleId: 15f393b8-d90b-4f44-bd15-9c8112d8651b
redirect_from:
  - /v2/docs/category-api-feature-integration-201903
  - /v2/docs/en/category-api-feature-integration-201903
  - /docs/scos/dev/feature-integration-guides/201903.0/glue-api/category-api-feature-integration.html
---

## Install Feature API
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name |Version  |
| --- | --- |
| Spryker Core |201903.0  |
| Category Management |201903.0  |

### 1) Install the required modules using Composer

Run the following command to install the required modules:
```yaml
composer require spryker/categories-rest-api:"^1.1.3" --update-with-dependencies
```

{% info_block infoBox "Verification" %}
Make sure that the following modules are installed:
{% endinfo_block %}

| Module | Expected directory |
| --- | --- |
| `CategoriesRestApi` | `vendor/spryker/categories-rest-api` |

### 2) Set up Transfer Objects

Run the following command to generate transfer changes:
```yaml
console transfer:generate
```

{% info_block infoBox "Verification" %}
Make sure that the following changes are present in transfer objects:
{% endinfo_block %}

| Transfer | Type | Event | Path |
| --- | --- | --- | --- |
| `RestCategoryTreesTransfer` | class | created | `src/Generated/Shared/Transfer/RestCategoryTreesTransfer` |
| `RestCategoryTreesAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestCategoryTreesAttributesTransfer` |
| `RestCategoryNodesAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestCategoryNodesAttributesTransfer` |

### 3) Set up Behavior
#### Enable resources and relationships:

Activate the following plugin:

| Plugin |Specification  | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `CategoriesResourceRoutePlugin` | Registers the `category tree` resource.	 | None | `Spryker\Glue\CategoriesRestApi\Plugin` |
| `CategoryResourceRoutePlugin	` | Registers the `category nodes` resource. | None | `Spryker\Glue\CategoriesRestApi\Plugin` |

**`src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php`**
```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\CategoriesRestApi\Plugin\CategoriesResourceRoutePlugin;
use Spryker\Glue\CategoriesRestApi\Plugin\CategoryResourceRoutePlugin;
use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
    /**
     * @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
     */
    protected function getResourceRoutePlugins(): array
    {
        return [
            new CategoriesResourceRoutePlugin(),
            new CategoryResourceRoutePlugin(),
        ];
    }
}
```

{% info_block infoBox "Verification" %}
Make sure the following endpoints are available:
{% endinfo_block %}

* `http://mysprykershop.com/category-trees`
* `http://mysprykershop.com/category-nodes/{% raw %}{{{% endraw %}category_node_id{% raw %}}}{% endraw %}`

**See also:**
Browsing a Category Tree

_Last review date: Apr 11, 2019_
