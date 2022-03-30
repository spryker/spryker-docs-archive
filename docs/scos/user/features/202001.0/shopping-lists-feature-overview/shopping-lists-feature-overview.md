---
title: Shopping Lists feature overview
description: A general overview of the Multiple and shared shopping lists feature.
last_updated: Aug 13, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v4/docs/multiple-shared-shopping-lists-overview
originalArticleId: 6f285ce8-0da1-43d1-91a1-886d2e364d06
redirect_from:
  - /v4/docs/multiple-shared-shopping-lists-overview
  - /v4/docs/en/multiple-shared-shopping-lists-overview
  - /v4/docs/multiple-shared-shopping-lists
  - /v4/docs/en/multiple-shared-shopping-lists
  - /v4/docs/shopping-list
  - /v4/docs/en/shopping-list
---

A shopping list is a list of the items that shoppers buy or plan to buy frequently or regularly. For example, a consumer can compile a shopping list of the products they purchase every week. Shopping lists allow a buyer to have a quick overview of the products they are planning to buy and the sum of money they are going to spend.

A shopping list is always saved, disregarding if a company user logs out and logs in again—the list is still available. The shopping list does not reserve products on stock, so adding an item to the shopping list does not affect item availability. However, a company user can easily convert any shopping list into a shopping cart to proceed with the Checkout.
There are two ways to create a shopping list:

* Through a [shopping list widget](/docs/scos/user/features/{{page.version}}/shopping-lists-feature-overview/shopping-list-widget-overview.html) in the header of the shop.
* From the *Shopping Lists* page in the *My Account* menu. See [Multiple and Shared Shopping Lists on the Storefront](#multiple-and-shared-shopping-lists-on-the-storefront) for more detailed instruction.

New items are added to shopping lists by clicking **Add to Shopping List** on the product details page.

Company users can create not just one but multiple shopping lists to be used for different needs or to purchase products at different periods.

{% info_block infoBox "Example" %}

For instance, these could be separate shopping lists for daily, weekly, and monthly purchases.

{% endinfo_block %}

The detailed information on managing shopping lists is represented in the [Multiple and Shared Shopping Lists overview](#multiple-and-shared-shopping-lists-on-the-storefront) section.

## Permissions management for shared shopping lists

Users of companies with business units can **share** their shopping lists within the company business units. The shopping lists can either be shared with the entire business unit or its members. Company users can view shopping lists shared with them on the *My Account* -> *Shopping lists* page. The shopping lists can be shared by clicking **Share** on this page as well. The *Share [SHOPPING LIST NAME]* page consists of two sections: *Business Units* and *Users*. Here, the shopping list owner can select either the entire business unit or individual users to share the shopping list with.
To view how to share shopping lists with business units or its members, see the [Multiple and Shared Shopping Lists on the Storefront](#multiple-and-shared-shopping-lists-on-the-storefront) section.

Three types of shopping list access rights can be granted:

* No access
* Read only
* Full access

### No access

**No access** means that a shopping list is not shared and therefore can not be seen by a business unit/user.

### Read only

**_Read only_** permissions allows:

1. **Reading Shopping list**: On the *Shopping List View* page, the user sees a shopping list name, owner, access level (*Read only*), number of users the shopping list is shared with, as well as the table of items with the following information:

* Product image
* Product name
* SKU
* Product attribute
* Product options
* Product comments (see [Shopping List Notes overview](/docs/scos/user/features/{{page.version}}/shopping-lists-feature-overview/shopping-list-notes-overview.html) for more details)
* Quantity
* Item price
* Availability
* Actions: The **Add to Cart** button

{% info_block infoBox %}

Alternative products are not shown for discontinued products since they can not be basically added to the cart, and a user with *Read only* rights can not amend the shopping list by adding these products to it.

{% endinfo_block %}


2. **Changing quantity of items for adding to cart**: On the *Shopping List View* page, a user can change the item quantity to be added to cart.

3. **Printing a shopping list**: A user can print a shopping list from the *My Account*→*Shopping Lists* or page or from the *Shopping List View* page. For details, see [Multiple and Shared Shopping Lists on the Storefront ](#multiple-and-shared-shopping-lists-on-the-storefront).

4. **Adding shopping list items to cart**: A user can select the necessary which are available and add them to cart.

## Full access

**_Full access_** permissions allow:

1. Reading a shopping list: On the _Shopping List View_ page, the user sees the name of owner, access level (Full access), the number of users the shopping list is shared with, as well as the table of items with the following information:
   * Product image
   * Product name
   * SKU
   * Product attribute
   * Product options
   * Product notes (see [Shopping List Notes overview](/docs/scos/user/features/{{page.version}}/shopping-lists-feature-overview/shopping-list-notes-overview.html) for more details)
   * Quantity
   * Item price
   * Availability
   * Actions: **Add to cart** icon, **Remove** button

{% info_block infoBox %}

Besides other products, a user with *Full access* rights is allowed to see alternatives for discontinued items, which can be added to the shopping list.

{% endinfo_block %}

2. **Changing the number of items for adding to cart**: On the *Shopping List View* page, the user can change the item quantity to be added to the cart.

3. **Printing a shopping list**: A user can print a shopping list from the *My Account*→*Shopping Lists* or page or from the *Shopping List View* page. For details, see [Multiple and Shared Shopping Lists on the Storefront ](#multiple-and-shared-shopping-lists-on-the-storefront).

4. **Editing a shopping list**: Having clicked **Edit**, the user is taken to the *Edit Shopping list* page.

5. **Changing quantity for a shopping list**: The number of items in the shopping list can be changed on the *Edit Shopping list* page.

6. **Sharing a shopping list**: A shopping list can be shared by clicking the **Share** button or the **Shared with** link.

7. **Deleting a shopping list**

8. **Deleting items in a shopping list**: The shopping list items can be deleted on the **Edit Shopping list** page.
![Shared full access](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Shopping+List/Multiple+and+Shared+Shopping+Lists/Multiple+and+Shared+Shopping+Lists+Overview+v201907.0/shared-full-access.png)

It is possible to grant different access rights on a shopping list to a business unit and users belonging to it. For example, a shopping list can be shared with *Read only* permissions to a business unit, but some of its users might be granted *Full access* permissions. In this case, these users will have *Full access* to the shopping list, whereas the rest of the business unit members will be entitled to *Read only* access.

## Search widget for shopping lists

Starting from v. 2019.03.0, it is possible to integrate the [Search Widget for Concrete Products](/docs/scos/user/features/{{page.version}}/product-feature-overview/search-widget-for-concrete-products-overview.html) feature. The search widget allows adding the products to the shopping list directly from the shopping list page. The shoppers do not need to go to product detail pages to add products to a list anymore.
{% info_block warningBox %}
Without the Search widget, you will not be able to search for products. Therefore, make sure that the Search Widget for Concrete Products feature is integrated into your project.
{% endinfo_block %}
![Search widget](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Shopping+List/Multiple+and+Shared+Shopping+Lists/Multiple+and+Shared+Shopping+Lists+Overview+v201907.0/shopping-list-search-widget.png)

## Subtotal for a shopping list

Starting from v.201907.0, every shopping list has Subtotal for all the items added to the shopping list according to the selected Price Mode and Currency.
![Subtotal for shopping list](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Shopping+List/Multiple+and+Shared+Shopping+Lists/Multiple+and+Shared+Shopping+Lists+Overview+v201907.0/subtotal-for-shopping-list.png)


## Multiple and Shared Shopping Lists on the Storefront

<a name="multiple-and-shared-shopping-lists-on-the-storefront"></a> Company users can perform the following actions using the Multiple and Shared Shopping Lists feature on the Storefront:

<details>
<summary markdown='span'>Create, delete, and add a shopping list to cart</summary>

![create-delete-and-add-shopping-lists-to-cart](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Shopping+List/Multiple+and+Shared+Shopping+Lists/Multiple+and+Shared+Shopping+Lists+Overview/create-delete-add-to-cart-shopping-lists.gif)

</details>

<details>

<summary markdown='span'>Edit shopping lists</summary>

![edit-shopping-lists](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Shopping+List/Multiple+and+Shared+Shopping+Lists/Multiple+and+Shared+Shopping+Lists+Overview/manage-shopping-lists.gif)

</details>

<details>

<summary markdown='span'>Add products from the product details page to a shopping list</summary>

![add-products-from-the-product-detail-page](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Shopping+List/Multiple+and+Shared+Shopping+Lists/Multiple+and+Shared+Shopping+Lists+Overview/add-products-from-the-product-detail-page.gif)

</details>


<details>

<summary markdown='span'>Dissmiss a shared shopping list, share and print a shopping list</summary>

![dismiss-share-and-print-a-shopping-list](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Shopping+List/Multiple+and+Shared+Shopping+Lists/Multiple+and+Shared+Shopping+Lists+Overview/dismiss-share-and-print-a-shopping-list.gif)

</details>


## Video tutorial

Check out this video tutorial on how to use shopping lists.

{% wistia zk32pr3lgt 960 720 %}

## Current constraints

We do not support product options in Subtotal of the Shopping Lists. For example, a shopping list includes 3 office chairs, each of them cost €15. The subtotal will show €45 for 3 items. But if we add a product option, e.g., gift wrapping for €5 each to these three office chairs, the subtotal should display €60 (€15/chair + €5/gift wrapping * 3). However, the shopping list will display just the product price - €45.

## Related Business User articles

|BACK OFFICE USER GUIDES|
|---|
| [Get a general idea of the shopping list widget](/docs/scos/user/features/{{page.version}}/shopping-lists-feature-overview/shopping-list-widget-overview.html)  |
| [Get a general idea of Shopping List Notes](/docs/scos/user/features/{{page.version}}/shopping-lists-feature-overview/shopping-list-notes-overview.html)  |

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Shopping Lists feature walkthrough](/docs/scos/dev/feature-walkthroughs/{{page.version}}/shopping-lists-feature-walkthrough.html) for developers.

{% endinfo_block %}
