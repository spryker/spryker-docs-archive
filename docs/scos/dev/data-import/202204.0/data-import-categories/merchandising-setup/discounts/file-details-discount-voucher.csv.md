---
title: File details - discount_voucher.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-discount-vouchercsv
originalArticleId: 741ea0dd-d3ad-40d0-98b3-6e16889b6794
redirect_from:
  - /2021080/docs/file-details-discount-vouchercsv
  - /2021080/docs/en/file-details-discount-vouchercsv
  - /docs/file-details-discount-vouchercsv
  - /docs/en/file-details-discount-vouchercsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/merchandising-setup/discounts/file-details-discount-voucher.csv.html
  - /docs/scos/dev/data-import/201903.0/data-import-categories/merchandising-setup/discounts/file-details-discount-voucher.csv.html
  - /docs/scos/dev/data-import/201907.0/data-import-categories/merchandising-setup/discounts/file-details-discount-voucher.csv.html
---

This document describes the `discount_voucher.csv` file to configure Discount Voucher information in your Spryker Demo Shop.

To import the file, run:

```bash
data:import:discount-voucher
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | REQUIREMENTS OR COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- |
| discount_key | &check; | String |`discount_key` must exist in the `discounts.csv` file | Key identifier of the discount. |
| quantity | &check; | Number |  | Number of vouchers that will be generated. |
| custom_code | &check; | String |  | Customized code of the voucher, composed by two parts:<ul><li>a prefix of the voucher code that can be set directly in this field,</li><li>a random part with the amount of random symbols equals to the value of random_generated_code_length field.</li></ul> |
| random_generated_code_length | &check; | String |If quantity >= 1 then `random_generated_code_length`	cannot be empty. | Random part of the voucher code with the amount of random symbols equals to the value of `random_generated_code_length` field. |
| max_number_of_uses |  | Number |If empty it will be set to 0. | Maximum number of this voucher usage. |
| voucher_batch | &check; | Number |`voucher_batch` must be previously created during *discount.csv* import, then the batch value must be a different number for each row in the file. | Voucher batch groups vouchers into batches. It identifies a voucher belonging to the same voucher pool. |
| is_active |  | Boolean | If empty, will be set to False = 0.<ul><li>True = 1</li><li>False = 0</li></ul>  | Indicates if discount voucher is active or not. |
*N/A: Not applicable.

## Import file dependencies

This file has the following dependency: [ discount.csv ](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/merchandising-setup/discounts/file-details-discount.csv.html).

## Additional information

The generated voucher code consists of two parts:

* `custom_code` which is a prefix of the voucher code that can be set directly at `custom_code`, and
* a random part with the amount of random symbols equals to the value of `random_generated_code_length` field.

If a quantity is equal to or greater than 1, then `random_generated_code_length` should be non-empty as the generated code is unique.

Field `voucher_batch` is necessary when different vouchers belong to the same voucher pool. It must have been previously created during `discount.csv` import, then the batch value must be a different number for each row in the file.

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [discount_voucher.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Merchandising+Setup/Discounts/Template+discount_voucher.csv) | Exemplary import file with headers only. |
| [discount_voucher.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Merchandising+Setup/Discounts/discount_voucher.csv) | Exemplary import file with Demo Shop data. |
