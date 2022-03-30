---
title: Shop Guide - Address Step
description: Use the procedures to create a delivery address, and assign multiple delivery addresses to the order in the Storefront.
last_updated: Jan 16, 2020
template: howto-guide-template
originalLink: https://documentation.spryker.com/v4/docs/address-step-shop-guide-201911
originalArticleId: 255a84e0-c2f9-452b-9e01-ccca621c1762
redirect_from:
  - /v4/docs/address-step-shop-guide-201911
  - /v4/docs/en/address-step-shop-guide-201911
related:
  - title: Split Delivery Overview
    link: docs/scos/user/features/page.version/order-management-feature-overview/split-delivery-overview.html
---

The topic provides a list of steps to select billing and shipping addresses for the order.

{% info_block infoBox %}

You can proceed to the *Address* step as a:
- **registered user**: In the Login step, sign up by filling out the fields marked with * in the form and click **Register**.
- **guest**: In the Login step, fill in the fields marked with *, select the **Accept Terms** checkbox in the **Order as guest** form, and click **Submit**.
- **logged-in user**: Log in to your account on top of the page.

{% endinfo_block %}

***

To open the *Address* step, click **Checkout** in the corresponding shopping cart.

![Shopping cart checkout](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Checkout/Shop+Guide+-+Address+Step/checkout-btn.png)

Here you can do the following:

* Create a new delivery address
* Use an existing delivery address
* Assign multiple delivery addresses to the items

***

## Creating a New Delivery Address

To create a new delivery address:

{% info_block infoBox %}

If there are no pre-saved addresses, the **Define new address** option is displayed in the drop-down menu by default.

{% endinfo_block %}

1. On the **Address** page, select the **Define new address** option from the drop-down menu.
![Create a new address](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Checkout/Shop+Guide+-+Address+Step/define-new-address.png)

2. Fill in all the required information.
3. To proceed to the *Shipment* step, click **Next**.

**Tips and tricks**

The **Save new address to address book** and **Billing same as shipping** options are enabled by default:

* If you want to use a different billing address, clear the checkbox for **Billing same as shipping** and use the existing one or add a new address.
* If you don't want to save a new address, clear the checkbox for **Save new address to address book**. If you decide to add the new address to your contacts, it will appear only after you complete the order.
***

## Use Existing Delivery Address

To use one of the addresses you created before:

1. On the **Address** page, select the necessary address from the drop-down menu. You can select among *Customer Addresses* or *Business Addresses*.

![Existing addresses](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Checkout/Shop+Guide+-+Address+Step/select-existing-address.png)

2. In the *Billing Address* section, select an existing billing address or create a new one.
3. To proceed to the *Shipment* step, click **Next**.

**Tips and tricks**

The **Billing same as shipping** option is enabled by default:

* If you want to use a different billing address, clear the checkbox for **Billing same as shipping** and use the existing one or add a new address.
***
## Assign Multiple Delivery Addresses to Order

To assign several addresses to the same order:

1. On the **Address** page, select the **Deliver to multiple addresses** option from the drop-down menu.
![Deliver to multiple addresses](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Checkout/Shop+Guide+-+Address+Step/deliver-to-multiple-addresses-new.png)

{% info_block infoBox %}

Clicking **Manage your addresses** will redirect you to the *Addresses* section in **Customer Account**. There you can add a new address, view, edit, or delete existing ones.

{% endinfo_block %}

2. In the **Select a delivery address** drop-down menu, select one of the following options for each item:
    * **Define new addresses** if you want to assign a new address to the item. This will open the form where you need to populate the fields with the necessary information.

    * Existing address for the item


{% info_block warningBox %}

If there are no saved addresses, the **Define new address** option will be displayed by default in the **Select a delivery address** drop-down menu.

{% endinfo_block %}

3. In the *Billing Address* section, select the necessary address or add a new one.
4. To proceed to the *Payment* step, click **Next**.

***

**What's next?**

The delivery addresses are added to your items. Now, you need to select shipment methods for each delivery address.

To learn more on how to select a shipment method, see [Shop Guide - Shipment Step](/docs/scos/user/shop-user-guides/{{page.version}}/shop-guide-checkout/shop-guide-shipment-step.html).