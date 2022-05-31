---
title: Glue API Navigation feature integration
description: This guide will navigate you through the process of installing and configuring the Navigation feature in Spryker OS.
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v2/docs/navigation-api-feature-integration
originalArticleId: d5da7ef9-22df-40f3-ab79-dfe832c1f403
redirect_from:
  - /v2/docs/navigation-api-feature-integration
  - /v2/docs/en/navigation-api-feature-integration
  - /docs/scos/dev/feature-integration-guides/201903.0/glue-api/navigation-api-feature-integration.html
---

## Install Feature API
### Prerequisites
To start feature integration, review and install the necessary features:
|Name|Version|
|---|---|
|Spryker Core|201903.0|
|Navigation|201903.0|
### 1) Install the required modules using Composer

Run the following command to install the required modules:
```yaml
composer require spryker/navigations-rest-api:"^1.0.0" --update-with-dependencies
```

{% info_block infoBox "Verification" %}
Make sure that the following module is installed:
{% endinfo_block %}
|Module|Expected Directory|
|---|---|
|`NavigationsRestApi`|`vendor/spryker/navigations-rest-api`|
### 2) Set up Transfer Objects

Run the following commands to generate transfer changes:
```yaml
console transfer:generate
```
{% info_block infoBox "Verification" %}
Make sure that the following changes are present in the transfer objects:
{% endinfo_block %}
|Transfer|Type|Event|Path|
|---|---|---|---|
|`RestNavigationAttributesTransfer`|class|created|`src/Generated/Shared/Transfer/RestNavigationAttributesTransfer`|
|`RestNavigationNodeTransfer`|class|created|`src/Generated/Shared/Transfer/RestNavigationNodeTransfer`|

### 3) Set up Configuration
Configure mapping to specify source field from which resourceId field should be filled depends on navigation node type.
**`src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php`**
```php
<?php

namespace Pyz\Glue\NavigationsRestApi;

use Spryker\Glue\NavigationsRestApi\NavigationsRestApiConfig as SprykerNavigationsRestApiConfigi;

class NavigationsRestApiConfig extends SprykerNavigationsRestApiConfig
{
    /**
     * @return array
     */
    public function getNavigationTypeToUrlResourceIdFieldMapping(): array
    {
        return [
            'category' =&gt; 'fkResourceCategorynode',
            'cms_page' =&gt; 'fkResourcePage',
        ];
    }
}
```
### 4) Set up Behavior

#### Enable Resources and Relationships
Activate the following plugin:
|Plugin|Specification|Prerequisites|Namespace|
|---|---|---|---|
|`NavigationsResourceRoutePlugin`|Registers the navigations resource.|None|`Spryker\Glue\NavigationsRestApi\Plugin\ResourceRoute`|
**`src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php`**
```php
<;?php

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
            new NavigationsResourceRoutePlugin(),
        ];
    }
}
```

{% info_block infoBox "Verification" %}
Make sure that the following endpoint is available:<br>http://mysprykershop.com/navigations/`{navigationId}`
{% endinfo_block %}
