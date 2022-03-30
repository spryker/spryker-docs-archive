---
title: Discontinuing Products
description: Use the guide to make the product variant discontinued in the Back Office.
last_updated: Feb 3, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v4/docs/discontinuing-a-product
originalArticleId: afea6342-98ff-4afe-ae96-f6d248a07c6c
redirect_from:
  - /v4/docs/discontinuing-a-product
  - /v4/docs/en/discontinuing-a-product
related:
  - title: Updating Product Variants
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/manage-concrete-products/updating-product-variants.html
  - title: Creating and Managing Product Bundles
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/managing-products/creating-and-managing-product-bundles.html
  - title: Adding Product Alternatives
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/manage-concrete-products/adding-product-alternatives.html
  - title: Adding Volume Prices
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/managing-products/adding-volume-prices.html
---

This article describes what steps you need to follow to discontinue the product.
***
After releasing a better version of a product, a company might decide to discontinue the older version.
This means that a product or service that is discontinued is no longer being produced or offered.
Let's say you have such a product for which a newer version is being released and you want to notify your customers that the older version is discontinued. How you do that? You mark the product variant as discontinued.

{% info_block infoBox %}

You always discontinue a product variant, not an abstract product itself.

{% endinfo_block %}

**To discontinue a product:**
1. On the **Edit Concrete Product** page, switch to the **Discontinue** tab.
2. Click **Discontinue**.
    Once Discontinue is selected, you see additional attributes and information.
3. You can add a note about the reason for the product being discontinued, or any other useful information. Just enter the text to the Add Note section for each locale.
4. Click **Save**.
The date of the deactivation is available for you on the Discontinue tab.
Days left (active_until) value is set to 180 days by default. You can change it on the project level.
After the product is marked as discontinued, a corresponding label appears on the product detail page and search results in the shop application.
The product with the Discontinued label cannot be added to cart.

{% info_block warningBox "Note" %}

If the product added to the shopping list or wishlist is marked as discontinued, the Discontinued status will appear in the list and the online store customer will not be able to proceed to the checkout.

{% endinfo_block %}

**What's next?**
Review the other articles in the _Products_ section to know more about product management. Also review the _References_ section to learn more about the attributes you see, select, and enter on the product pages.
