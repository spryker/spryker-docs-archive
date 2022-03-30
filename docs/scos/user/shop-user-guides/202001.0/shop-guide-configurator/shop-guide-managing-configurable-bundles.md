---
title: Shop Guide - Managing Configurable Bundles
description: In this article, you can find instructions on managing the Configurable Bundle in the Spryker Storefront.
last_updated: Aug 13, 2020
template: howto-guide-template
originalLink: https://documentation.spryker.com/v4/docs/shop-guide-managing-configurable-bundles
originalArticleId: 217be775-78da-4363-af95-c1e65216d5a4
redirect_from:
  - /v4/docs/shop-guide-managing-configurable-bundles
  - /v4/docs/en/shop-guide-managing-configurable-bundles
---

This topic describes the procedures of working with the Configurable Bundles in the Storefront.

## Accessing the Configurator Page

To access the Configurator page:
1. In the top category navigation, hover over **More > Configurable Bundle**.
![configurable-bundle-top-nav](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Configurator/Managing+Configurable+Bundles/configurable-bundle-top-nav.png)
2. On the **Configurable Bundle List** page, select the necessary bundle template.

## Setting up the Configurable Bundle in the Storefront

To set up the configurable bundle, perform the following steps:
1. On the **Configurable Bundle List** page, select the template that you would like to use.
2. On the bundle page, click the Slot name to check the assigned products for the slot.
3. Select one of the assigned products to fill the slot by clicking **Select** next to the product you choose.
![config-bundle-select](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Configurator/Managing+Configurable+Bundles/config-bundle-select.png)

Once the slot is filled, it is indicated in the UI:
![selected-slot](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Configurator/Managing+Configurable+Bundles/selected-slot.png)

4. Fill the remaining slots of the Configurable Bundle with the assigned products of your choice.
5. Once done, on the **Configurable Bundle Summary** page, click **Add to Cart** to order the bundle you have configured.
![configurable-bundle-summary](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Configurator/Managing+Configurable+Bundles/configurable-bundle-summary.png)

{% info_block warningBox "Note" %}

You must be logged in to a company account to be able to add the configured bundle to cart. The corresponding [company role permissions](/docs/scos/user/shop-user-guides/{{page.version}}/shop-guide-managing-company-roles.html) (Add item to cart) should also be applied to your user.

{% endinfo_block %}
