---
title: Product Sets feature overview
search: exclude
description: Learn about the modules that build up the Product Set feature
last_updated: Nov 22, 2019
template: concept-topic-template
originalLink: https://documentation.spryker.com/v3/docs/product-set
originalArticleId: ca66d085-e4b8-4179-9406-68427edfb27b
redirect_from:
  - /v3/docs/product-set
  - /v3/docs/en/product-set
---

The *Product Sets* feature allows you to create and sell collections of products. For example, you can create a stationary workspace set, a set of clothing or accessories, or furniture for a specific room.

![product-set-on-the-storefront](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Product+Management/Product+Sets/product-set-on-the-storefront.png)

When browsing a product set, a Storefront user can select variants per product in a set, add an individual or all products from the set to cart.

![product-set-actions](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Product+Management/Product+Sets/product-set-actions.png)


A Back Office user can define the following:
* The order of products in a set dispalyed on the Storefront.
* The order of products sets displayed on the Storefront. It's relevant if you have multiple product sets on the same page.
* Unique product set URL.


A Back Office user can add a product sets to any page by [creating a product set content item](/docs/scos/user/back-office-user-guides/{{page.version}}/content/content-items/creating-content-items.html) and [adding it to CMS pages and blocks](/docs/scos/user/back-office-user-guides/{{page.version}}/content/content-items/adding-content-items-to-cms-pages-and-blocks.html).


For more details on product sets, check the video:

{% wistia 9co7uw35a9 960 720 %}

### Current Constraints
Currently, the feature has the following functional constraints which are going to be resolved in the future:

* Product sets are shared across all the stores of a project.
* You cannot restrict availability of a product set to a store.
