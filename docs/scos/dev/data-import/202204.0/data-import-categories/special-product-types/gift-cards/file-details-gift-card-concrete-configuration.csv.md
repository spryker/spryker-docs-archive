---
title: File details- gift_card_concrete_configuration.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-gift-card-concrete-configurationcsv
originalArticleId: 6346beb6-6aec-440e-a458-dbf86e05e33d
redirect_from:
  - /2021080/docs/file-details-gift-card-concrete-configurationcsv
  - /2021080/docs/en/file-details-gift-card-concrete-configurationcsv
  - /docs/file-details-gift-card-concrete-configurationcsv
  - /docs/en/file-details-gift-card-concrete-configurationcsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/special-product-types/gift-cards/file-details-gift-card-concrete-configuration.csv.html
  - /docs/scos/dev/data-import/201903.0/data-import-categories/special-product-types/gift-cards/file-details-gift-card-concrete-configuration.csv.html
  - /docs/scos/dev/data-import/201907.0/data-import-categories/special-product-types/gift-cards/file-details-gift-card-concrete-configuration.csv.html
---

This document describes the `gift_card_concrete_configuration.csv` file to configure [Gift Card](/docs/scos/user/features/{{page.version}}/gift-cards-feature-overview.html) Concrete Configuration information on your Spryker Demo Shop. A **Gift Card Product** is a regular product in the shop which represents a Gift Card that Customer can buy. In this file, you can configure the amount of money that will be loaded in the Gift Card.

To import the file, run

```bash
data:import:gift-card-concrete-configuration
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | DEFAULT VALUE | REQUIREMENTS AND COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- | --- |
| sku | &check; | String |  | SKU identifier of the Concrete Gift Card Product. |
| value | &check; | Integer |  |The amount of money that will be loaded in the Gift Card.  |

## Import file dependencies

This file has the following dependency: [product_concrete.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/catalog-setup/products/file-details-product-concrete.csv.html).

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [gift_card_concrete_configuration.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Special+Product+Types/Gift+Cards/Template+gift_card_concrete_configuration.csv) | Exemplary import file with headers only.  |
| [gift_card_concrete_configuration.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Special+Product+Types/Gift+Cards/gift_card_concrete_configuration.csv) | Exemplary import file with Demo Shop data. |
