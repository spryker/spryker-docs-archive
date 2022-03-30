---
title: Migration guide - ProductAvailabilitiesRestApi
description: Use the guide to migrate to a new version of the ProductAvailabilitiesRestApi module.
last_updated: Jun 16, 2021
template: module-migration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/productavailabilitiesrestapi-migration-guide
originalArticleId: 192ef615-640f-48af-aaf3-1b2891dc6570
redirect_from:
  - /2021080/docs/productavailabilitiesrestapi-migration-guide
  - /2021080/docs/en/productavailabilitiesrestapi-migration-guide
  - /docs/productavailabilitiesrestapi-migration-guide
  - /docs/en/productavailabilitiesrestapi-migration-guide
  - /v1/docs/productavailabilitiesrestapi-migration-guide
  - /v1/docs/en/productavailabilitiesrestapi-migration-guide
  - /v2/docs/productavailabilitiesrestapi-migration-guide
  - /v2/docs/en/productavailabilitiesrestapi-migration-guide
  - /v3/docs/productavailabilitiesrestapi-migration-guide
  - /v3/docs/en/productavailabilitiesrestapi-migration-guide
  - /v4/docs/productavailabilitiesrestapi-migration-guide
  - /v4/docs/en/productavailabilitiesrestapi-migration-guide
  - /v5/docs/productavailabilitiesrestapi-migration-guide
  - /v5/docs/en/productavailabilitiesrestapi-migration-guide
  - /v6/docs/productavailabilitiesrestapi-migration-guide
  - /v6/docs/en/productavailabilitiesrestapi-migration-guide
  - /docs/scos/dev/module-migration-guides/201811.0/glue-api/migration-guide-productavailabilitiesrestapi.html
  - /docs/scos/dev/module-migration-guides/201903.0/glue-api/migration-guide-productavailabilitiesrestapi.html
  - /docs/scos/dev/module-migration-guides/201907.0/glue-api/migration-guide-productavailabilitiesrestapi.html
  - /docs/scos/dev/module-migration-guides/202001.0/glue-api/migration-guide-productavailabilitiesrestapi.html
  - /docs/scos/dev/module-migration-guides/202005.0/glue-api/migration-guide-productavailabilitiesrestapi.html
  - /docs/scos/dev/module-migration-guides/202009.0/glue-api/migration-guide-productavailabilitiesrestapi.html
  - /docs/scos/dev/module-migration-guides/202108.0/glue-api/migration-guide-productavailabilitiesrestapi.html
---

## Upgrading from version 3.* to version 4.*

In this new version of the **ProductAvailabilitiesRestApi** module, we have added support of decimal stock. You can find more details about the changes on the [ProductAvailabilitiesRestApi module](https://github.com/spryker/product-availabilities-rest-api/releases) release page.

{% info_block errorBox %}

This release is a part of the **Decimal Stock** concept migration. When you upgrade this module version, you should also update all other installed modules in your project to use the same concept as well as to avoid inconsistent behavior. For more information, see [Decimal Stock Migration Concept](/docs/scos/dev/migration-concepts/decimal-stock-migration-concept.html).

{% endinfo_block %}

**To upgrade to the new version of the module, do the following:**

1. Upgrade the **ProductAvailabilitiesRestApi** module to the new version:

{% info_block errorBox %}

`spryker/product-availabilities-rest-api:4.0.0` has a critical issue fixed in the subsequent minor release (`spryker/product-availabilities-rest-api:4.1.0`). Version `4.0.0` should never be used by the projects.

{% endinfo_block %}

```bash
composer require spryker/product-availabilities-rest-api: "^4.1.0" --update-with-dependencies
```
2. Update the database entity schema for each store in the system:

```bash
APPLICATION_STORE=DE console propel:schema:copy
APPLICATION_STORE=US console propel:schema:copy
...
```
3. Run the database migration:

```bash
console propel:install
console transfer:generate
```
4. Update the apps and integrations that use the product availabilities API. From now on, support of high precision availability quantity is required in string representation (15 becomes '15.0000000000'). The API response changed as follows:

```bash
GET /concrete-products/sku/concrete-product-availabilities
```

Was:
```bash
{
    "data": [
        {
            "type": "concrete-product-availabilities",
            "id": "sku",
            "attributes": {
                "isNeverOutOfStock": true,
                "availability": true,
                "quantity": 10
            },
            "links": {
                "self": "http://glue.mysprykershop.com/concrete-products/sku/concrete-product-availabilities"
            }
        }
    ],
    "links": {
        "self": "http://glue.mysprykershop.com/concrete-products/sku/concrete-product-availabilities"
    }
}
```

Becomes:
```bash
{
    "data": [
        {
            "type": "concrete-product-availabilities",
            "id": "sku",
            "attributes": {
                "isNeverOutOfStock": true,
                "availability": true,
                "quantity": "10.0000000000"
            },
            "links": {
                "self": "http://glue.mysprykershop.com/concrete-products/sku/concrete-product-availabilities"
            }
        }
    ],
    "links": {
        "self": "http://glue.mysprykershop.com/concrete-products/sku/concrete-product-availabilities"
    }
}
```

```bash
GET /abstract-products/sku/abstract-product-availabilities
```

Was:
```bash
{
    "data": [
        {
            "type": "abstract-product-availabilities",
            "id": "sku",
            "attributes": {
                "availability": true,
                "quantity": 10
            },
            "links": {
                "self": "http://glue.mysprykershop.com/abstract-products/sku/abstract-product-availabilities"
            }
        }
    ],
    "links": {
        "self": "http://glue.mysprykershop.com/abstract-products/sku/abstract-product-availabilities"
    }
}
```

Becomes:
```bash
{
    "data": [
        {
            "type": "abstract-product-availabilities",
            "id": "sku",
            "attributes": {
                "availability": true,
                "quantity": "10.0000000000"
            },
            "links": {
                "self": "http://glue.mysprykershop.com/abstract-products/sku/abstract-product-availabilities"
            }
        }
    ],
    "links": {
        "self": "http://glue.mysprykershop.com/abstract-products/sku/abstract-product-availabilities"
    }
}
```

*Estimated migration time: 5 min*

## Upgrading from version 1.* to version 3.0.0

{% info_block infoBox %}

In order to dismantle the Horizontal Barrier and enable partial module updates on projects, a Technical Release took place. Public API of source and target major versions are equal. No migration efforts are required. Please [contact us](https://spryker.com/en/support/) if you have any questions.

{% endinfo_block %}
