---
title: Creating a Product Option
description: Use this procedure to create a product option along with its values in the Back Office.
last_updated: Sep 15, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v5/docs/creating-a-product-option
originalArticleId: 9d330e5c-aae8-4a45-96b2-f29de65bc2f1
redirect_from:
  - /v5/docs/creating-a-product-option
  - /v5/docs/en/creating-a-product-option
related:
  - title: Product Options
    link: docs/scos/user/back-office-user-guides/page.version/catalog/product-options/product-options.html
  - title: Product Options feature overview
    link: docs/scos/user/features/page.version/product-options-feature-overview.html
---

This article describes how to create a product option.

To start working with the product options, go to **Products** > **Product Options**.
***

## Prerequisites

You should have an appropriate Tax Set created in the **Taxes** section in order to apply it to the product option group.

Let's say you want to add additional options to your product, like a warranty or a gift box. Those are exactly the things that are created in the Product Options section. Such options will have their own prices, and the user will be able to select the most suitable one.



## Creating a Product Option

**To create a product option:**
1. Click **Create product option** in the top right corner of the **Product option list** page.
2. On the **Create new Product Options** page that opens, you see **General Information** and **Products** tabs. 
In the **General Information** tab:
  1. Add the group name translation key. The format of the group name translation key should be as follows: **product.option.group.name.[your key]**. For example, product.option.group.name.test.
  2. Define a tax set assigned to your product option group by selecting the appropriate value from the drop-down list.
  3. In the **Option Values** section, enter an option name translation key value. The format of the option name translation key should be as follows: **product.option.[your key]**. For example, product.option.newtest.

    {% info_block infoBox "Note" %}

    You can remove an option value by clicking **Remove** next to the Option name translation key and SKU fields.

    {% endinfo_block %}

  4. Add a unique SKU for a product option value or proceed with the auto-generated one.
  5. In the **Prices** section, specify gross and net prices for a product option value. If you want to add several product options values, click **Add option** below the **Prices** section, and repeat the same step.

    {% info_block infoBox %}

    Prices are integer values and stored in their normalized form. For example, 4EUR is stored as 400 in the database.

    When a price is not defined, the product option value is considered as *inactive* for that specific currency and price mode.When a price is set to 0, it is considered as *free of charge*.

    {% endinfo_block %}

  6. In the **Translation** section, add a group name and option name that will be displayed in the shop application per each locale. You can copy the Group and Option names from one locale to another using the corresponding **Copy** icon.
3. Click **Next** to proceed to the **Products** tab, or just click on it.
4. In the **Products** tab, select product(s) to be assigned to the product. 
    Alternatively, you can click **Select all on the page**. In this case, all the products displayed on the page will be selected and added to the product option. The products you select will appear in the **Products to be assigned** tab.
 5. Once done, click **Save**.

## Activating a Product Option
Your product option is created, however, it is not activated thus it will not be seen on the product details page. 

**To activate a product option:**
On the **Edit product option** page, click **Activate** in the top right corner.
**OR**
On the **Product option list** page, click **Activate** for a specific product option in the _Actions_ column.

**Tips and tricks**
While creating a product option, if you want to remove some product from the selected, clear checkboxes next to the products you selected or click **Deselect all on the page** (this will remove all products from the to-be-assigned list you selected on this page).

You can switch between **All products** and **Products to be assigned** view by selecting the respective options on the top of the products table.
![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Back+Office+User+Guides/Products/Products/Product+Options/Creating+a+product+option/product-to-be-assigned-tab.png) 

If you know the name or the SKU of the product to which an option should be assigned, you can search for it in the **Search** field.

Each product abstract can have multiple product option groups assigned.
***
**What's next?**
Once the option is created, you may want to know how those options are managed. See [Managing Product Options](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/product-options/managing-product-options.html) for more details. 

To learn more about the attributes that you see, enter and select while creating a product option, as well as if you are interested to see some examples of how the product options are used, see [Product Options: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/product-options/references/product-options-reference-information.html).
