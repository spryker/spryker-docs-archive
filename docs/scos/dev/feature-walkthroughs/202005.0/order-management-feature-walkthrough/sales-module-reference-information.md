---
title: Sales module- reference information
description: The module provides order management functionality obtained through the ZED UI that renders orders with details and the Client API to get customer orders
last_updated: Apr 3, 2020
template: feature-walkthrough-template
originalLink: https://documentation.spryker.com/v5/docs/sales
originalArticleId: 7985e95a-f58b-4c1a-af9b-86cfaee4617d
redirect_from:
  - /v5/docs/sales
  - /v5/docs/en/sales
  - /v5/docs/sales-5-0
  - /v5/docs/en/sales-5-0
---

The Sales module provides the order management functionality. The functionality is obtained through the ZED UI that renders orders with orders details and the Client API to get customer orders.

## Getting Totals for Order
To get the Order with totals, the facade method SalesFacade::getOrderByIdSalesOrder() creates an order level which returns the OrderTransfer with a hydrated grandTotal, subtotal, expense, discounts and more

{% info_block warningBox %}
This is an improvement from the Sales 5.0 version where you had to use `SalesAggregatorFacade` to get totalks. This version has been deprecated.
{% endinfo_block %}

## Persisting Order Calculated Values
All calculated values are persisted now, when order are first placed. The values are stored by orderSaver plugins from checkout bundle. Check `\Pyz\Zed\Checkout\CheckoutDependencyProvider::getCheckoutOrderSavers` for currently available plugins.

Some values can change during time when order refunded or partially refunded. Then `canceled_amount` and `refundable_amount` are recalculated and new values is persisted. At the same moment totals also change, but it does not overwrite old entry, but creates new row in `spy_sales_order_total` with this you have a history of order totals from the time order was placed.

The following ER diagram shows persisted calculated values:
![ER diagram](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Order+Management/Sales/sales_persisting_order_values.png)

## Extension Points
HydrateOrderPluginInterface - its an action which happens when `SalesFacade::getOrderByIdSalesOrder()` method is called. This means that you may want to enrich you `OrderTransfer` with additional data. This plugins accepts passes `OrderTransfer` for additional population.

There are already few plugins provided:

* `DiscountOrderHydratePlugin` - hydrates `OrderTransfer` with discount related data as it was stored when order is placed.
* `ProductOptionOrderHydratePlugin` - hydrates `OrderTransfer` with product option related data.
* `ProductBundleOrderHydratePlugin` - hydrates `OrderTransfer` with product bundle related data.
* `ShipmentOrderHydratePlugin` - hydrates `OrderTransfer` with shipment related data.


