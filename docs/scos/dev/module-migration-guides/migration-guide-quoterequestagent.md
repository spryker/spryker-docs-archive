---
title: Migration guide - QuoteRequestAgent
last_updated: Jun 16, 2021
template: module-migration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/mg-quoterequestagent
originalArticleId: 0cad813f-35c3-4e52-8421-b7b97b989479
redirect_from:
  - /2021080/docs/mg-quoterequestagent
  - /2021080/docs/en/mg-quoterequestagent
  - /docs/mg-quoterequestagent
  - /docs/en/mg-quoterequestagent
  - /v3/docs/mg-quoterequestagent
  - /v3/docs/en/mg-quoterequestagent
  - /v4/docs/mg-quoterequestagent
  - /v4/docs/en/mg-quoterequestagent
  - /v5/docs/mg-quoterequestagent
  - /v5/docs/en/mg-quoterequestagent
  - /v6/docs/mg-quoterequestagent
  - /v6/docs/en/mg-quoterequestagent
  - /docs/scos/dev/module-migration-guides/201907.0/migration-guide-quoterequestagent.html
  - /docs/scos/dev/module-migration-guides/202001.0/migration-guide-quoterequestagent.html
  - /docs/scos/dev/module-migration-guides/202005.0/migration-guide-quoterequestagent.html
  - /docs/scos/dev/module-migration-guides/202009.0/migration-guide-quoterequestagent.html
  - /docs/scos/dev/module-migration-guides/202108.0/migration-guide-quoterequestagent.html
---

## Upgrading from version 2.x.x to version 3.x.x

In this new version of the `QuoteRequestAgentPage` module, we have added support of shipment costs. You can find more details about the changes on the [QuoteRequestAgentPage module release page](https://github.com/spryker-shop/quote-request-agent-page/releases). The major changes are:

* Added new dependency spryker/shipment:^8.4.0.
* Added new dependency spryker/step-engine:^3.3.0.
* Added new dependency spryker/messenger:^3.0.0.
* Added new dependency spryker/persistent-cart:^3.0.0.
* Removed several twig files.

**To migrate the module `QuoteRequestAgent` from version 2.0.0 to 3.0.0, do the following:**

1) Update the `QuoteRequestPage` module:
```bash
composer require spryker-shop/quote-request-agent-page: "^3.0.0" --update-with-dependencies
```

2) Regenerate transfer objects:
```bash
console transfer:generate
```

3) Some files were re-organized, please check if you had overwritten them on project level:

* Adjusted `source-price-form` molecule to remove deprecated `priceFiled` data property.
* Adjusted `page-layout-quote-request` template to extend `page-layout-quote-request` template from `QuoteRequestPage` module instead of `page-layout-agent`.
* Adjusted `quote-request-create` view to extend `page-layout-agent` template from `AgentPage` module instead of `page-layout-quote-request`.
* Adjusted `quote-request-create` view to update title glossary key.
* Adjusted `quote-request-edit-items-confirm` view to extend `page-layout-confirmation` template instead of `page-layout-quote-request`.
* Adjusted `quote-request-view` view to extend `page-layout-agent` template instead of `page-layout-quote-request`.

*Estimated migration time: ~2h*

## Upgrading from version 1.x.x to version 2.x.x

The one major change of `QuoteRequestAgent` 2.x.x is the dependency update for `spryker/quote-request:^2.0.0`.

**To migrate the module `QuoteRequestAgent` from version 1.0.0 to 2.0.0, do the following:**

1. Update `spryker/quote-request:^2.0.` by following the steps from the [Migration Guide - QuoteRequest](/docs/scos/dev/module-migration-guides/migration-guide-quoterequest.html)
2. Update `spryker/quote-request-agent:^2.0.0`:

```bash
composer require spryker/quote-request-agent: "^2.0.0" --update-with-dependencies
```

3. To generate transfers, run the following command:

```bash
vendor/bin/console transfer:generate
```

*Estimated migration time: ~1h*
