---
title: File details- navigation.csv
last_updated: Jun 16, 2021
template: data-import-template
originalLink: https://documentation.spryker.com/2021080/docs/file-details-navigationcsv
originalArticleId: eb25c5b9-7718-4328-b5a5-d93a6a0fb9b7
redirect_from:
  - /2021080/docs/file-details-navigationcsv
  - /2021080/docs/en/file-details-navigationcsv
  - /docs/file-details-navigationcsv
  - /docs/en/file-details-navigationcsv
---

This article contains content of the **navigation.csv** file to configure [Navigation](/docs/scos/user/features/{{page.version}}/navigation-feature-overview.html) information on your Spryker Demo Shop.

## Headers & Mandatory Fields 
These are the header fields to be included in the .csv file:

| Field Name | Mandatory | Type | Other Requirements/Comments | Description |
| --- | --- | --- | --- | --- |
| **key** | v | String |N/A* | Navigation entity key. |
| **name** | v | String |N/A | Navigation entity name. |
| **is_active** | v | Boolean |N/A | Defines if the navigation element is active. |
*N/A: Not applicable.

## Dependencies

This file has no dependencies.

## Template File & Content Example
A template and an example of the *navigation.csv*  file can be downloaded here:

| File | Description |
| --- | --- |
| [navigation.csv template](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Navigation+Setup/Template+navigation.csv) | Navigation .csv template file (empty content, contains headers only). |
| [navigation.csv](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Back-End/Data+Manipulation/Data+Ingestion/Data+Import/Data+Import+Categories/Navigation+Setup/navigation.csv) | Navigation .csv file containing a Demo Shop data sample. |

