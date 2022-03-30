---
title: "Reference information: Shipment method plugins"
description: An optional plugin is linked to each shipping method. This topic provides an overview of the Availability, Price Calculation, and Delivery Time plugins.
last_updated: Dec 21, 2019
template: feature-walkthrough-template
originalLink: https://documentation.spryker.com/v4/docs/shipment-method-plugins
originalArticleId: c0330136-c94a-43ed-bcfc-a6d28a7414b8
redirect_from:
  - /v4/docs/shipment-method-plugins
  - /v4/docs/en/shipment-method-plugins
related:
  - title: Migration Guide - Shipment
    link: docs/scos/dev/module-migration-guides/migration-guide-shipment.html
---

The main concerns regarding shipping services are :

* **Availability**: Is the shipping method available to deliver the order?
* **Price**: How is the delivery price calculated ?
* **Delivery time**: When will the order be delivered ?

For each of these concerns, an optional plugin is linked to each shipping method :

* **Availability Plugin**: Returns a boolean value which implies if the active shipping method is available and should be visible to the customers in the list of available shipping services.
* **Price Calculation Plugin**: Shipping services can consider different criteria in calculating the price for delivery (such as size of the package, weight, etc.). When a price plugin is paired to a shipping method, the related Zed Admin UI preconfigured prices are omitted.
* **Delivery Time Plugin**: The estimated delivery time information of the purchased items is important for the customers. The delivery time can vary depending on region, shipping service type, or day of week. Delivery time is measured in seconds as integer (for example,1 day = 86400; 5 days = 5 * 86400).

## Availability Plugin

For each availability plugin linked to a shipment method, a class with the same name must exist on the project side in the Shipment module (`Pyz/Zed/Shipment/Communication/Plugin/Availability`).

The class must implement `ShipmentMethodAvailabilityPluginInterface` and must extend the `AbstractPlugin` class, as in the example below :

```php
<?php
namespace Pyz\Zed\Shipment\Communication\Plugin\Availability;
use Generated\Shared\Transfer\QuoteTransfer;
use Generated\Shared\Transfer\ShipmentGroupTransfer;
use Spryker\Zed\Kernel\Communication\AbstractPlugin;
use Spryker\Zed\ShipmentExtension\Dependency\Plugin\ShipmentMethodAvailabilityPluginInterface;
class DHLExpressPlugin extends AbstractPlugin implements ShipmentMethodAvailabilityPluginInterface
{
    /**
     * Specification:
     *  - Checks shipment method availability for shipment group.
     *
     * @api
     *
     * @param \Generated\Shared\Transfer\ShipmentGroupTransfer $shipmentGroupTransfer
     * @param \Generated\Shared\Transfer\QuoteTransfer $quoteTransfer
     *
     * @return bool
     */
    public function isAvailable(ShipmentGroupTransfer $shipmentGroupTransfer, QuoteTransfer $quoteTransfer): bool
    {
        return true;
    }
}
```

## Price Calculation Plugin

For each price calculation plugin linked to a shipment method, a class with the same name must exist on the project side in the Shipment module  (`Pyz/Zed/Shipment/Communication/Plugin/PriceCalculation`). The class must implement `ShipmentMethodPricePluginInterface` and must extend the `AbstractPlugin` class, as in the example below :

```php
<?php
namespace Pyz\Zed\Shipment\Communication\Plugin\PriceCalculation;
use Generated\Shared\Transfer\QuoteTransfer;
use Generated\Shared\Transfer\ShipmentGroupTransfer;
use Spryker\Zed\Kernel\Communication\AbstractPlugin;
use Spryker\Zed\ShipmentExtension\Dependency\Plugin\ShipmentMethodPricePluginInterface;
class DHLExpressPlugin extends AbstractPlugin implements ShipmentMethodPricePluginInterface
{
    /**
     * Specification:
     *  - Returns shipment method price for shipment group.
     *
     * @api
     *
     * @param \Generated\Shared\Transfer\ShipmentGroupTransfer $shipmentGroupTransfer
     * @param \Generated\Shared\Transfer\QuoteTransfer $quoteTransfer
     *
     * @return int
     */
    public function getPrice(ShipmentGroupTransfer $shipmentGroupTransfer, QuoteTransfer $quoteTransfer): int
    {
        return 0;
    }
}
```

## Delivery Time Plugin

For each availability plugin linked to a shipment method, a class with the same name must exist on the project side in the Shipment module (`Pyz/Zed/Shipment/Communication/Plugin/DeliveryTime`). The class must implement `ShipmentMethodDeliveryTimePluginInterface` and must extend the `AbstractPlugin` class, as in the example below :

```php
<?php
namespace Pyz\Zed\Shipment\Communication\Plugin\DeliveryTime;
use Generated\Shared\Transfer\QuoteTransfer;
use Generated\Shared\Transfer\ShipmentGroupTransfer;
use Spryker\Zed\Kernel\Communication\AbstractPlugin;
use Spryker\Zed\ShipmentExtension\Dependency\Plugin\ShipmentMethodDeliveryTimePluginInterface;
class DHLExpressPlugin extends AbstractPlugin implements ShipmentMethodDeliveryTimePluginInterface
{
    /**
     * Specification:
     *  - Returns delivery time for shipment group.
     *
     * @param \Generated\Shared\Transfer\ShipmentGroupTransfer $shipmentGroupTransfer
     * @param \Generated\Shared\Transfer\QuoteTransfer $quoteTransfer
     *
     * @return int
     * @api
     *
     */
    public function getTime(ShipmentGroupTransfer $shipmentGroupTransfer, QuoteTransfer $quoteTransfer): int
    {
        return 0;
    }
}
```

## Plugin Registration

The plugins must be registered in the `ShipmentDependencyProvider`, by overriding the following 3 operations :

```php
<?php
/**
 * @param Container $container
 *
 * @return array
 */
protected function getAvailabilityPlugins(Container $container)
{
    return [
        'Plugin name visible in form' => new YourAvailabilityPlugin(),
    ];
}

/**
 * @param Container $container
 *
 * @return array
 */
protected function getPricePlugins(Container $container)
{
    return [
        'Plugin name visible in form' => new YourPricePlugin(),
    ];
}

/**
 * @param Container $container
 *
 * @return array
 */
protected function getDeliveryTimePlugins(Container $container)
{
    return [
        'Plugin name visible in form' => new YourDeliveryTimePlugin(),
    ];
}
```

We value people who contribute to improvement of our documentation:

* Thank you to: [Eugen Mielke](https://github.com/eug3n) for taking the time to provide us with your feedback (August 2018).

{% info_block warningBox %}
You too can be credited in our documentation by stating that you wish to be mentioned when you send us feedback. Click "Edit on Github" (top right
{% endinfo_block %} to send feedback for this page.)
