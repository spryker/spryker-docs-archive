---
title: Akeneo — Console commands
description: This guide provides the console commands for the Akeneo module.
last_updated: Feb 23, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/v6/docs/akeneo-console-commands
originalArticleId: 95c34ef9-e5a2-4589-8be8-60c0c5369f62
redirect_from:
  - /v6/docs/akeneo-console-commands
  - /v6/docs/en/akeneo-console-commands
---

The following console commands are available in your project after successful [installation](/docs/scos/dev/technology-partner-guides/{{page.version}}/product-information-pimerp/akeneo/installing-and-configuring-akeneo.html) of the Akeneo module. Run them one by one.
```bash
1) Command to import super attributes:
vendor/bin/console middleware:process:run -p SUPER_ATTRIBUTE_IMPORT_PROCESS -o data/import/maps/super_attribute_map.json

2) Command to prepare locale mapping:
vendor/bin/console middleware:process:run -p LOCALE_MAP_IMPORT_PROCESS -o data/import/maps/locale_map.json

3) Command to prepare products attributes mapping:
vendor/bin/console middleware:process:run -p ATTRIBUTE_MAP_PROCESS -o data/import/maps/attribute_map.json

4) Command to import categories:
vendor/bin/console middleware:process:run -p DEFAULT_CATEGORY_IMPORT_PROCESS

5) Command to import products attributes:
vendor/bin/console middleware:process:run -p ATTRIBUTE_IMPORT_PROCESS

6) Command to prepare product models data in local file:
vendor/bin/console middleware:process:run -p PRODUCT_MODEL_PREPARATION_PROCESS -o data/import/maps/product_models.json

7) Command to import product model data (abstract products):
vendor/bin/console middleware:process:run -p DEFAULT_PRODUCT_MODEL_IMPORT_PROCESS -i data/import/maps/product_models.json

8) Command to prepare products data in local file:
vendor/bin/console middleware:process:run -p PRODUCT_PREPARATION_PROCESS -o data/import/maps/products.json

9) Command to import product data (concrete products):
vendor/bin/console middleware:process:run -p DEFAULT_PRODUCT_IMPORT_PROCESS -i data/import/maps/products.json
```

<!--## outdated as per https://spryker.atlassian.net/wiki/spaces/ECO/pages/864453632/New+Akeneo+Documentation Multi-select Att ributes

The section below explains how Spryker treats multi-select attribues from Akeneo.

1. The attribute `pim_catalog_multiselect` is imported as a concatenated string.
2. The following attribute types are skipped during import:

  - `pim_assets_collection`
  - `pim_reference_data_multiselect`
  - `pim_catalog_price_collection`-->

1. On a project level, you can change `DefaultProductImportDictionary` instead of using the `EnrichAttributes` translator function or extending it.
2. Price attributes (`pim_catalog_price_collection`), except the one with `attribute_key = 'price'`, are skipped. For correct import, products should contain an attribute with `attribute_type pim_catalog_price_collection` and `attribute_key 'price'`.
