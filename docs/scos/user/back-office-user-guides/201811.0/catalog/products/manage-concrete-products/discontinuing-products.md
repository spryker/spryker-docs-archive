---
title: Discontinuing Products
description: Use the guide to make the product variant discontinued in the Back Office.
last_updated: Feb 11, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v1/docs/discontinuing-a-product
originalArticleId: a084c458-1110-491a-abda-de41dfaba06c
redirect_from:
  - /v1/docs/discontinuing-a-product
  - /v1/docs/en/discontinuing-a-product
related:
  - title: Creating an Abstract Product
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/manage-abstract-products/creating-abstract-products-and-product-bundles.html
  - title: Creating and Managing Product Bundles
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/manage-abstract-products/creating-product-bundles.html
  - title: Creating Product Variants
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/manage-concrete-products/creating-product-variants.html
  - title: Managing Products
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/managing-products/managing-products.html
  - title: Adding Product Alternatives
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/manage-concrete-products/adding-product-alternatives.html
  - title: Adding Volume Prices
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/manage-abstract-products/adding-volume-prices-to-abstract-products.html
  - title: Products- Reference Information
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/references/products-reference-information.html
  - title: Abstract Product- Reference Information
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/references/abstract-product-reference-information.html
  - title: Concrete Product- Reference Information
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/references/concrete-product-reference-information.html
---

This article describes what steps you need to follow to discontinue the product.
***

After releasing a better version of a product, a company might decide to discontinue the older version.
This means that a product or service that is discontinued is no longer being produced or offered.
Let's say you have such a product for which a newer version is being released and you want to notify your customers that the older version is discontinued. How you do that? You mark the product variant as discontinued.

{% info_block infoBox %}

You always discontinue a product variant, not an abstract product itself.

{% endinfo_block %}
***

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
