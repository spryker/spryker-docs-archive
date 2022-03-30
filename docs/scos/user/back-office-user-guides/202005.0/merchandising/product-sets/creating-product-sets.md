---
title: Creating Product Sets
description: Use the procedure to create a product set with the entered required values in the Back Office.
last_updated: Sep 15, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v5/docs/creating-a-product-set
originalArticleId: 9c83ebbc-ad07-4aa0-b23e-d9f37207d964
redirect_from:
  - /v5/docs/creating-a-product-set
  - /v5/docs/en/creating-a-product-set
related:
  - title: Product Sets- Reference Information
    link: docs/scos/user/back-office-user-guides/page.version/merchandising/product-sets/references/product-sets-reference-information.html
  - title: Product Sets feature overview
    link: docs/scos/user/features/page.version/product-sets-feature-overview.html
---

This article describes how to create a product set.

You create a product set to improve the customer's shopping experience. You collect similar products into a logical chunk that can be bought by a single click. Let's say you have a _Pen_. The logically connected items to this product can be a _Pencil_, a _Notebook_, and _Sticky Notes_. You can collect these products under a set named _Basic office supplies_. Instead of searching for each specific items, your customer will add this set to cart.

To start working with product sets, go to **Merchandising** > **Product Sets** section.

***

**To create a product set:**
1. In the top-right corner of the **Product Sets** page, click **Create Product Set**.
    On the **Create Product Set** tab, you see four tabs: **General**, **Products**, **SEO**, and **Images**.
2. On the **General** tab that is used to provide the general information about your product set, like name, URL, and description, do the following:
    1. Fill in the desired name of your new Product Set.
    2. Give your Product Set a URL slug. Do not leave spaces in this tag; instead, any multi-word URL fill in the spaces with a dash or underscore.
    3. **Optional:** Enter a description for your Product Set. This can be anything you want that identifies the _what_ or _why_ of your Product Set.
    If you have multiple languages, you will be required to fill in the same information in all languages.
    4. At the bottom of the **General** tab, you will find Product Set Key, Weight and a checkbox for Active. Enter the values for the attributes. To know more about these attributes, see [Product Sets: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/merchandising/product-sets/references/product-sets-reference-information.html).
3. Select **Next** to proceed to the **Products** tab, or just click on it.
    The **Product** tab is where you will select which products should be included in your product set.
4. To add products, simply select the checkbox next to your desired products in the **Selected** column. You can use the available search tool on the top right of the **Select Products to assign** tab on this page. You can select as many products as needed — there is no limit.
    {% info_block errorBox "Important" %}

    Any Product Set requires a minimum of two Products.

    {% endinfo_block %}

5. Select **Next** to proceed to the **SEO** tab, or just click on it.
    This tab is used to add a piece of friendly SEO information for your product set to improve the search.
6. On the **SEO** tab, enter the SEO information for your product set. See [Product Sets: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/merchandising/product-sets/references/product-sets-reference-information.html) to know more about the SEO attributes. Fill in all this information for any languages your store requires. None of the SEO descriptions or title will be shown in the online store.
7. Select the **Next** to proceed to the **Images** tab, or just click on it.
8. In the **Images** tab, click **Add image set**.
9. Enter the name of your image set and add the URLs to the images. For more information about the attributes you enter, see [Product Sets: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/merchandising/product-sets/references/product-sets-reference-information.html). You can select as many images as you would like in your image set by selecting **Add Image**.
    Following the same procedure, choose images particular to your different online stores.
    
    {% info_block infoBox "Info" %}
    
    If you do not specify different images for your different stores, the system will use the photos displayed in the **Default** drop-down
    
    {% endinfo_block %}
10. Once you are satisfied with the setup, click **Submit**.

    {% info_block infoBox "Activating a product set" %}

    If you did not select the **Active** checkbox on in the *General* tab, your product set is inactive.
    To activate it, click **Activate** on the **View Product Set** page, or select **Activate** in the _Actions_ column of the **Product Sets** page.

    {% endinfo_block %}


***
**What's next?**

* To know how the product sets are managed, see [Managing Product Sets](/docs/scos/user/back-office-user-guides/{{page.version}}/merchandising/product-sets/managing-product-sets.html).
* To know more about the attributes that you select and enter while creating a product set, as well as to see some examples of product sets, see [Product Sets: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/merchandising/product-sets/references/product-sets-reference-information.html).
