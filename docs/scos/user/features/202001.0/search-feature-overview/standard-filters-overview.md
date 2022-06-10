---
title: Standard Filters overview
search: exclude
description: SCOS offers a variety of different filter types to ease the process of product discovery. These filters include single- or multi-select and range filters.
last_updated: Aug 13, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v4/docs/standard-filters
originalArticleId: ace82860-8e80-4a27-a4e7-515944920ac8
redirect_from:
  - /v4/docs/standard-filters
  - /v4/docs/en/standard-filters
---

E-commerce solutions usually offer a huge product catalog to display products and their variations. To help buyers find the products they are looking for in the catalog, we have the **Standard Filters** feature.

With Standard Filters, you can filter the products according to the specified price range, product ratings, product labels, color, material, brand etc.
![Filter Attributes](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Search+and+Filter/Standard+Filters/filter-attributes-b2c.png)

## Filter Types
In Spryker Commerce OS, the following filter types exist:

* **Single-select** - allows a user to select only one filter option.
![Single Select](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Search+and+Filter/Standard+Filters/single-select-b2c.gif)

* **Multi-select** - allows selecting several variants simultaneously.
![Multi Select](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Search+and+Filter/Standard+Filters/multi-select-b2c.gif)

* **Range** - filters data in the dimension from the maximum and minimum value. In the current implementation of our demo shop, the range filter is applied to the abstract product prices.
![Range Filter](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Search+and+Filter/Standard+Filters/range-b2c.gif)

Products appropriate for the active filters are displayed in the results.

Filter preferences can be configured in the **Back Office > Search and Filters > Filter Preferences**. Filter options depend on the attributes configured for the products. 

## Current Constraints
Price Range Filter is not supported with the Merchant Relations, that is why this filter is not included in the B2B demo shop. However, in [the B2C demo shop](https://docs.spryker.com/docs/scos/user/intro-to-spryker/b2c-suite.html), you can still filter the products using the price range filter.


