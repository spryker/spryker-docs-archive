---
title: File details - content_product_set.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-content-product-setcsv
originalArticleId: 170221d8-467a-4e8c-8449-07a454c5f684
redirect_from:
  - /2021080/docs/file-details-content-product-setcsv
  - /2021080/docs/en/file-details-content-product-setcsv
  - /docs/file-details-content-product-setcsv
  - /docs/en/file-details-content-product-setcsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/content-management/file-details-content-product-set.csv.html
  - /docs/scos/dev/data-import/201907.0/data-import-categories/content-management/file-details-content-product-set.csv.html
---

This document describes the `content_product_set.csv` file to configure [Content Product Set](/docs/scos/user/features/{{page.version}}/content-items-feature-overview.html#content-item) information in your Spryker Demo Shop.

To import the file, run:

```bash
data:import:content-product-set
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | REQUIREMENTS OR COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- |
| key | &check; | String | Must be unique. | Unique identifier of the content. |
| name | &check; | String |	Human-readable name. | Name of the content. |
| description | &check; | String |  | Description of the content. |
| product_set_key.default | &check; | String |  | Default key identifier of the product set. |
| product_set_key.{ANY_LOCALE_NAME}*<br>Example value: *product_set_key.en_US* |  | String |  | Key identifier of the product set, translated |

*ANY_LOCALE_NAME: Locale date is dynamic in data importers. It means that ANY_LOCALE_NAME postfix can be changed, removed, and any number of columns with different locales can be added to the CSV files.

## Import file dependencies

This file has the following dependency: [product_set.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/merchandising-setup/product-merchandising/file-details-product-set.csv.html).

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [content_product_set.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/Template+content_product_set.csv) | Exemplary import file with headers only. |
| [content_product_set.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/content_product_set.csv) | Exemplary import file with Demo Shop data. |
