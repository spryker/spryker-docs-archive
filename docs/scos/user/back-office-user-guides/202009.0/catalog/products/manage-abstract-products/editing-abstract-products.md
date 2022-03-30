---
title: Editing abstract products
description: Learn how to edit abstract products in the Back Office.
last_updated: May 19, 2021
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v6/docs/editing-abstract-products
originalArticleId: f620f883-97fd-4a7d-9d49-04e1f1dcc0ba
redirect_from:
  - /v6/docs/editing-abstract-products
  - /v6/docs/en/editing-abstract-products
related:
  - title: Managing Products
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/managing-products/managing-products.html
---

This document describes how to edit abstract products.


## Prerequisites 

To start working with abstract products, go to  **Catalog > Products**.

Each section contains reference information. Make sure to review it before you start, or look up the necessary information as you go through the process. 

## Editing general settings of an abstract product
    
To edit general settings of an abstract product:    
    
1. Next to the product you want to edit, select **Edit**.
    This takes you to the *Edit Product* page.
2. In the **General** tab, update **Store relations**.
3. Update **Name** and **Description** for the desired locales. 
4. Update **New from** and **New to** dates.
5. Select **Save**.
    The page refreshes with the success message displayed.
<div>
| ATTRIBUTE | DESCRIPTION | 
| --- | --- | --- | --- |
| Store relation  | Defines the [stores](/docs/scos/dev/tutorials-and-howtos/howtos/howto-set-up-multiple-stores.html) the product is available in.<br>You can select multiple values. |
| SKU Prefix | Unique product identifier that helps to track unique information related to the product. |
| Name | The name that's displayed for the product on the Storefront. |
| Description | The description that's displayed for the product on the Storefront. |
| New from<br>New to  | Defines the period of time for which: <br><ul><li>A [dynamic product label](/docs/scos/user/features/{{page.version}}/product-labels-feature-overview.html) *New* is assigned to the product.</li><li>The product is assigned to the *New* [category](/docs/scos/user/features/{{page.version}}/category-management-feature-overview.html)</li></ul><br> You can either select no dates or both. |
</div>

## Editing prices of an abstract product
To edit prices of an abstract product:    

1. Next to the product you want to edit, select **Edit**.
2. On the *Edit Product* page, switch to the **Prices & Tax** tab.
3. B2B Shop: Select a **Merchant Price Dimension**.
4. Enter **DEFAULT** prices for the desired available locales and currencies.
5. Optional:  Enter **ORIGINAL** prices for the desired available locales and currencies.
6. Select the **Tax Set**.
7. Select **Save**.
    The page refreshes with the success message displayed.
    
| Attribute |Description | 
| --- | --- | --- | --- |
|Merchant Price Dimension| B2B only<br>Defines the [merchant](/docs/scos/user/features/{{page.version}}/merchant-custom-prices-feature-overview.html) the prices apply to.<br>If **Default prices** is selected, the prices apply to all customers.<br>To [manage merchant relations](/docs/scos/user/back-office-user-guides/{{page.version}}/marketplace/merchants-and-merchant-relations/managing-merchant-relations.html) go to **Marketplace** > **Merchant Relations**. |
| Gross price<br>Net price | Gross and net value of the product. A gross prices is a price after tax. A net price is a price  before tax.<br>If a product variant of the abstract product does not have a price, it [inherits](/docs/scos/user/features/{{page.version}}/product-feature-overview/product-feature-overview.html#product-information-inheritance) the price you enter here. |
|Default<br>Original| A default price is the price a customer pays for the product. An original price is a price displayed as a strikethrough beside the default price on the Storefront. The original price is optional and is usually used to indicate a price change. |
|Add Product Volume Price<br>Edit Product Volume Price| This option allows you to define the prices that are based on the quantity of products that a customer selects. Works only with the default prices.<br>Add Product Volume Price appears only when the price for a currency was set up and saved.<br>Edit Product Volume Price appears only what the volume price was already set up for a currency.||✓|
|Tax Set|The conditions under which a product is going to be taxed.<br>The values available for selection derive from Taxes > Tax Sets<br>Only one value can be selected.|

## Editing volume pirces of an abstract product

To edit volume prices of an abstract product:

1. Next to the product you want to edit add volume prices of, select **Edit**.
2. On the *Edit Product* page, switch to the **Price & Tax** tab.
3. Next to the store you want to edit volume prices for, select **> Edit Product Volume Price**.
4. On the *Add volume prices* page, enter a **Qunatity**.
5. Enter a **Gross price**.
6. Optional: Enter a **Net price**.
7. Optional: To add more volume prices than the number of the rows displayed on the page, select **Save and add more rows**.
8. Repeat steps 4 to 7 until you edit all the desired volume prices. 
9. Select **Save and exit**.
    This opens the *Edit Product* page with the success message displayed. 
    
| ATTRIBUTE | DESCRIPTION | 
| --- | --- |
| Quantity | Defines the quantity of the product to which the prices from **Gross price** and **Net price** fields apply. | 
| Gross price | Gross price of the product with the quantity equal or bigger than defined in the **Quantity** field. A gross prices is a price after tax. |
| Net price | Net price of the product with the quantity equal or bigger than defined in the **Quantity** field.  A net price is a price before tax. | 

## Editing product variants of an abstract product

To edit a product variant, follow [Editing product variants](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/products/manage-concrete-products/editing-product-variants.html). 
To create a product variant, follow [Creating product variants](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/products/manage-concrete-products/editing-product-variants.html)

## Editing meta information of an abstract product

To edit meta information:
1. Next to the product you want to edit, select **Edit**.
2. On the *Edit Product* page, switch to the **SEO** tab.
3. Update the following for the desired locales:
    * **Title**
    * **Keywords**
    * **Description**
4. Select **Save**.
    The page refreshes with the success message displayed.
    
| Attribute |Description | 
| --- | --- | --- | --- |
|Title|The meta title for your product.|
|Keywords|The meta keywords for your product.|
|Description|Meta description for your product.|

## Editing product images of an abstract product

To edit product images:
1. Next to the product you want to edit, select **Edit**.
2. On the *Edit Product* page, switch to the **Image** tab.
3. Select a locale you want to update images for.
4. Update images:
    * To add a new image set, select **Add image set**
    * To add a new image, select **Add image**.
    * To update an image, update the following:
        * **Small Image URL**
        *  **Large Image URL**
        *  **Sort order**
    * To delete large and small images, select **Delete image**.
    * To delete an image set with its images, selecte **Delete image set**.
5. Repeat step *4* until you update images for all the desired locales.
6.  Select **Save**.
    The page refreshes with the success message displayed.
    
| Attribute |Description | 
| --- | --- | --- | --- |
|Image Set Name|The name of your image set.|
|Small|The link of the image that is going to be used in the product catalogs.|
|Large|The link to the image that is going to be used on the product details page.|
|Sort Order|If you add several images to an active image set, specify the order in which they are to be shown in the front end and back end using Sort Order fields. The order of images is defined by the order of entered numbers where the image set with sort order "0" is the first to be shown.|

## Editing scheduled prices of an abstract product

To edit a scheduled price:
1. Next to the product you want to edit, select **Edit**.
2. On the *Edit Product* page, switch to the **Scheduled Prices** tab.
3. Next to the scheduled price you want to edit, select **Edit**.
4. Select a **Store**.
5. Select a **Currency**.
6. Enter a **Net price**.
7. Optional: Eneter a **Gross price**.
8. Select a **Price type**.
9. Select a **Start from (included)** date and time.
10. Select a **Finish at (included)** date and time.
11. Select **Save**.
    This opens the *Edit Product* page with the success message displayed. The changes are reflected in the table with scheduled prices.

| ATTRIBUTE | DESCRIPTION |
| --- | --- |
| Abstract SKU | Unique identifier of an abstract product. The field is disabled because you are editing a scheduled price of a particular abstract product. |
| Concrete SKU | Unique identifier of a concrete product. The field is disabled because you are editing a scheduled price of a particular abstract product. |
| Store | [Store](/docs/scos/dev/tutorials-and-howtos/howtos/howto-set-up-multiple-stores.html) in which the scheduled price is displayed. Unless you add the scheduled price to all the other stores, the regular price is displayed in them.  |
| Currency | Currency in which the scheduled price is defined. Unless you define the scheduled price for all the other currencies, the regular prices is displayed for them.  |
| Net price | Net value of the product defined by the scheduled price. |
| Gross price |Gross value of product defined by the scheduled price.  |
| Price type |  Price type in which price schedule is defined: DEFAULT or ORIGINAL.|
| Start from (included)  | The date and time on which the scheduled price is applied. |
| Finish at (included) | The date and time on which the product price is reverted to the regular price. |


