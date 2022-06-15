---
title: Managing product lists
search: exclude
description: Use these procedures to edit, export, remove a product list or remove products from the product list in the Back Office.
last_updated: Mar 10, 2021
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v6/docs/managing-product-lists
originalArticleId: 1e4baffd-17e3-4662-86bd-42ae0a02a2f7
redirect_from:
  - /v6/docs/managing-product-lists
  - /v6/docs/en/managing-product-lists
---

This article describes how to manage product lists.

To start managing product lists, go to **Catalog** > **Product Lists**.
***
## Editing a product list
To edit a product list:

1. Select **Edit List** next to the product list you want to edit.
2. On the *Edit Product List: {product list ID}* page:
    * Change general information, such as **Title** and **Type**.
    * [Assign categories to the list](#assigning-categories-to-a-product-list).
    * [Deassign categories from the list](#deassigning-categories-from-a-product-list).
    * [Assign products to the list](#assigning-products-to-a-product-list).
    * [Deassign products from the list](#deassigning-categories-from-a-product-list).
3. Select **Save**.
    The page refreshes with the success message displayed.

{% info_block warningBox "Blacklist" %}

If a product list is used by a [configurable bundle](/docs/scos/user/features/{{page.version}}/configurable-bundle-feature-overview.html) and its type is changed to **Blacklist**, it stops being displayed for the [configurable bundle slot](/docs/scos/user/features/{{page.version}}/configurable-bundle-feature-overview.html#configurable-bundle-slot) on the Storefront. To check if a product list is used by a configurable bundle, on the *Edit Product List: {product list ID}*  page, switch to the **Used by** tab.

{% endinfo_block %}


## Assigning categories to a product list

To assign categories to a product list:
1. Select **Edit List** next to the product list you want to assign categories to.
2. On the *Edit Product List: {product list ID}*  page, switch to the **Assign Categories** tab.
3. In the **Categories** field, start typing the name of a category to see the list of matching results. Select the desired category.
4. Repeat the previous step until you assign all the desired categories.
5. Select **Save**.
    The page refreshes with the success message displayed.

## Deassigning categories from a product list

To assign categories to a product list:
1. Select **Edit List** next to the product list you want to deassign categories from.
2. On the *Edit Product List: {product list ID}*  page, switch to the **Assign Categories** tab.
3. In the **Categories** field, select **X** prior to the category you want to deassign.
4. Repeat the previous step until you deassign all the desired categories.
5. Select **Save**.
    The page refreshes with the success message displayed.

## Assigning products to a product list
To assign products to a product list:
1. Select **Edit List** next to the product list you want to assign products to.
2. On the *Edit Product List: {product list ID}*  page, switch to the **Assign Products** tab.
3. Assign products in one of the following ways:
    *  Import a product list:
        1. Select **Choose File**.
        2. Select the product list file to be uploaded.
            The file should contain the `product_list_key` and `concrete_sku` fields.

    *  Assign products to the list manually: In the *Selected* column of the *Select Products to assign* table, select the products to assign to the list.
 5. Select **Save**.
    The page refreshes with the success message displayed.

**Tips and tricks**
* To double-check the list of products that are to be assigned, switch to the **Products to be assigned** tab.



## Deassigning products from a product list
To deassign products from a product list:
1. Select **Edit List** next to the product list you want to deassign products from.
2. On the *Edit Product List: {product list ID}*  page, switch to the **Assign Products** tab.
3. In the *Selected* column of the *Products in this list* table, select the products to deassign from the list.
4. Select **Save**.
    The page refreshes with the success message displayed.

**Tips and tricks**
* To double-check the list of products that are to be deassigned, switch to the **Products to be deassigned** tab.

## Exporting a product list

To export a product list:

1. Select **Edit List** next to the product list you want to export.
2. On the *Edit Product List: {product list ID}* page, select **► Export**.
    The list is exported as a **.csv** file.

## Removing a product list

To remove a product list:
1. Select **Remove List** next to the product list you want to remove.
    The *Product List was successfully removed* page opens.
2. To confirm deletion, select **Remove List**.
    The *Overview of Product lists* page opens with the success message displayed.


***
**What's next?**
See [Product Lists: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/product-lists/references/reference-information-product-lists.html) to learn about the attributes you see, select, and enter while managing a product list.
