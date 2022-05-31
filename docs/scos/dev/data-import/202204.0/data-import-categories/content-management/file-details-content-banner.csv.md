---
title: File details - content_banner.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-content-bannercsv
originalArticleId: 4420043c-15fe-4485-8a7d-00d326d27d0f
redirect_from:
  - /2021080/docs/file-details-content-bannercsv
  - /2021080/docs/en/file-details-content-bannercsv
  - /docs/file-details-content-bannercsv
  - /docs/en/file-details-content-bannercsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/content-management/file-details-content-banner.csv.html
  - /docs/scos/dev/data-import/201907.0/data-import-categories/content-management/file-details-content-banner.csv.html
---

This document describes the `content_banner.csv` file to configure [Content Banner](/docs/scos/user/features/{{page.version}}/content-items-feature-overview.html#content-item) information in your Spryker Demo Shop.

To import the file, run:

```bash
data:import:content-banner
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | REQUIREMENTS OR COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- |
| key | &check; | String | Must be unique. | Unique identifier of the content. |
| name | &check; | String |Human-readable name. | Name of the content. |
| description | &check; | String |  | Description of the content. |
| title.default | &check; | String |  |Default title of the content.  |
| title.{ANY_LOCALE_NAME}*<br>Example value: *title.en_US* |  | String |  | Title of the content, translated into the specified locale (US for our example). |
| subtitle.default | &check; | String |  | 	Default subtitle of the content. |
| subtitle.{ANY_LOCALE_NAME}*<br>Example value: *subtitle.en_US* |  | String |  | Subttitle of the content, translated into the specified locale (US for our example).|
| image_url.default | &check; | String |  | Default image URL of the content. |
| image_url.{ANY_LOCALE_NAME}*<br>Example value: *image_url.en_US* |  | String |  | Image URL of the content, translated into the specified locale (US for our example).|
| click_url.default | &check; | String |  | Default click URL of the content. |
| click_url.{ANY_LOCALE_NAME}*<br>Example value: *click_url.en_US* |  | String |  | Click URL of the content, translated into the specified locale (US for our example).|
| alt_text.default | &check; | String |  | Default alt text of the content. |
| alt_text.{ANY_LOCALE_NAME}*<br>Example value: *alt_text.en_US* |  | String |  | Alt text of the content, translated into the specified locale (US for our example).|

*ANY_LOCALE_NAME: Locale date is dynamic in data importers. It means that ANY_LOCALE_NAME postfix can be changed, removed, and any number of columns with different locales can be added to the CSV files.

## Import file dependencies

This file has the following dependency: [glossary.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/commerce-setup/file-details-glossary.csv.html).

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [content_banner.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/Template+content_banner.csv) | Exemplary import file with headers only. |
| [content_banner.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/content_banner.csv) | Exemplary import file with Demo Shop data. |
