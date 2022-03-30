---
title: File details - product_price_schedule.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-product-price-schedulecsv
originalArticleId: 0662559b-6487-4d88-855e-3b605fc326c1
redirect_from:
  - /2021080/docs/file-details-product-price-schedulecsv
  - /2021080/docs/en/file-details-product-price-schedulecsv
  - /docs/file-details-product-price-schedulecsv
  - /docs/en/file-details-product-price-schedulecsv
---

This article contains content of the **product_price_schedule.csv** file to configure[ Product Price Schedule](/docs/scos/user/features/{{page.version}}/scheduled-prices-feature-overview.html) information on your Spryker Demo Shop.

## Headers & Mandatory Fields
These are the header fields to be included in the .csv file:

| Field Name | Mandatory | Type | Other Requirements/Comments | Description |
| --- | --- | --- | --- | --- |
| **abstract_sku** | Yes (if `concrete_sku` is empty) | String Either this field or `concrete_sku` needs to be filled, as the prices need to be assigned to a product. | SKU of the abstract product to which the price should apply. |
| **concrete_sku** | Yes (if `abstract_sku` is empty) | String |Either this field or `abstract_sku` needs to be filled, as the prices need to be assigned to a product. | SKU of the concrete product to which the price should apply. |
| **price_type** | Yes | String |N/A* | Defines the price type. |
| **store** | Yes | String |N/A | Store to which this price should apply. |
| **currency** | Yes | String |N/A* | Defines in which currency the price is. |
| **value_net** | Yes | Integer |N/A | Sets the net price. |
| **value_gross** | Yes | Integer |N/A | Sets the gross price. |
| **from_included** | Yes | Date |N/A | Sets the date from which these price conditions are valid. |
| **to_included** | Yes | Date |N/A | Sets the date to which these price conditions are valid. |
*N/A: Not applicable.

## Dependencies

This file has the following dependencies:
* [product_abstract.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/catalog-setup/products/file-details-product-abstract.csv.html)
* [product_concrete.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/catalog-setup/products/file-details-product-concrete.csv.html)
*     *stores.php* configuration file of the Demo Shop PHP project

## Template File & Content Example
A template and an example of the *product_price_schedule.csv*  file can be downloaded here:

| File | Description |
| --- | --- |
| [product_price_schedule.csvtemplate](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Catalog+Setup/Pricing/Template+product_price_schedule.csv) | Product Price Schedule .csv template file (empty content, contains headers only). |
| [product_price_schedule.csv.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Catalog+Setup/Pricing/product_price_schedule.csv) | Product Price Schedule .csv file containing a Demo Shop data sample. |
