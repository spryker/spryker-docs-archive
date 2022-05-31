---
title: "File details - cms_page.csv"
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-cms-pagecsv
originalArticleId: 65418d11-4c73-4b42-94fb-8397c29eed33
redirect_from:
  - /2021080/docs/file-details-cms-pagecsv
  - /2021080/docs/en/file-details-cms-pagecsv
  - /docs/file-details-cms-pagecsv
  - /docs/en/file-details-cms-pagecsv
  - /docs/scos/dev/data-import/201811.0/data-import-categories/content-management/file-details-cms-page.csv.html
---

This document describes the `cms_page.csv` file to configure [CMS Page](/docs/scos/user/features/{{page.version}}/cms-feature-overview/cms-pages-overview.html) information in your Spryker Demo Shop.

To import the file, run:

```bash
data:import:cms-page
```

## Import file parameters

The file should have the following parameters:

| PARAMETER | REQUIRED | TYPE | REQUIREMENTS OR COMMENTS | DESCRIPTION |
| --- | --- | --- | --- | --- |
| template_name | &check; | String | | Name of the page template. |
| is_searchable |  | Boolean |Searchable = True = 1<br>Not searchable = False = 0 | Indicates if the page is searchable or not. |
| is_active |  | Boolean |Active = True = 1<br>Inactive = False = 0 | Indicates if the page is active or not. |
| publish |  | Boolean |Published = True = 1<br>Inactive = False = 0 | Indicates if the page is published or not. |
| page_key | &check; | String | Must be unique. | Identifier of the page. |
| url.{ANY_LOCALE_NAME}*<br>Example value: *url.en_US* |  | String |  |  Page URL, translated into the specified locale (US for our example). |
| name.{ANY_LOCALE_NAME}*<br>Example value: *name.en_US* |  | String |  |  Page name, translated into the specified locale (US for our example). |
| meta_title.{ANY_LOCALE_NAME}*<br>Example value: *meta_title.en_US* |  | String |  |  Page meta data title, translated into the specified locale (US for our example). |
| meta_keywords.{ANY_LOCALE_NAME}*<br>Example value: *meta_keywords.en_US* |  | String |  | Page meta data keywords, translated into the specified locale (US for our example). |
| meta_description.{ANY_LOCALE_NAME}*<br>Example value: *meta_description.en_US* |  | String |  | Page meta data description, translated into the specified locale (US for our example). |
| placeholder.title.{ANY_LOCALE_NAME}*<br>Example value: *placeholder.title.en_US* |  | String |  | Page placeholder to the title, translated into the specified locale (US for our example). |
| placeholder.content.{ANY_LOCALE_NAME}*<br>Example value: *placeholder.content.en_US* |  | String |  | Page placeholder to the content, translated into the specified locale (US for our example). |

*ANY_LOCALE_NAME: Locale date is dynamic in data importers. It means that ANY_LOCALE_NAME postfix can be changed, removed, and any number of columns with different locales can be added to the CSV files.

## Import file dependencies

This file has the following dependency: [cms_template.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/content-management/file-details-cms-template.csv.html).

## Import template file and content example

Find the template and an example of the file below:

| FILE | DESCRIPTION |
| --- | --- |
| [cms_page.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/Template+cms_page.csv) | Exemplary import file with headers only. |
| [cms_page.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Content+Management/cms_page.csv) | Exemplary import file with Demo Shop data. |
