---
title: Glue API - Product Availability feature integration
description: This guide will navigate you through the process of installing and configuring the Product Availability feature in Spryker OS.
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v2/docs/glue-api-product-availability-feature-integration
originalArticleId: 7593e018-46de-4e85-99ff-8f18a639509a
redirect_from:
  - /v2/docs/glue-api-product-availability-feature-integration
  - /v2/docs/en/glue-api-product-availability-feature-integration
---

## Install Feature API
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Spryker Core | 2018.12.0 |
|  Product Management| 2018.12.0 |
| Availability | 2018.12.0 |
| ProductsRestApi  | 2.2.3 |
### 1) Install the required modules using Composer

Run the following commands to install the required modules:
```
composer require spryker/product-availabilities-rest-api:"^1.0.3" --update-with-dependencies
composer require spryker/products-product-availabilities-resource-relationship:"^1.0.0" --update-with-dependencies
```

{% info_block infoBox "Verification" %}
Make sure that the following modules are installed:
{% endinfo_block %}

| Module | Expected directory |
| --- | --- |
| `ProductAvailabilitiesRestApi` | `vendor/spryker/product-availabilities-rest-api` |
| `ProductsProductAvailabilitiesResourceRelationship` | `vendor/spryker/products-product-availabilities-resource-relationship` |

### 2) Set up Transfer objects
#### Implementation
Run the following commands to generate transfer changes:
`console transfer:generate
`

{% info_block infoBox "Verification" %}
Make sure that the following changes in transfer objects are present:	
{% endinfo_block %}

|Transfer  | Type | Event | Path |
| --- | --- | --- | --- |
| `RestAbstractProductAvailabilityAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestAbstractProductAvailabilityAttributesTransfer` |
| `RestConcreteProductAvailabilityAttributesTransfer` | class | created | `src/Generated/Shared/Transfer/RestConcreteProductAvailabilityAttributesTransfer` |

### 3) Set up behavior
#### Enable resources and relationships
**Implementation**
Activate the following plugin:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `AbstractProductAvailabilitiesRoutePlugin` | Registers the abstract product availabilities resource. | None | `Spryker\Glue\ProductAvailabilitiesRestApi\Plugin` |
| `ConcreteProductAvailabilitiesRoutePlugin` | Registers the concrete product availabilities resource. | None | `Spryker\Glue\ProductAvailabilitiesRestApi\Plugin` |
| `AbstractProductAvailabilitiesResourceRelationshipPlugin` | Adds the abstract product availability resource as a relationship to the abstract product resource. | None | `Spryker\Glue\ProductsProductAvailabilitiesResourceRelationship\Plugin` |
| `ConcreteProductAvailabilitiesResourceRelationshipPlugin` | Adds the concrete product availability resource as a relationship to the concrete product resource. | None | `Spryker\Glue\ProductsProductAvailabilitiesResourceRelationship\Plugin` |

**`src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php`**
```php
<?php
 
namespace Pyz\Glue\GlueApplication;
 
use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\ProductAvailabilitiesRestApi\Plugin\AbstractProductAvailabilitiesRoutePlugin;
use Spryker\Glue\ProductAvailabilitiesRestApi\Plugin\ConcreteProductAvailabilitiesRoutePlugin;
use Spryker\Glue\ProductsProductAvailabilitiesResourceRelationship\Plugin\AbstractProductAvailabilitiesResourceRelationshipPlugin;
use Spryker\Glue\ProductsProductAvailabilitiesResourceRelationship\Plugin\ConcreteProductAvailabilitiesResourceRelationshipPlugin;
use Spryker\Glue\ProductsRestApi\ProductsRestApiConfig;
 
class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
    /**
     * @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
     */
    protected function getResourceRoutePlugins(): array
    {
        return [
            new AbstractProductAvailabilitiesRoutePlugin(),
            new ConcreteProductAvailabilitiesRoutePlugin(),
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
            new AbstractProductAvailabilitiesResourceRelationshipPlugin()
        );
        $resourceRelationshipCollection->addRelationship(
            ProductsRestApiConfig::RESOURCE_CONCRETE_PRODUCTS,
            new ConcreteProductAvailabilitiesResourceRelationshipPlugin()
        );
 
        return $resourceRelationshipCollection;
    }
}
```

**Verification**
{% info_block infoBox %}
Make sure that the following endpoints are available:
{% endinfo_block %}

* `http://mysprykershop.comop.com/abstract-products/{% raw %}{{{% endraw %}abstract_sku{% raw %}}}{% endraw %}/abstract-product-availabilities`
* `http://mysprykershop.comop.com/concrete-products/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %}/concrete-product-availabilities`
{% info_block infoBox %}
Make a request to `http://mysprykershop.comop.com/abstract-products/{% raw %}{{{% endraw %}abstract_sku{% raw %}}}{% endraw %}?include=abstract-product-availabilities`. Make sure that the response includes relationships to the `abstract-product-availabilities` resource.
{% endinfo_block %}
{% info_block infoBox %}
Make a request to `http://mysprykershop.comop.com/concrete-products/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %}?include=concrete-product-availabilities`. Make sure that the response includes relationships to the `concrete-product-availabilities` resource.
{% endinfo_block %}

_Last review date: Feb 19, 2019_
