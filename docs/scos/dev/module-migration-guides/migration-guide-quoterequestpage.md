---
title: Migration guide - QuoteRequestPage
last_updated: Jun 16, 2021
template: module-migration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/mg-quoterequestpage
originalArticleId: 49398eed-5f0b-48db-a915-14f70ee81a82
redirect_from:
  - /2021080/docs/mg-quoterequestpage
  - /2021080/docs/en/mg-quoterequestpage
  - /docs/mg-quoterequestpage
  - /docs/en/mg-quoterequestpage
  - /v3/docs/mg-quoterequestpage
  - /v3/docs/en/mg-quoterequestpage
  - /v4/docs/mg-quoterequestpage
  - /v4/docs/en/mg-quoterequestpage
  - /v5/docs/mg-quoterequestpage
  - /v5/docs/en/mg-quoterequestpage
  - /v6/docs/mg-quoterequestpage
  - /v6/docs/en/mg-quoterequestpage
  - /docs/scos/dev/module-migration-guides/201907.0/migration-guide-quoterequestpage.html
  - /docs/scos/dev/module-migration-guides/202001.0/migration-guide-quoterequestpage.html
  - /docs/scos/dev/module-migration-guides/202005.0/migration-guide-quoterequestpage.html
  - /docs/scos/dev/module-migration-guides/202009.0/migration-guide-quoterequestpage.html
  - /docs/scos/dev/module-migration-guides/202108.0/migration-guide-quoterequestpage.html
---

## Upgrading from version 2.x.x to version 3.x.x

In this new version of the `QuoteRequestPage` module, we have added support of shipment costs. You can find more details about the changes on the [QuoteRequestPage module release page](https://github.com/spryker-shop/quote-request-page/releases). The major changes are:

* Added new dependency for spryker/shipment:^8.4.0.
* Added new dependency for spryker/step-engine:^3.3.0.
* Removed several twig files.

**To migrate do the following:**

1) Update the `QuoteRequestPage` module:
```bash
composer require spryker-shop/quote-request-page: "^3.0.0" --update-with-dependencies
```

2) Regenerate transfer objects:
```bash
console transfer:generate
```

3) Some files were re-organized, please check if you had overwritten them on project level:

* Renamed `quote-request-cart-summary` into `quote-request-summary`.
* Renamed `quote-request-discount-summary` into `quote-request-summary-discount`.
* Adjusted `page-layout-quote-request` to extend `page-layout-main` template instead of `page-layout-customer`.
* Introduced a new `quoteRequestReference` data property to `quote-request-edit` view.
* Adjusted `quote-request-view` view to extend `page-layout-customer` template instead of `page-layout-quote-request`.
* Removed `quote-request-cart-item` molecule.

*Estimated migration time: ~2h*

## Upgrading from version 1.x.x to version 2.x.x

The only major change of the `QuoteRequestPage 2.x.x` is the dependency update for `spryker/quote-request:^2.0.0`.

Also, transfer property `QuoteRequestTranser::isLatestVersionHidden` was replaced by `QuoteRequestTransfer:isLatestVersionVisible`.

**To migrate do the following:**
1. Update `spryker/quote-request` to version ^2.0.0 by following the steps from [Migration Guide - QuoteRequest](/docs/scos/dev/module-migration-guides/migration-guide-quoterequest.html).
2. Update `spryker-shop/quote-request-page:^2.0.0`

```bash
composer require spryker-shop/quote-request-page: "^2.0.0" --update-with-dependencies
```
3. Generate transfers:

```basg
vendor/bin/console transfer:generate
```
*Estimated migration time: ~1h*
