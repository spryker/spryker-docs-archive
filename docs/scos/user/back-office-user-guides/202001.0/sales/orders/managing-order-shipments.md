---
title: Managing Order Shipments
description: The guide provides steps on how to view and update delivery address, shipment method and delivery dates for the shipment, create a shipment in the Back Office.
last_updated: Nov 22, 2019
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v4/docs/managing-order-shipments
originalArticleId: 8d66abb2-f37e-49fc-b4f2-3ec26ebffd9c
redirect_from:
  - /v4/docs/managing-order-shipments
  - /v4/docs/en/managing-order-shipments
related:
  - title: Managing Orders
    link: docs/scos/user/back-office-user-guides/page.version/sales/orders/managing-orders.html
  - title: Orders- Reference Information
    link: docs/scos/user/back-office-user-guides/page.version/sales/orders/references/orders-reference-information.html
  - title: Split Delivery Overview
    link: docs/scos/user/features/page.version/order-management-feature-overview/split-delivery-overview.html
---

This topic describes the managing actions you can perform on shipments.
***

To start working with order shipments, navigate to the **Sales > Orders** section and click **View** for a specific order in the *Actions* column. The **View Order: [Order ID]** page opens. On the page, scroll down to the *Order Items* section.
***

You can manage order shipments by:
* Viewing and updating a delivery address, shipment method, and delivery date for each shipment
* Viewing product item information included in the shipment
* Setting statuses for each item in the shipment
* Creating a new shipment out of the existing ones
* Moving items between shipments

## Creating a New Shipment for Order

To create a new shipment for the order:
1. Scroll down to the *Order Items* section and click **Create Shipment**.

![Create shipment button](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Back+Office+User+Guides/Sales/Managing+Order+Shipments/create-shipment-btn.png)

2. On the **New Shipment for Order** page, populate the required fields marked with *.
3. In the *Order items inside this shipment* section, select the order items you want to be delivered in this shipment.
4. To keep the changes, click **Save**. This will take you to the **View Order: [Order ID]** page where you can see the new order shipment.

**Tips and tricks**

Clicking **Back to Order** in the top right corner of the page prior to saving the changes will discard all the changes and take you to the **View Order: [Order ID]** page.

## Editing Shipment Details

To edit shipment details:
1. Scroll down to the *Order Items* section and click **Edit Shipment** for the necessary shipment.
2. On the **Edit Shipment for Order: [Shipment Sequence Number]** page, you can:
    * Edit a delivery address and a shipment method (without any impact on the order totals). To do this, click a respective field and select the shipment item from the drop-down menu.
    * Define a delivery date. To do this, click the **Respective delivery date** field and select the date you want your shipment to be delivered.
    * Move items from the other order shipments to the current one. To do this, scroll down to the *Order items inside this shipment* section and select the checkbox for the necessary order item. By default, order items included in the current shipment are disabled.

    {% info_block warningBox %}

    The shipment is automatically deleted if it doesn't contain any items.

    {% endinfo_block %}

3. Once done, click **Save** to keep the changes. This will take you to the **View Order: [Order ID]** page with the following message: '*Shipment has been successfully edited'*.

**Tips and tricks**
Clicking **Back to Order** in the top right corner of the page can trigger different actions:
* Selecting this option prior to saving the changes will discard all the changes and then take you to the *List of Orders* page.
* Selecting this option after the changes have been saved will redirect you to the *List of Orders* page.

## Viewing Status History for an Order Item

To view an order item status history:
1. Scroll down to the *Order Items* section.
2. In the *Shipment # > State* column, click **Show history** for the specific item whose shipment history you want to view. This will shop up the order statuses along with the dates the order item has been processed.
3. To hide this information, click **Hide history**.
 
<!-- Last review date: Sep 24, 2019 by Yuliia Boiko-->
