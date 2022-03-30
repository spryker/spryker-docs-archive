---
title: Glue API - Shipment feature integration
last_updated: Jul 13, 2021
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/glue-api-shipment-feature-integration
originalArticleId: a324452c-5bf0-49f9-a6d8-fd59abf3b414
redirect_from:
  - /2021080/docs/glue-api-shipment-feature-integration
  - /2021080/docs/en/glue-api-shipment-feature-integration
  - /docs/glue-api-shipment-feature-integration
  - /docs/en/glue-api-shipment-feature-integration
related:
  - title: Checking Out Purchases and Getting Checkout Data
    link: docs/scos/dev/glue-api-guides/page.version/checking-out/checking-out-purchases.html
---

This document describes how to integrate the Shipment feature API into a Spryker project.

## Prerequisites

To start feature integration, overview and install the necessary features:

| FEATURE | VERSION | INTEGRATION GUIDE  |
| ----------------- | ------ | ------------------- |
| Glue API: Spryker Core     | {{page.version}}  | [Glue API: Spryker Core feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-spryker-core-feature-integration.html) |
| Shipment                  | {{page.version}}  | [Shipment feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/shipment-feature-integration.html) |
| Glue API: Checkout         | {{page.version}}  | [Glue API: Checkout feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-checkout-feature-integration.html) |
| Glue API: Glue Application      | {{page.version}}  | [Glue API: Glue Application feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-glue-application-feature-integration.html) |
| Glue API: Order Management | {{page.version}}  | [Glue API: Order Management feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-order-management-feature-integration.html) |

## 1) Install the required modules using Composer

Install the required modules:

```bash
composer require spryker/shipments-rest-api:"1.4.0" --update-with-dependencies
```

{% info_block warningBox "Verification" %}

Make sure that the following modules have been installed:

| MODULE         | EXPECTED DIRECTORY            |
| -------------- | ----------------------------- |
| ShipmentsRestApi | vendor/spryker/shipments-rest-api |

{% endinfo_block %}



## 2) Set up transfer objects

Generate transfer changes:

```bash
console transfer:generate
```

{% info_block warningBox "Verification" %}

Make sure that the following changes have been applied in transfer objects:

| TRANSFER    | TYPE     | EVENT   | PATH     |
| ----------------- | ------ | ----- | -------------------------- |
| RestCheckoutDataTransfer                   | class    | created | src/Generated/Shared/Transfer/RestCheckoutDataTransfer.php   |
| RestCheckoutRequestAttributesTransfer      | class    | created | src/Generated/Shared/Transfer/RestCheckoutRequestAttributesTransfer.php |
| RestShipmentTransfer                       | class    | created | src/Generated/Shared/Transfer/RestShipmentTransfer.php       |
| RestCheckoutDataResponseAttributesTransfer | class    | created | src/Generated/Shared/Transfer/RestCheckoutDataResponseAttributesTransfer.php |
| RestShipmentMethodTransfer                 | class    | created | src/Generated/Shared/Transfer/RestShipmentMethodTransfer.php |
| CheckoutResponseTransfer                   | class    | created | src/Generated/Shared/Transfer/CheckoutResponseTransfer.php   |
| CheckoutErrorTransfer                      | class    | created | src/Generated/Shared/Transfer/CheckoutErrorTransfer.php      |
| AddressTransfer                            | class    | created | src/Generated/Shared/Transfer/AddressTransfer.php            |
| ShipmentMethodTransfer                     | class    | created | src/Generated/Shared/Transfer/ShipmentMethodTransfer.php     |
| ShipmentMethodsTransfer                    | class    | created | src/Generated/Shared/Transfer/ShipmentMethodsTransfer.php    |
| QuoteTransfer                              | class    | created | src/Generated/Shared/Transfer/QuoteTransfer.php              |
| StoreTransfer                              | class    | created | src/Generated/Shared/Transfer/StoreTransfer.php              |
| MoneyValueTransfer                         | class    | created | src/Generated/Shared/Transfer/MoneyValueTransfer.php         |
| CurrencyTransfer                           | class    | created | src/Generated/Shared/Transfer/CurrencyTransfer.php           |
| ShipmentTransfer                           | class    | created | src/Generated/Shared/Transfer/ShipmentTransfer.php           |
| CheckoutDataTransfer                       | class    | created | src/Generated/Shared/Transfer/CheckoutDataTransfer.php       |
| ExpenseTransfer                            | class    | created | src/Generated/Shared/Transfer/ExpenseTransfer.php            |
| ItemTransfer                               | class    | created | src/Generated/Shared/Transfer/ItemTransfer.php               |
| RestShipmentMethodsAttributesTransfer      | class    | created | src/Generated/Shared/Transfer/RestShipmentMethodsAttributesTransfer.php |
| RestShipmentsAttributesTransfer            | class    | created | src/Generated/Shared/Transfer/RestShipmentsAttributesTransfer.php |
| RestShipmentsTransfer                      | class    | created | src/Generated/Shared/Transfer/RestShipmentsTransfer.php      |
| RestAddressTransfer                        | class    | created | src/Generated/Shared/Transfer/RestAddressTransfer.php        |
| CountryTransfer                            | class    | created | src/Generated/Shared/Transfer/CountryTransfer.php            |
| RestErrorCollectionTransfer                | class    | created | src/Generated/Shared/Transfer/RestErrorCollectionTransfer.php |
| RestErrorMessageTransfer                   | class    | created | src/Generated/Shared/Transfer/RestErrorMessageTransfer.php   |
| ShipmentGroupTransfer                      | class    | created | src/Generated/Shared/Transfer/ShipmentGroupTransfer.php      |
| ShipmentMethodsCollectionTransfer          | class    | created | src/Generated/Shared/Transfer/ShipmentMethodsCollectionTransfer.php |
| RestOrderShipmentsAttributesTransfer       | class    | created | src/Generated/Shared/Transfer/RestOrderShipmentsAttributesTransfer.php |
| RestOrderAddressTransfer                   | class    | created | src/Generated/Shared/Transfer/RestOrderAddressTransfer.php   |
| OrderTransfer                              | class    | created | src/Generated/Shared/Transfer/OrderTransfer.php              |
| RestOrderDetailsAttributesTransfer         | class    | created | src/Generated/Shared/Transfer/RestOrderDetailsAttributesTransfer.php |
| RestOrderItemsAttributesTransfer           | class    | created | src/Generated/Shared/Transfer/RestOrderItemsAttributesTransfer.php |
| ShipmentCarrierTransfer                    | class    | created | src/Generated/Shared/Transfer/ShipmentCarrierTransfer.php    |
| RestOrderExpensesAttributesTransfer        | class    | created | src/Generated/Shared/Transfer/RestOrderExpensesAttributesTransfer.php |
| GiftCardMetadataTransfer                   | class    | created | src/Generated/Shared/Transfer/GiftCardMetadataTransfer.php   |
| QuoteTransfer.bundleItems                  | property | added   | src/Generated/Shared/Transfer/QuoteTransfer.php              |
| ShipmentMethodTransfer.name                | property | added   | src/Generated/Shared/Transfer/ShipmentMethodTransfer.php     |
| ExpenseTransfer.idSalesExpense             | property | added   | src/Generated/Shared/Transfer/ExpenseTransfer.php            |
| CheckoutErrorTransfer.parameters           | property | added   | src/Generated/Shared/Transfer/CheckoutErrorTransfer.php      |
| ShipmentMethodsTransfer.shipmentHash       | property | added   | src/Generated/Shared/Transfer/ShipmentMethodsTransfer.php    |

{% endinfo_block %}

## 3) Add translations

Add translations as follows:

1. Append glossary according to your configuration:

```text
checkout.validation.item.no_shipment_selected,No shipment selected for the cart item %id%.,en_US
checkout.validation.item.no_shipment_selected,Es wurde keine Lieferung für den Warenkorbartikel %id% ausgewählt.,de_DE
```

2. Import data:

```bash
console data:import glossary
```

{% info_block warningBox "Verification" %}

Make sure that in the database the configured data has been added to the `spy_glossary` table.


{% endinfo_block %}


## 4) Set up behavior

Set up the following behaviors.

### Enable resources and relationships

Activate the following plugin(s):


| PLUGIN  | SPECIFICATION   | PREREQUISITES | NAMESPACE        |
|--------- | -------------------- | ---------- | -------------- |
| ShipmentMethodsByCheckoutDataResourceRelationshipPlugin | If `RestCheckoutDataTransfer` is provided as payload, adds the `shipment-methods` resource as relationship. |               | Spryker\Glue\ShipmentsRestApi\Plugin\GlueApplication |
| OrderShipmentByOrderResourceRelationshipPlugin          | If `OrderTransfer` is provided as a payload, adds the `order-shipments` resource as a relationship . |               | Spryker\Glue\ShipmentsRestApi\Plugin\GlueApplication |
| ShipmentMethodsByShipmentResourceRelationshipPlugin     | If`ShipmentGroupTransfer` is provided as payload, adds the `shipment-methods` resource as relationship. |               | Spryker\Glue\ShipmentsRestApi\Plugin\GlueApplication |
| ShipmentsByCheckoutDataResourceRelationshipPlugin       | Adds `shipments` resource as relationship if `RestCheckoutDataTransfer` is provided as payload. |               | Spryker\Glue\ShipmentsRestApi\Plugin\GlueApplication |


<details open>
<summary markdown='span'>src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\CheckoutRestApi\CheckoutRestApiConfig;
use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface;
use Spryker\Glue\ShipmentsRestApi\Plugin\GlueApplication\ShipmentMethodsByCheckoutDataResourceRelationshipPlugin;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
    /**
     * @param \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface $resourceRelationshipCollection
     *
     * @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRelationshipCollectionInterface
     */
    protected function getResourceRelationshipPlugins(
        ResourceRelationshipCollectionInterface $resourceRelationshipCollection
    ): ResourceRelationshipCollectionInterface {
        $resourceRelationshipCollection->addRelationship(
            CheckoutRestApiConfig::RESOURCE_CHECKOUT_DATA,
            new ShipmentMethodsByCheckoutDataResourceRelationshipPlugin()
        );
        $resourceRelationshipCollection->addRelationship(
            OrdersRestApiConfig::RESOURCE_ORDERS,
            new OrderShipmentByOrderResourceRelationshipPlugin()
        );
        $resourceRelationshipCollection->addRelationship(
            ShipmentsRestApiConfig::RESOURCE_SHIPMENTS,
            new ShipmentMethodsByShipmentResourceRelationshipPlugin()
        );
        $resourceRelationshipCollection->addRelationship(
            CheckoutRestApiConfig::RESOURCE_CHECKOUT_DATA,
            new ShipmentsByCheckoutDataResourceRelationshipPlugin()
        );

        return $resourceRelationshipCollection;
    }
}
```
</details>

{% info_block warningBox "Verification" %}

* To make sure that `ShipmentMethodsByCheckoutDataResourceRelationshipPlugin` is activated, check that the information from the `shipment-methods` resource is returned by sending the `POST http://glue.mysprykershop.com/checkout-data?include=shipment-methods` request.
* To make sure that `OrderShipmentByOrderResourceRelationshipPlugin` is activated, make sure that the information from the `order-shipments` resource is returned by sending the `GET http://glue.mysprykershop.com/orders?include=order-shipments` request.
* To make sure that `ShipmentMethodsByShipmentResourceRelationshipPlugin` is activated, make sure that the information from the `shipment-methods` resource is returned by sending the `GET http://glue.http://mysprykershop.com /shipments?include=shipment-methods` request.
* To make sure that `ShipmentsByCheckoutDataResourceRelationshipPlugin` is activated, make sure that the information from the `shipments` resource is returned by sending the `POST http://glue.http://mysprykershop.com /checkout-data?include=shipments` request.

{% endinfo_block %}



###  Configure mapping

To map the data from requests to `QuoteTransfer`, configure the following mappers on the project level:

| PLUGIN  | SPECIFICATION  | PREREQUISITES | NAMESPACE   |
| ---------------------- | ---------------------- |---------- | ------------------------- |
| ShipmentQuoteMapperPlugin                      | Adds a mapper that maps shipment information to `QuoteTransfer`. |               | Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi |
| ShipmentRestOrderDetailsAttributesMapperPlugin | Maps the shipments from `OrderTransfer` to `RestOrderDetailsAttributesTransfer`. |               | Spryker\Glue\ShipmentsRestApi\Plugin\OrdersRestApi           |
| ShipmentsQuoteMapperPlugin                     | Maps the shipments from `RestCheckoutRequestAttributesTransfer` to `QuoteTransfer`. |               | Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi |


**src/Pyz/Zed/CheckoutRestApi/CheckoutRestApiDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\CheckoutRestApi;

use Spryker\Zed\CheckoutRestApi\CheckoutRestApiDependencyProvider as SprykerCheckoutRestApiDependencyProvider;
use Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi\ShipmentQuoteMapperPlugin;
use Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi\ShipmentsQuoteMapperPlugin;

class CheckoutRestApiDependencyProvider extends SprykerCheckoutRestApiDependencyProvider
{
    /**
     * @return \Spryker\Zed\CheckoutRestApiExtension\Dependency\Plugin\QuoteMapperPluginInterface[]
     */
    protected function getQuoteMapperPlugins(): array
    {
        return [
            new ShipmentQuoteMapperPlugin(),
            new ShipmentsQuoteMapperPlugin(),
        ];
    }
}
```


**src/Pyz/Glue/OrdersRestApi/OrdersRestApiDependencyProvider.php**

```php
<?php

namespace Pyz\Glue\OrdersRestApi;

use Spryker\Glue\OrdersRestApi\OrdersRestApiDependencyProvider as SprykerOrdersRestApiDependencyProvider;
use Spryker\Glue\ShipmentsRestApi\Plugin\OrdersRestApi\ShipmentRestOrderDetailsAttributesMapperPlugin;

class OrdersRestApiDependencyProvider extends SprykerOrdersRestApiDependencyProvider
{
    /**
     * @return \Spryker\Glue\OrdersRestApiExtension\Dependency\Plugin\RestOrderDetailsAttributesMapperPluginInterface[]
     */
    protected function getRestOrderDetailsAttributesMapperPlugins(): array
    {
        return [
            new ShipmentRestOrderDetailsAttributesMapperPlugin(),
        ];
    }
}
```


{% info_block warningBox "Verification" %}


* To make sure that `ShipmentQuoteMapperPlugin` is activated, send the `POST http://glue.mysprykershop.com/checkout` request and check that the order contains the shipment method you’ve provided in the request.
* To verify that `ShipmentQuoteMapperPlugin` is activated, send the `POST http://glue.mysprykershop.com/checkout?include=shipments` and check that the order contains the shipments you’ve provided in the request.
* To verify that `ShipmentRestOrderDetailsAttributesMapperPlugin` is activated, send the `GET http://glue.mysprykershop.com/orders?include=order-shipments` request and make sure that the order contains the shipments you’ve provided in the request.


{% endinfo_block %}

### Configure the shipment method validator plugin and selected shipment method mapper plugin

Activate the following plugin(s):


| PLUGIN   | SPECIFICATION    | PREREQUISITES | NAMESPACE   |
| ----------------- | ------------------------- | ---------- | -------------------- |
| SelectedShipmentMethodCheckoutDataResponseMapperPlugin | Maps the selected shipment method data to the `checkout-data`resource attributes. |               | Spryker\Glue\ShipmentsRestApi\Plugin\CheckoutRestApi         |
| ShipmentMethodCheckoutDataValidatorPlugin              | Validates shipment methods.                                  |               | Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi |


**src/Pyz/Glue/CheckoutRestApi/CheckoutRestApiDependencyProvider.php**

```php
<?php

namespace Pyz\Glue\CheckoutRestApi;

use Spryker\Glue\CheckoutRestApi\CheckoutRestApiDependencyProvider as SprykerCheckoutRestApiDependencyProvider;
use Spryker\Glue\ShipmentsRestApi\Plugin\CheckoutRestApi\SelectedShipmentMethodCheckoutDataResponseMapperPlugin;

class CheckoutRestApiDependencyProvider extends SprykerCheckoutRestApiDependencyProvider
{
	/**
     * @return \Spryker\Glue\CheckoutRestApiExtension\Dependency\Plugin\CheckoutDataResponseMapperPluginInterface[]
     */
    protected function getCheckoutDataResponseMapperPlugins(): array
    {
        return [
            new SelectedShipmentMethodCheckoutDataResponseMapperPlugin(),
        ];
    }
}
```


**src/Pyz/Zed/CheckoutRestApi/CheckoutRestApiDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\CheckoutRestApi;

use Spryker\Zed\CheckoutRestApi\CheckoutRestApiDependencyProvider as SprykerCheckoutRestApiDependencyProvider;
use \Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi\ShipmentMethodCheckoutDataValidatorPlugin;

class CheckoutRestApiDependencyProvider extends SprykerCheckoutRestApiDependencyProvider
{
    /**
     * @return \Spryker\Zed\CheckoutRestApiExtension\Dependency\Plugin\CheckoutDataValidatorPluginInterface[]
     */
    protected function getCheckoutDataValidatorPlugins(): array
    {
        return [
            new ShipmentMethodCheckoutDataValidatorPlugin(),
        ];
    }
}
```

{% info_block warningBox "Verification" %}

To make sure that `SelectedShipmentMethodCheckoutDataResponseMapperPlugin` is activated, send the `POST http://glue.mysprykershop.com/checkout-data` request endpoint with shipment a method id and check that, in the response, the `selectedShipmentMethods` is not empty:

**Response sample**

```json
{
	"data": 
	{
        "type": "checkout-data",
        "id": null,
        "attributes": {
            "addresses": [],
            "paymentProviders": [],
            "shipmentMethods": [],
            "selectedShipmentMethods": [
                {
                    "id": 1,
                    "name": "Standard",
                    "carrierName": "Spryker Dummy Shipment",
                    "price": 490,
                    "taxRate": null,
                    "deliveryTime": null,
                    "currencyIsoCode": "EUR"
                }
            ], 
            ...
		}
	}
}
```

{% endinfo_block %}

{% info_block warningBox "Verification" %}

To verify that `ShipmentMethodCheckoutDataValidatorPlugin` is activated, send the `POST http://glue.mysprykershop.com/checkout` request and check that you get the error saying that a shipment method is not found.

{% endinfo_block %}

### Configure the multi-shipment method validator and expander plugins

Activate the following plugins:

| PLUGIN  | SPECIFICATION  | PREREQUISITES | NAMESPACE     |
| ------------------- | --------------------------- | ------------ | -------------------- |
| AddressSourceCheckoutRequestValidatorPlugin | Validates the attributes of given shipments and returns an array of errors if necessary. |               | Spryker\Glue\ShipmentsRestApi\Plugin\CheckoutRestApi         |
| ShipmentDataCheckoutRequestValidatorPlugin  | Checks if `RestCheckoutRequestAttributesTransfer` provides shipment data per item or per order. |               | Spryker\Glue\ShipmentsRestApi\Plugin\CheckoutRestApi         |
| ItemsCheckoutDataValidatorPlugin            | Checks if `CheckoutDataTransfer` provides shipment data per item and per bundle item. |               | Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi |
| ItemsReadCheckoutDataValidatorPlugin        | Checks if `CheckoutDataTransfer` provides shipment data per item and bundle item. |               | Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi |
| ShipmentCheckoutDataExpanderPlugin          | Expands `RestCheckoutDataTransfer` with available shipment methods. |               | Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi |


**src/Pyz/Glue/CheckoutRestApi/CheckoutRestApiDependencyProvider.php**

```php
<?php

namespace Pyz\Glue\CheckoutRestApi;

use Spryker\Glue\CheckoutRestApi\CheckoutRestApiDependencyProvider as SprykerCheckoutRestApiDependencyProvider;
use Spryker\Glue\ShipmentsRestApi\Plugin\CheckoutRestApi\AddressSourceCheckoutRequestValidatorPlugin;
use Spryker\Glue\ShipmentsRestApi\Plugin\CheckoutRestApi\ShipmentDataCheckoutRequestValidatorPlugin;

class CheckoutRestApiDependencyProvider extends SprykerCheckoutRestApiDependencyProvider
{
    /**
     * @return \Spryker\Glue\CheckoutRestApiExtension\Dependency\Plugin\CheckoutRequestValidatorPluginInterface[]
     */
    protected function getCheckoutRequestValidatorPlugins(): array
    {
        return [
            new ShipmentDataCheckoutRequestValidatorPlugin(),
            new AddressSourceCheckoutRequestValidatorPlugin(),
        ];
    }
}
```


<details open>
<summary markdown='span'>src/Pyz/Zed/CheckoutRestApi/CheckoutRestApiDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\CheckoutRestApi;

use Spryker\Zed\CheckoutRestApi\CheckoutRestApiDependencyProvider as SprykerCheckoutRestApiDependencyProvider;
use Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi\ItemsCheckoutDataValidatorPlugin;
use Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi\ItemsReadCheckoutDataValidatorPlugin;
use Spryker\Zed\ShipmentsRestApi\Communication\Plugin\CheckoutRestApi\ShipmentCheckoutDataExpanderPlugin;

class CheckoutRestApiDependencyProvider extends SprykerCheckoutRestApiDependencyProvider
{
    /**
     * @return \Spryker\Zed\CheckoutRestApiExtension\Dependency\Plugin\CheckoutDataValidatorPluginInterface[]
     */
    protected function getCheckoutDataValidatorPlugins(): array
    {
        return [
            new ItemsCheckoutDataValidatorPlugin(),
        ];
    }

    /**
     * @return \Spryker\Zed\CheckoutRestApiExtension\Dependency\Plugin\ReadCheckoutDataValidatorPluginInterface[]
     */
    protected function getReadCheckoutDataValidatorPlugins(): array
    {
        return [
            new ItemsReadCheckoutDataValidatorPlugin(),
        ];
    }

    /**
     * @return \Spryker\Zed\CheckoutRestApiExtension\Dependency\Plugin\CheckoutDataExpanderPluginInterface[]
     */
    protected function getCheckoutDataExpanderPlugins(): array
    {
        return [
            new ShipmentCheckoutDataExpanderPlugin(),
        ];
    }
}
```
</details>



{% info_block warningBox "Verification" %}

To make sure that the plugins are activated, send the `POST http://glue.mysprykershop.com/checkout` request with invalid shipments and check that errors are returned.

{% endinfo_block %}




## Related features

Integrate the following related features.

| FEATURE      | REQUIRED FOR THE CURRENT FEATURE | INTEGRATION GUIDE       |
| ------- | -------------- | ------------------------- |
| Glue API: Checkout | ✓                                | [Glue API: Checkout feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-checkout-feature-integration.html) |

