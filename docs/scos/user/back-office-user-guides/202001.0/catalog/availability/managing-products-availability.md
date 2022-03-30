---
title: Managing Products Availability
description: This guide provides steps on how to check whether products are in stock in the warehouse of the current store in the Back Office.
last_updated: Feb 3, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v4/docs/managing-products-availability
originalArticleId: 9fbe4ad9-34d2-4d01-b8fb-c4876bc79793
redirect_from:
  - /v4/docs/managing-products-availability
  - /v4/docs/en/managing-products-availability
related:
  - title: Abstract and Concrete Products
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/abstract-and-concrete-products.html
  - title: Managing Products
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/managing-products/managing-products.html
  - title: Product Information Management
    link: docs/scos/user/features/page.version/product-information-management/product-information-management.html
  - title: Timed Product Availability Feature Overview
    link: docs/scos/user/features/page.version/product-feature-overview/timed-product-availability-overview.html
---

This topic describes the actions you can do in the **Availability** section of  the Back Office.
***
To start working with availability, navigate to **Products > Availability**.
***
This section allows inventory managers, or other team members responsible for stock updates, to check the products' stock.
The main advantage is that you do not need to make any manual calculations. The system does all the calculations automatically and you get the aggregated availability value. You will have a single table with  a comparison of the product's stock value and the ordered value. It also calculates the bundled products stock. See [Availability: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/availability/references/availability-reference-information.html).

## Checking Availability

**To check** the product availability:
1. In the _Actions_ column of the **Products availability list** table, click **View** next to the corresponding product item.
This will take you to the **Product Availability** page. See [Availability: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/availability/references/availability-reference-information.html) for more details.
2. In case of a multistore setup, in the **Store** drop-down select the store locale to check the product's availability for each specific locale.

## Editing Stock

**To edit** the product stock:
1. On the **Product Availability** page of the product whose variant availability you would like to change, click **Edit Stock** for the corresponding variant.
2. On the **Edit Stock** page, specify **Quantity** for the product (for the needed warehouse, if several are set up).
3. Select **Never out of stock** if you want the product to be always available.
4. Click **Save**.

**To edit** the bundled product stock:
1. Navigate to the **Product Availability** page of a bundle whose bundled product variant availability you would like to change.
2. Click **View bundled products** in the **Variant availability** table.
3. In the **Bundled products** table that opens, click **Edit Stock** for the corresponding variant.
4. On the **Edit Stock** page, specify **Quantity** for the product (for the needed warehouse if several are set up).
5. Select **Never out of stock** if you want the product to be always available.
6. Click **Save**.

{% info_block warningBox "Note" %}

Please note that you are updating the product variant availability, not the bundle availability itself. To see examples on how the bundle availability is calculated, see [Availability: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/availability/references/availability-reference-information.html).

{% endinfo_block %}

**Tips and tricks**

You can edit stock for variants from the **Edit Concrete Product** page:
1. Navigate to the **Edit Product Abstract** using one of the following options:
    1.  **Products > Products > Edit**.
    2.  Click a hyperlinked SKU value in the **Availability > Product availability list** table.
2. In the **Variants** tab, click **Edit** next to the variant for which you would like to update the stock value.
3. Go to the **Price&Stock** tab.
4. Enter **Quantity** and select **Never out of stock** if you want the product to be always available.
5. Click **Save**.

{% info_block infoBox "Info" %}

Once on the **Edit Concrete Product** page, you can update any of the product details you need.

{% endinfo_block %}
