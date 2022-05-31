---
title: File details - discount.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-discountcsv
originalArticleId: c8bfc425-7004-4064-8e37-ad8708f07183
redirect_from:
  - /2021080/docs/file-details-discountcsv
  - /2021080/docs/en/file-details-discountcsv
  - /docs/file-details-discountcsv
  - /docs/en/file-details-discountcsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/merchandising-setup/discounts/file-details-discount.csv.html
  - /docs/scos/dev/data-import/201903.0/data-import-categories/merchandising-setup/discounts/file-details-discount.csv.html
  - /docs/scos/dev/data-import/201907.0/data-import-categories/merchandising-setup/discounts/file-details-discount.csv.html
---

This document describes the `discount.csv` file to configure [Discount](/docs/scos/user/features/{{page.version}}/promotions-discounts-feature-overview.html) information in your Spryker Demo Shop.

To import the file, run:

```bash
data:import:discount
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | REQUIREMENTS OR COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- |
| discount_key | &check; | String | Must be unique. | Key identifier of the discount. |
| display_name | &check; | String | Must be unique. | Unique display name of the discount. |
| description | &check; | String |  |Description of the discount. |
| amount |  | Number |  | Discount amount. |
| calculator_plugin |  | String |  | Name of the plugin used to calculate the product discount. |
| is_exclusive |  | Boolean |True = 1<br>False = 0 | Indicates if the discount is exclusive or not. |
| is_active |  | Boolean |True = 1<br>False = 0| Indicates if the discount is active or not. |
| valid_from |  | Date |  | Indicates the date from which the discount is valid. |
| valid_to |  | String |  | Indicates the date to which the discount is valid. |
| decision_rule_query_string |  | String |  | Query with the decision rule to assign the discount.  |
| collector_query_string |  | String |  | Query with the rule to collect the discount. |
| discount_type |  | String |*discount_type* can be either:<ul><li>cart_rule</li><li>voucher</li></ul> | Type of discount. |
| promotion_sku |  | String | | SKU of the promotion. |
| promotion_quantity |  | Number |  | Quantity of product items that have this discount. |

## Import file dependencies

This file has no dependencies.

## Additional information

If `discount_type` is set to *voucher*  then a voucher pool will be created from this data.

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [discount.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Merchandising+Setup/Discounts/Template+discount.csv) | Exemplary import file with headers only. |
| [discount.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Merchandising+Setup/Discounts/discount.csv) | Exemplary import file with Demo Shop data. |
