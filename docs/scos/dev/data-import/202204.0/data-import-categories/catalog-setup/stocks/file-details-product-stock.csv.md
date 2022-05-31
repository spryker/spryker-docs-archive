---
title: File details - product_stock.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-product-stockcsv
originalArticleId: 3ee0b369-582a-42c5-a659-81fc4231281d
redirect_from:
  - /2021080/docs/file-details-product-stockcsv
  - /2021080/docs/en/file-details-product-stockcsv
  - /docs/file-details-product-stockcsv
  - /docs/en/file-details-product-stockcsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/catalog-setup/stocks/file-details-product-stock.csv.html
  - /docs/scos/dev/data-import/201907.0/data-import-categories/catalog-setup/stocks/file-details-product-stock.csv.html
---

This document describes the `product_stock.csv` file to configure [Product Stock](/docs/scos/user/features/{{page.version}}/inventory-management-feature-overview.html) information In your Spryker Demo Shop.

To import the file, run:

```bash
data:import:product-stock
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | REQUIREMENTS OR COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- |
| concrete_sku | &check; | String |   | SKU reference that identifies the concrete product. |
| name | &check; | String |	  |The *name* value is imported from the `warehouse.csv` file. |  |
| quantity | &check; | Integer |   | Number of product items remaining in stock. The number of articles available in the warehouse. |
| is_never_out_of_stock |  | Boolean | True = 1<br>False = 0 | Used for non-tangible products that never run out-of-stock (for example, a software license, a service, etc.). The value must be 1 (*true*) if it is a non-tangible product. |
| is_bundle |  | Boolean | True = 1<br>False = 0 | Indicates if the product is a a bundle or not. The value will be equal to 1 (*true*) if the product is a bundle. |

## Import file dependencies

This file has the following dependencies:

* [product_concrete.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/catalog-setup/products/file-details-product-concrete.csv.html)
* [warehouse.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/commerce-setup/file-details-warehouse.csv.html)

## Additional information

* The `product_stock.csv` file contains information about the amount of product articles stored in the warehouses.
* The product is identified by `concrete_sku` field (imported from `product_concrete.csv`), field name is a valid name of a warehouse (imported from `warehouse.csv`), field quantity is a number of product items/articles remaining in stock.
* When you update stock via the data import and some products do not have the records in the `product_stock.csv`  file, then stock of these products are not updated.

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [product_stock.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Catalog+Setup/Stocks/Template+product_stock.csv) | Exemplary import file with headers only. |
| [product_stock.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Catalog+Setup/Stocks/product_stock.csv) | Exemplary import file with Demo Shop data. |
