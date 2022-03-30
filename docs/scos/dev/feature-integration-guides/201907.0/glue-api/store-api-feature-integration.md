---
title: Glue API - Store feature integration
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v3/docs/store-api-feature-integration
originalArticleId: 77bd87b1-8f70-4a1b-b580-60d9eecc56ad
redirect_from:
  - /v3/docs/store-api-feature-integration
  - /v3/docs/en/store-api-feature-integration
---

## Install Feature API
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name |  Version |
| --- | --- |
| Spryker Core | 2018.12.0 |

## 1) Install the required modules using composer
Run the following command to install the required modules:

```bash
composer require spryker/stores-rest-api:"^1.0.2" --update-with-dependencies
```

{% info_block infoBox "Verification" %}
Make sure that the following module is installed:
{% endinfo_block %}

| Module | Expected directory |
| --- | --- |
| `StoresRestApi` | `vendor/spryker/stores-rest-api` |

## 2) Set up Transfer objects
Run the following command:

```bash
console transfer:generate
```

{% info_block infoBox "Verification" %}
Make sure that the following changes are present in the transfer objects:
{% endinfo_block %}

| Transfer | Type | Event | Path |
| --- | --- | --- | --- |
| `StoresRestAttributesTransfer` |class  |created  | `src/Generated/Shared/Transfer/StoresRestAttributesTransfer` |
| `StoreCountryRestAttributesTransfer` | class |created  | `src/Generated/Shared/Transfer/StoreCountryRestAttributesTransfer` |
|`StoreRegionRestAttributesTransfer`  |class  |created  |`src/Generated/Shared/Transfer/StoreRegionRestAttributesTransfer`  |
| `StoreLocaleRestAttributesTransfer` |class  | created | `src/Generated/Shared/Transfer/StoreLocaleRestAttributesTransfer` |
| `StoreCurrencyRestAttributesTransfer` |class  |created  |`src/Generated/Shared/Transfer/StoreCurrencyRestAttributesTransfer`  |

## 3) Set up behavior
### Enable resource
Activate the following plugin:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `StoresResourceRoutePlugin` |Registers orders resource.  |None  | `Spryker\Glue\StoresRestApi\Plugin` |

```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\StoresRestApi\Plugin\StoresResourceRoutePlugin;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
    /**
     * @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
     */
    protected function getResourceRoutePlugins(): array
    {
        return [
            new StoresResourceRoutePlugin(),
        ];
    }
}
              ...
```

{% info_block infoBox "Verification" %}
Make sure that following endpoint is available:<br>`http://mysprykershop.com/stores`
{% endinfo_block %}
