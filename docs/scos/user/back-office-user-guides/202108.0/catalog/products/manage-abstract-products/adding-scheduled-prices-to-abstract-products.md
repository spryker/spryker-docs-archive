---
title: Adding scheduled prices to abstract products
description: Learn how to add scheduled prices to abstract products in the Back Office.
last_updated: Aug 10, 2021
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/adding-scheduled-prices-to-abstract-products
originalArticleId: 133e924e-f8f0-46b4-9cc0-29216ed21455
redirect_from:
  - /2021080/docs/adding-scheduled-prices-to-abstract-products
  - /2021080/docs/en/adding-scheduled-prices-to-abstract-products
  - /docs/adding-scheduled-prices-to-abstract-products
  - /docs/en/adding-scheduled-prices-to-abstract-products
---

This document describes how to add scheduled prices to abstract products.

## Prerequisites

To start working with abstract products, go to  **Catalog&nbsp;<span aria-label="and then">></span> Products**.

Review the reference information before you start, or look up the necessary information as you go through the process.

## Adding a scheduled price to an abstract product

To add a scheduled price to an abstract product:
1. Next to the product you want to add a scheduled price for, select **Edit**.
2. On the *Edit Product* page, switch to the *Scheduled Prices* tab.
3. Click **+ Add scheduled price**.
4. Select a **Store**.
5. Select a **Currency**.
6. Enter a **Net price**.
7. Optional: Enter a **Gross price**.
8. Select a **Price type**.
9. Select a **Start from (included)** date and time.
10. Select a **Finish at (included)** date and time.
11. Click **Save**.
    This opens the *Edit Product* page with the success message displayed. The scheduled price you've added is displayed in the table.


### Reference information: Adding a scheduled price to an abstract product

The following table describes the attributes you enter and select when adding a scheduled price to an abstract product.

| ATTRIBUTE | DESCRIPTION |
| --- | --- |
| Abstract SKU | Unique identifier of an abstract product. The field is disabled because you are adding a scheduled price to a particular abstract product. |
| Concrete SKU | Unique identifier of a concrete product. The field is disabled because you are adding a scheduled price to a particular abstract product. |
| Store | [Store](https://docs.spryker.com/docs/scos/dev/tutorials-and-howtos/howtos/howto-set-up-multiple-stores.html) in which the scheduled price will be displayed. Unless you add the scheduled price to all the other stores, the regular price will be displayed in them.  |
| Currency | Currency in which the scheduled price is defined. Unless you define the scheduled price for all the other currencies, the regular price will be displayed for them.  |
| Net price | Net value of the product defined by the scheduled price. |
| Gross price |Gross value of product defined by the scheduled price.  |
| Price type |  Price type in which price schedule is defined: DEFAULT or ORIGINAL.|
| Start from (included)  | Date and time on which the scheduled price will be applied. |
| Finish at (included) | Date and time on which the product price will be reverted to the regular price. |

**Tips and tricks**
<br>You can add multiple scheduled prices for the same abstract product. Repeat the steps in [Add a scheduled price for an abstract product](#adding-a-scheduled-price-to-an-abstract-product) until you add the desired number of scheduled prices.

If you want to add more than five scheduled prices, it might be quicker to [import the scheduled prices](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/scheduled-prices/creating-scheduled-prices.html).
