---
title: Managing Product Labels
search: exclude
description: The Managing Product Labels section describes the procedures you can use to view, edit, activate and/or deactivate product labels in the Back Office.
last_updated: Nov 22, 2019
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v4/docs/managing-product-labels
originalArticleId: 1d208ab8-dc63-4238-9342-75cdaf378d36
redirect_from:
  - /v4/docs/managing-product-labels
  - /v4/docs/en/managing-product-labels
related:
  - title: Product Labels feature overview
    link: docs/scos/user/features/page.version/product-labels-feature-overview.html
---

This topic describes the procedures of managing product labels.
***

To start managing product labels, navigate to **Products > Product Labels**.
***

You can view, edit, and activate or deactivate (depending on the current status) product labels by clicking respective buttons in the _Actions_ column in the list of Product Labels.
***

## Viewing Product Labels

To view a product label:
1. On the **Overview of Product Labels** page, click **View** in the _Actions_ column.
    Clicking View will take you to the **View Product Label** page.
2. On the **View Product Label** page, the following information is available:
    * General information about the label, including the name, exclusivity, and validity period.
    * Translation
    * Products to which the label is assigned.
3. Being on the **View Product Label** page, do one of the following:
   * To view the product to which a specific label is assigned, click **View** in the action column of the product to which this label applies table. This will take you to the **View Abstract Product** page.
    * To activate/deactivate the label, click **Activate**/**Deactivate** in the top right corner of the page.
    * To edit the label, click **Edit** in the top right corner of the page.
    * To return back to the **Overview of Product Tables** page, click **Back to Product Labels**
***

## Editing a Product Label

{% info_block warningBox "Note" %}

Products for the dynamic labels (like **New**, or **Discontinued**) are assigned dynamically; there is no way to manage relations manually.

{% endinfo_block %}

To edit a product label:
1. Click **Edit** in the _Actions_ column of the **Overview of Product Labels** page.
2. On the **Edit Product Label** page, edit the values. See [Product Labels: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/merchandising/product-labels/references/product-labels-reference-information.html).
3. Once done, click **Save**.
***
## Activating/Deactivating a Product Label

There are several ways to activate/deactivate a product label:

* Activate the label while creating/editing it by selecting the **Is Active** checkbox. The deselection of the checkbox deactivates the label.

* Deactivate the label while editing it by clicking **Deactivate** in the top right corner of the **Edit** page.

* Activate/deactivate a label while viewing it by clicking **Activate/Deactivate** in the top right corner of the **View** page.

* Activate/deactivate a label by selecting **Activate/Deactivate** in the _Actions_ column of the **Overview of Product Labels** page.
***

**What's next?**
* To learn how to prioritize a label, see [Prioritizing Labels](/docs/scos/user/back-office-user-guides/{{page.version}}/merchandising/product-labels/prioritizing-labels.html).
* To learn what attributes you enter and select while editing the product label, see [Product Labels: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/merchandising/product-labels/references/product-labels-reference-information.html).
