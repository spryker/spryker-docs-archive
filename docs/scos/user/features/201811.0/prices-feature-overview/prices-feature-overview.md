---
title: Prices feature overview
search: exclude
description: In the article, you can find the price definition, its types, how the price is inherited and calculated.
last_updated: Jul 29, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v1/docs/price-functionality
originalArticleId: 99858c26-17a4-4ba5-85af-901cf5441c8c
redirect_from:
  - /v1/docs/price-functionality
  - /v1/docs/en/price-functionality
  - /v1/docs/price
  - /v1/docs/en/price
  - /v1/docs/net-gross-price
  - /v1/docs/en/net-gross-price
  - /v1/docs/auto-detect-currency
  - /v1/docs/en/auto-detect-currency
  - /v1/docs/multiple-currencies-per-store
  - /v1/docs/en/multiple-currencies-per-store
---

A price can be attached to an abstract product as well as to a concrete product. The price is stored as an integer, in the smallest unit of the currency (e.g. for Euro that would be cents).

Each price is assigned to a price type ( e.g. gross price, net price ) and for a price type there can be one to n product prices defined. Price type entity is used to differentiate between use cases: for example we have DEFAULT and ORIGINAL type where we use it for sale pricing.

The price can have gross or net value which can be used based on a price mode selected by customer in Yves. You can have shop running in both modes and select net mode for business customer, for example. Price also has currency and store assigned to it.
![Price calculation](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Price/Price+Functionality/price_calculation.png)

## Price Inheritance

As a general rule, if a concrete product doesn’t have a specific entity stored, then it inherits the values stored for its abstract product. This means that when getting the price entity for a specific product, first a check is made if a price is defined for the SKU corresponding to that product: if yes, then it returns that price, but if not, then it queries an abstract product linked to that product and checks if it has a price entity defined.

If it still can’t find a price, then it throws an exception (basically this shouldn’t happen if the products have been exported and are up to date).

The diagram bellow summarizes the logic for retrieving the price for a product:
![Price retrieval logic](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Price/Price+Functionality/price_retrieval_logic.png)

## Price Calculation

The concerns for the product price calculation are the following :

* retrieve valid price for the product
* calculate amount of tax

price for the options that were selected for the product (e.g.: frame, fabric, etc.)
For more information, see [Checkout Calculation](/docs/scos/user/features/{{page.version}}/cart-feature-overview/calculation/calculation-3.0.html).
