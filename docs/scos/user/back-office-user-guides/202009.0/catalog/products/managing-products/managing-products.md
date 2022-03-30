---
title: Managing products
description: Use this guide to view product details, activate or update product attributes in the Back Office.
last_updated: Aug 27, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v6/docs/managing-products
originalArticleId: 4e92e3c1-c973-4386-b09b-4f5be54c41d9
redirect_from:
  - /v6/docs/managing-products
  - /v6/docs/en/managing-products
related:
  - title: Discontinuing Products
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/manage-concrete-products/discontinuing-products.html
  - title: Adding Product Alternatives
    link: docs/scos/user/back-office-user-guides/page.version/catalog/products/manage-concrete-products/adding-product-alternatives.html
---

This article describes how to manage abstract and concrete products.

To start managing products, go to **Catalog** > **Products**.
*** 
## Activating a Product
The abstract product is inactive until at least one product variant is activated. You should understand that there is no option to activate
**To activate a product:**
1. Navigate to the product variant of the product that you want to activate:
    **Edit abstract product > Variant > Edit product variant**
2.  Click **Activate** on the top of the **Edit Concrete Product** page.
Starting now, the product is visible to the customers of your online store. 
Please keep in mind that each variant needs to be activated in order to be visible to your customers.

**Tips and tricks**
If at some point of time you want to hide the product variant from your customers, you just deactivate it using the same procedure described above. This deactivates only the product variant. The abstract product is active until at least one its variant is active.

## Viewing a Product
If you need to review the product details without actually editing them, do the following:
1. In the _Actions_ column of the abstract product you want to view, click **View**.
2. On the **View Product** page, you can navigate to the view product variant, initiate the editing flow for it, or manage its attributes. 

**Tips and tricks**
If you notice something you would like to change for your product, click **Edit** on the top-right corner of the page. 


## Managing Product Attributes
When you see the **Manage Attributes** option, keep in mind that you manage the attributes like brand, but not the super attributes. Such attributes like brand do not define the product variants differentiation, meaning they are not used while defining the concrete products of an abstract product. They rather go to the details section on the product details page in your online store. You can manage attributes for both, abstract and concrete products.
{% info_block infoBox "Info" %}

The attributes that you add are taken from the **Products > Attributes** section of the Back Office. So the attribute you want to define should exist in that section.

{% endinfo_block %}


**To manage the product attributes:**
1. Select the **Manage Attributes** option for the concrete or abstract product in the _Actions_ column, or from the top-right corner of the **Edit** page.
2. On the **Manage Attributes for Product** page, start typing the first three letter of the attribute key.
3. Select the suggested value and click **Add**.
4. In the _Attributes_ section, define the **Default** value for your attributes and specify the value for the **locales**. 
    Repeat the procedure if needed.
5. Once done, click **Save**.
See the _References_ section to see the examples of how the attributes look like.
***
**What's next?**
Review the other articles in the _Products_ section to know more about product management. Also review the _References_ section to learn more about the attributes you see, select, and enter on the product pages.

