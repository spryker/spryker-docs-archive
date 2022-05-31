---
title: File details - product_option_price.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-product-option-pricecsv
originalArticleId: 7990de20-cb7f-467d-80e8-b3ca2cb5ff81
redirect_from:
  - /2021080/docs/file-details-product-option-pricecsv
  - /2021080/docs/en/file-details-product-option-pricecsv
  - /docs/file-details-product-option-pricecsv
  - /docs/en/file-details-product-option-pricecsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/special-product-types/product-options/file-details-product-option-price.csv.html
  - /docs/scos/dev/data-import/201903.0/data-import-categories/special-product-types/product-options/file-details-product-option-price.csv.html
  - /docs/scos/dev/data-import/201907.0/data-import-categories/special-product-types/product-options/file-details-product-option-price.csv.html
---

This document describes the `product_option_price.csv` file to configure Product Option Price information on your Spryker Demo Shop. Importing the Product Option Price data sets the net and gross prices for each of the Product Options, per store and per currency.

To import the file, run

```bash
data:import:product-option-price
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | DEFAULT VALUE | REQUIREMENTS AND COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- | --- |
| product_option_sku | &check; | String |  |  SKU identifier of the Product Option.|
| store | &check; | String |  | Name of the store that contains this product option. |
| currency | &check; | String |  | Currency used with this product option. |
| value_net |  | Integer |The original value is multiplied by 100, before stored in this field. | Net price value of the Product Option. |
| value_gross |  | Integer | The original value is multiplied by 100, before stored in this field. | Gross price value of the Product Option. |

## Import file dependencies

This file has the following dependencies: [product_option.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/special-product-types/product-options/file-details-product-option.csv.html).

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [product_option_price.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Special+Product+Types/Product+Options/Template+product_option_price.csv) | Exemplary import file with headers only. |
| [product_option_price.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Special+Product+Types/Product+Options/product_option_price.csv) | Exemplary import file with Demo Shop data. |
