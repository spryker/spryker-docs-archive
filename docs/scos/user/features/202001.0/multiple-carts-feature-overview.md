---
title: Multiple Carts feature overview
description: Shopping Cart is where the record of the items a buyer has ‘picked up’ from the online store is kept. Select products, review them and add more with ease.
last_updated: Nov 22, 2019
template: concept-topic-template
originalLink: https://documentation.spryker.com/v4/docs/multiple-carts-per-user-overview
originalArticleId: 2e9a5665-1d92-4e5d-8a6d-5f3152a34107
redirect_from:
  - /v4/docs/multiple-carts-per-user-overview
  - /v4/docs/en/multiple-carts-per-user-overview
  - /v4/docs/multiple-cart-per-user
  - /v4/docs/en/multiple-cart-per-user
---

Shopping Cart is a part of the online shop where the record of the items a buyer has ‘picked up’ from the online store is kept. The shopping cart enables consumers to select products, review what they selected, make modifications or add extra items if needed, and purchase the products.

## Creating and Managing Multiple Shopping Carts
There are two ways to create a shopping cart:

* through a shopping cart widget in the header of shop
* from Shopping Cart page in *My Account* menu

New items are added to the shopping cart by clicking **Add to Cart** on the product details page.

Customers can create not just one, but multiple shopping carts to be used for different needs.

{% info_block infoBox %}
These could be, for instance, a shopping cart for daily purchases or a shopping cart for goods that you purchase once in a month.
{% endinfo_block %}

After a shopping cart has been created, it appears in the shopping carts table on _Shopping Cart_ page in _My Account_.

The table with shopping carts shows details for each of the carts, including:

* Name of the shopping cart
* Access level (Owner, Read-only or Full access)
* Number of products added to cart
* Price mode (Net or Gross)
* Cart Total
* Possible actions to manage shopping carts: edit name, duplicate, [share](/docs/scos/user/features/{{page.version}}/shared-carts-feature-overview.html), delete, switch cart to shopping list (see the *Actions* table for details)

![Multiple carts list](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Shopping+Cart/Cart/Multiple+Carts+per+User+Feature+Overview/multiple-cart-list.png) 

The table bellow provides detailed information on the possible actions to manage shopping carts.

| Action | Description |
| --- | --- |
| Edit Name | Allows a customer to edit the name of the shopping cart. |
| Duplicate | Creates a copy of the chosen shopping cart including the items added to the cart.<br>The duplicate copy of the cart is named according to the template: `<Name of the original cart> Copied At <Mo. dd, yyyy hh:mm>` <br>A cart can be converted into shopping list on Shopping cart page by clicking on **To shopping list**.|
| Delete | Deletes the shopping cart. <br>Deleting a shopping cart also deletes the items added to it. |

To learn more about sharing the shopping cart, check out [Shared Cart documentation](/docs/scos/user/features/{{page.version}}/shared-carts-feature-overview.html).

Active shopping cart is highlighted in bold.

{% info_block infoBox %}
Only one shopping cart can be set as active in the customer account.
{% endinfo_block %}

There are 2 ways to set a shopping cart as active:

* clicking on the cart name in the shopping cart widget in the header of the shop
* clicking on the cart name in the Shopping Cart page in My Account menu

After the shopping cart is set to active, the user is redirected to a respective cart page where the table with the following information is available:

* Product image
* Product name
* SKU
* Product attributes
* Product options
* Quantity
* Note
* Price mode
* Item price
* Cat Note
* Discount
* Subtotal
* Tax
* Grand Total

![Shopping Cart Page](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Shopping+Cart/Cart/Multiple+Carts+per+User+Feature+Overview/a-shopping-cart-page.png) 


<!--**See also:**

* Learn about MultiCart module
* Learn about MultiCartDataImport module
-->

<!-- Last review date: Oct 29, 2018 -- by Andrew Chekanov -->
