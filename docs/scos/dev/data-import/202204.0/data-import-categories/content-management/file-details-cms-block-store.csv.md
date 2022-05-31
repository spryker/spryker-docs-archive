---
title: File details- cms_block_store.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-cms-block-storecsv
originalArticleId: eb3af5d2-ec2b-4452-8a11-d392431ab8d2
redirect_from:
  - /2021080/docs/file-details-cms-block-storecsv
  - /2021080/docs/en/file-details-cms-block-storecsv
  - /docs/file-details-cms-block-storecsv
  - /docs/en/file-details-cms-block-storecsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/content-management/file-details-cms-block-store.csv.html
---

This document describes the `cms_block_store.csv` file to configure CMS Block Store information on your Spryker Demo Shop.

To import the file, run:

```bash
data:import:cms-block-store
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | REQUIREMENTS OR COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- |
| block_key | &check; | String |  | Key identifier of the block.  |
| store_name | &check; | String |  | Name of the store. |


## Import file dependencies

This file has the following dependencies:
* [cms_block.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/content-management/file-details-cms-block.csv.html)
* *stores.php* configuration file of the demo shop PHP project

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [cms_block_store.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/Template+cms_block_store.csv) | Exemplary import file with headers only. |
| [cms_block_store.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/cms_block_store.csv) | Exemplary import file with Demo Shop data. |
