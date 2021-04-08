---
title: Marketplace Inventory Management feature integration
last_updated: Dec 16, 2020
summary: This document describes the process how to integrate the Marketplace Inventory Management Glue API feature into a Spryker project.
---

## Install feature Core
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version | Link |
|-|-|-|
| Spryker Core | master | [GLUE: Spryker Core Feature Integration](https://documentation.spryker.com/docs/glue-api-spryker-core-feature-integration)  |
| Marketplace Inventory Management | master | [Marketplace Inventory Management Feature Integration](/docs/marketplace/dev/feature-integration-guides/marketplace-inventory-management-feature-integration.html)  |

### 1) Install the required modules using composer
Run the following commands to install the required modules:

```bash
composer require spryker/product-offer-availabilities-rest-api:"^0.3.0" --update-with-dependencies
```

Make sure that the following modules have been installed:

| Module | Expected Directory |
|-|-|
| ProductOfferAvailabilitiesRestApi | vendor/spryker/product-offer-availabilities-rest-api |

### 2) Set up transfer objects
Run the following command to generate transfer changes:

```bash
console transfer:generate
```

Make sure that the following changes have been applied in transfer objects:

| Transfer | Type | Event | Path |
|-|-|-|-|
| RestProductOfferAvailabilitiesAttributes | object | Created | src/Generated/Shared/Transfer/RestProductOfferAvailabilitiesAttributesTransfer |

### 3) Set up behavior
Enable Resources and Relationships
Activate the following plugins:

| Plugin | Specification | Prerequisites | Namespace |
|-|-|-|-|
| ProductOfferAvailabilitiesResourceRoutePlugin | Registers the product-offer-availabilities resource. | None | Spryker\Glue\ProductOfferAvailabilitiesRestApi\Plugin\GlueApplication |
| ProductOfferAvailabilitiesByProductOfferReferenceResourceRelationshipPlugin | Adds the product-offer-availabilities resource as a relationship of the product-offers resource. | None | Spryker\Glue\ProductOfferAvailabilitiesRestApi\Plugin\GlueApplication |

**src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php**


```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface;
use Spryker\Glue\MerchantProductOffersRestApi\MerchantProductOffersRestApiConfig;
use Spryker\Glue\ProductOfferAvailabilitiesRestApi\Plugin\GlueApplication\ProductOfferAvailabilitiesByProductOfferReferenceResourceRelationshipPlugin;
use Spryker\Glue\ProductOfferAvailabilitiesRestApi\Plugin\GlueApplication\ProductOfferAvailabilitiesResourceRoutePlugin;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
    /**
     * @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
     */
    protected function getResourceRoutePlugins(): array
    {
        return [
            new ProductOfferAvailabilitiesResourceRoutePlugin(),
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
            MerchantProductOffersRestApiConfig::RESOURCE_PRODUCT_OFFERS,
            new ProductOfferAvailabilitiesByProductOfferReferenceResourceRelationshipPlugin()
        );

        return $resourceRelationshipCollection;
    }
}
```

Make sure that the `ProductOfferAvailabilitiesResourceRoutePlugin` plugin is set up by sending the request GET `http://glue.mysprykershop.com/product-offers/{{productOfferReference}}/product-offer-availabilities`.

Make sure that the `ProductOfferAvailabilitiesByProductOfferReferenceResourceRelationshipPlugin` plugin is set up by sending the request GET `http://glue.mysprykershop.com{{url}}/product-offers/{{productOfferReference}}?include=product-offer-availabilities`. The response should include the `product-offer-availabilities` resource along with the `product-offers`.