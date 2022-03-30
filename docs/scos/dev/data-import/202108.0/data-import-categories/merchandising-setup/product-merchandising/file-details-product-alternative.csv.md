---
title: File details- product_alternative.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-product-alternativecsv
originalArticleId: cda20a75-66a5-4c07-a130-74725e5e5da0
redirect_from:
  - /2021080/docs/file-details-product-alternativecsv
  - /2021080/docs/en/file-details-product-alternativecsv
  - /docs/file-details-product-alternativecsv
  - /docs/en/file-details-product-alternativecsv
---

This article contains content of the **product_alternative.csv** file to configure [Alternative Product](/docs/scos/user/features/{{page.version}}/alternative-products-feature-overview.html) information on your Spryker Demo Shop.

## Headers & Mandatory Fields 
These are the header fields to be included in the .csv file:

| Field Name | Mandatory | Type | Other Requirements/Comments | Description |
| --- | --- | --- | --- | --- |
| **concrete_sku** | Yes | String |N/A* | SKU of the concrete product to which this alternative is applied. |
| **alternative_product_concrete_sku** | Yes (*if `alternative_product_abstract_sku `is empty*) | String |N/A | SKU of the alternative concrete product. |
| **alternative_product_abstract_sku** | Yes (*if `alternative_product_concrete_sku` is empty*) | String |N/A | SKU of the alternative abstract product. |
*N/A: Not applicable.

## Dependencies

This file has the following dependencies:

* [product_concrete.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/catalog-setup/products/file-details-product-concrete.csv.html)
* [product_abstract.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/catalog-setup/products/file-details-product-abstract.csv.html)

## Recommendations & other information
It does not exist on by default on the project level. It can be created in order to override the CSV file from module: 

* `vendor/spryker/product-alternative-data-import/data/import/product_alternative.csv`

## Template File & Content Example
A template and an example of the *product_alternative.csv*  file can be downloaded here:

| File | Description |
| --- | --- |
| [product_alternative.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Merchandising+Setup/Product+Merchandising/Template+product_alternative.csv) | Product Alternative .csv template file (empty content, contains headers only). |
| [product_alternative.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Merchandising+Setup/Product+Merchandising/product_alternative.csv) | Product Alternative .csv file containing a Demo Shop data sample. |
