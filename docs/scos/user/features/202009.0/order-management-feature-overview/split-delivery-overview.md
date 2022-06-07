---
title: Split Delivery overview
search: exclude
description: The feature allows delivering order items to different shipping addresses and on different days, with different shipment methods.
last_updated: Jun 13, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/v6/docs/split-delivery-overview
originalArticleId: 5b01114f-0b85-4262-8498-1b0370925e2f
redirect_from:
  - /v6/docs/split-delivery-overview
  - /v6/docs/en/split-delivery-overview
---

*Split Delivery* enables the same order as *shipments* to multiple delivery addresses and/or on different dates, and/or with different shipment methods. A *shipment* is a set of two or more products combined by the same delivery address.

Each shipment defines:

* Delivery address
* Shipment method
* Delivery date requested from a customer

In the Storefront, Split Delivery allows you, as a customer, to set different delivery addresses for the order items, specify the date when you want the items to be delivered and select shipment methods per each shipment.

In the Back Office, the Split Delivery allows you, as a Back Office user, to view, update and/or create multiple shipments for an order that had originally one delivery address.
The following scheme illustrates relations between **Shipment**, **ShipmentGui**, and **Sales** modules:

![Module relations](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Order+Management/Split+Delivery/split-delivery-module-relations.png)

## Split Delivery on the Storefront

{% info_block warningBox %}
Keep in mind that Split Delivery works *only* if there are several product items in one order.
{% endinfo_block %}

In the *Address* checkout step, the **Define to multiple addresses** drop-down option allows you to assign a delivery address per cart item.

Then, in the *Shipment* checkout step, you can see the products grouped by the same delivery address. The number of shipments equals the number of the same delivery addresses. For each shipment, you can select a delivery date (optional) and a shipment method.

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Checkout/Shop+Guide+-+Summary+Step/summary-step-new.png)

See [Shop Guide - Address](/docs/scos/user/features/{{page.version}}/checkout-feature-overview/multi-step-checkout-overview.html) for more details on how to add multiple delivery addresses to order items in the Storefront.

## Split Delivery in the Back Office
In the Back Office, the shipments are displayed in the *Order Items* section on the **View Order: [Order ID]** page.

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Order+Management/Split+Delivery/Split+Delivery+Feature+Overview/shipments-zed.png)

Here you can perform the following actions on shipments:

* Create a new shipment for the whole order
* Modify a delivery address, a shipment method (without any impact on order totals), and a delivery date
* Move items between shipments
* Change the state of each item or all items per shipment

See [Orders](/docs/scos/user/back-office-user-guides/{{page.version}}/sales/orders/managing-orders.html) for more details on how to create and manage shipments in the Back Office.

## Constraints
### Gift Card compatibility
Currently, the Split Delivery is not compatible with the Gift Cards feature. If you want to buy a Gift card, only *one* delivery address can be selected for the whole order. 

### Limitation for payment service providers
Most of payment service providers (PSP) support a single delivery address for a given order, while Split Delivery enables your customers to add multiple shipments to the same order. In this case, you need to modify the configuration of the online store to allow your customers to deliver order items to different addresses. See [HowTo - Disable Split Delivery in Yves Interface](/docs/scos/dev/tutorials-and-howtos/howtos/feature-howtos/howto-disable-split-delivery-in-yves-interface.html) for information on how to do that.

<!--
### Product Bundles
With Split Delivery, Product Bundles items can be shipped to different delivery addresses. However, if a product bundle is a part of the order and you don't want it to be split and delivered to different delivery addresses, you need to configure the implementation of the Checkout process on your project level.
-->

