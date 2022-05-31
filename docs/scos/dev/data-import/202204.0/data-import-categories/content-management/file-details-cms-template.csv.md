---
title: File details - cms_template.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-cms-templatecsv
originalArticleId: 6221a424-5513-496b-bbc6-56a59471a264
redirect_from:
  - /2021080/docs/file-details-cms-templatecsv
  - /2021080/docs/en/file-details-cms-templatecsv
  - /docs/file-details-cms-templatecsv
  - /docs/en/file-details-cms-templatecsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/content-management/file-details-cms-template.csv.html
---

This document describes the `cms_template.csv` file to configure [CMS Template](/docs/scos/dev/tutorials-and-howtos/howtos/feature-howtos/cms/howto-create-cms-templates.html#cms-page-template) information in your Spryker Demo Shop.

To import the file, run:

```bash
data:import:cms-template
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | REQUIREMENTS OR COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- |
| template_name | &check; | String | Must be unique. | Name of the template. |
| template_path | &check; | String | Must be unique. Must be a valid path to a twig file template. | Path to the Twig file template. |

## Import file dependencies

This file has no dependencies.

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [cms_template.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/Template+cms_template.csv) | Exemplary import file with headers only. |
| [cms_template.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/cms_template.csv) | Exemplary import file with Demo Shop data. |
