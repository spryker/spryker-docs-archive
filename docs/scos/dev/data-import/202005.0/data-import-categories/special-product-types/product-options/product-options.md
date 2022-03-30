---
title: Product Options
last_updated: Sep 14, 2020
template: data-import-template
originalLink: https://documentation.spryker.com/v5/docs/product-options-import
originalArticleId: f9c5dc22-3cb6-47a9-a89f-0b7fc4fbf18c
redirect_from:
  - /v5/docs/product-options-import
  - /v5/docs/en/product-options-import
---

The **Product Opitons** category contains all data you need to manage product options in your online store. We have structured this section according to the following .csv files that you will have to use to import the data:

* [product_option.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/special-product-types/product-options/file-details-product-option.csv.html): allows you to define product options, like insurance, warranty or gift wrapping, and its abstract products.
* [product_option_price.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/special-product-types/product-options/file-details-product-option-price.csv.html): allows you to define the net and gross prices for each product option.  

The table below provides details on Product Opitons data importers, their purpose, .csv files, dependencies, and other details. Each data importer contains links to .csv files used to import the corresponding data, including specifications of mandatory and unique fields, dependencies, detailed explanations, recommendations, templates, and content examples.

| Data Importer | Purpose | Console Command| File(s) | Dependencies |
| --- | --- | --- | --- |--- |
| **Product Option**   | Imports information about product options, like insurance, warranty or gift wrapping, and the list of Abstract Product SKUs to which the Product Option is available. |`data:import:product-option` | [product_option.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/special-product-types/product-options/file-details-product-option.csv.html) |None |
| **Product Option Price**  | Imports information to set the prices net and gross for each of Product Option, per store and per currency.  |`data:import:product-option-price` |[product_option_price.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/special-product-types/product-options/file-details-product-option-price.csv.html)| [product_option.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/special-product-types/product-options/file-details-product-option.csv.html) |

