---
title: File details- shipment_price.csv
last_updated: Sep 14, 2020
template: data-import-template
originalLink: https://documentation.spryker.com/v5/docs/file-details-shipment-pricecsv
originalArticleId: 9d5fdbf2-8b88-4fb8-a282-56e931718498
redirect_from:
  - /v5/docs/file-details-shipment-pricecsv
  - /v5/docs/en/file-details-shipment-pricecsv
---

This article contains content of the **shipment_price.csv** file to configure [Shipment Price](/docs/scos/user/features/{{page.version}}/shipment-feature-overview.html) information on your Spryker Demo Dhop.

## Headers & Mandatory Fields
These are the header fields to be included in the .csv file:

| Field Name | Mandatory | Type | Other Requirements/Comments | Description |
| --- | --- | --- | --- | --- |
| **shipment_method_key** | Yes | String  | Value previously imported already by its data importer using the [shipment.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/commerce-setup/file-details-shipment.csv.html) file.| Identifier of the shipment method. |
| **store** | Yes | String | Value previously defined in the *stores.php* project configuration. | Name of the store. |
| **currency** | Yes | String | Value previously imported already by its data importer using the [currency.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/commerce-setup/file-details-currency.csv.html) file. | Currency ISO code. |
| **value_net** | No |Integer | Empty price values will be imported as zeros. | Net value of the shipment cost. |
| **value_gross** | No | String |Empty price values will be imported as zeros. | Gross value of the shipment cost.  |
*N/A: Not applicable.

## Dependencies
This file has the following dependencies:

*     [shipment.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/commerce-setup/file-details-shipment.csv.html)
*     [currency.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/commerce-setup/file-details-currency.csv.html)
*     s*tores.ph*p configuration file of the demo shop PHP project

## Recommendations & Other Information

Field *value* must be *integer* as it is the internal format to store money (currency) in Spryker demo shop. Float values get converted into integer by multiplying by 100 (for example, if the shipment cost is 5.50 EUR, the value in CSV file should be 550).

Fields *shipment_method_key*, *store* and *currency* are mandatory, and must be valid (imported already from existing database values, or created manually using precedent CSV files: *shipment_method.csv* and *currency.csv* and *stores.php* configuration project file). Empty value fields will be imported as zeros.

## Template File & Content Example
A template and an example of the *shipment_price.csv* file can be downloaded here:

| File | Description |
| --- | --- |
| [shipment_price.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Commerce+Setup/Template+shipment_price.csv) | Shipment price .csv template file (empty content, contains headers only). |
| [shipment_price.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Commerce+Setup/shipment_price.csv) | Shipment price .csv file containing a Demo Shop data sample. |
