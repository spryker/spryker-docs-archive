---
title: Migration guide - MultiCurrency
description: Use the guide to migrate to a newer version of the MultiCurrency module.
last_updated: Jun 16, 2021
template: module-migration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/mg-multi-currency
originalArticleId: 95dd322c-44ae-476b-8587-7773565cafc2
redirect_from:
  - /2021080/docs/mg-multi-currency
  - /2021080/docs/en/mg-multi-currency
  - /docs/mg-multi-currency
  - /docs/en/mg-multi-currency
  - /v1/docs/mg-multi-currency
  - /v1/docs/en/mg-multi-currency
  - /v2/docs/mg-multi-currency
  - /v2/docs/en/mg-multi-currency
  - /v3/docs/mg-multi-currency
  - /v3/docs/en/mg-multi-currency
  - /v4/docs/mg-multi-currency
  - /v4/docs/en/mg-multi-currency
  - /v5/docs/mg-multi-currency
  - /v5/docs/en/mg-multi-currency
  - /v6/docs/mg-multi-currency
  - /v6/docs/en/mg-multi-currency
  - /docs/scos/dev/module-migration-guides/201811.0/migration-guide-multi-currency.html
  - /docs/scos/dev/module-migration-guides/201903.0/migration-guide-multi-currency.html
  - /docs/scos/dev/module-migration-guides/201907.0/migration-guide-multi-currency.html
  - /docs/scos/dev/module-migration-guides/202001.0/migration-guide-multi-currency.html
  - /docs/scos/dev/module-migration-guides/202005.0/migration-guide-multi-currency.html
  - /docs/scos/dev/module-migration-guides/202009.0/migration-guide-multi-currency.html
  - /docs/scos/dev/module-migration-guides/202108.0/migration-guide-multi-currency.html
related:
  - title: Migration guide - Currency
    link: docs/scos/dev/module-migration-guides/migration-guide-currency.html
  - title: Migration guide - Sales
    link: docs/scos/dev/module-migration-guides/migration-guide-sales.html
  - title: Migration guide - Price
    link: docs/scos/dev/module-migration-guides/migration-guide-price.html
  - title: Migration guide - Discount
    link: docs/scos/dev/module-migration-guides/migration-guide-discount.html
  - title: Migration guide - Shipment
    link: docs/scos/dev/module-migration-guides/migration-guide-shipment.html
---

## Migrating System to Multi-Currency

This article provides a whole overview of what needs to be done to have the multi-currency feature running in your Spryker shop. The multi-currency feature affects many Spryker modules so we split it into smaller parts. Here you will find the information that will help get you started with the multi-currency feature.
There is a chance that you already have the multi-currency enabled in some of the modules. In the list below you will find versions of the modules from when it has first been implemented as well as a link to an appropriate migration guide.
First run `composer update spryker/*` to update your all modules to the latest minor version.

1. Infrastructure for multi-currency:
* **Store >= 1.2.***—this is a new module, require it in composer and execute `propel install` for the new databases.
* **Currency >= 3.2.***—see [Migration Guide - Currency](/docs/scos/dev/module-migration-guides/migration-guide-currency.html) for more details.
* **Money >= 2.3.***—we have added a new form of money collection type, required by ZED money form inputs.
* **ZedRequest >= 3.2.***—we have added a new extension point for ZED request to add additional meta data to request `\Spryker\Client\Currency\Plugin\ZedRequestMetaDataProviderPlugin`, which sends currency with each ZED request.

2. The Orders now includes currency iso code, which is used when order is displayed to format price. We have changed `OrderSaver` and how prices are formatted for Order in Yves and Zed:
* **Sales >= 8.***—see [Migration Guide - Sales](/docs/scos/dev/module-migration-guides/migration-guide-sales.html) for more details.
* **Quote >= 1.1.***—stores current currency when quote is persisted.

3. **Discount** module has undergone big changes. Specifically, the way fixed discount calculation works has been changed. The way the amount is entered in Zed form has been changed as well (the amount requires currency now). Decision rules that MUST be built with currency/price mode decision rule include:
* **Discount >= 5.***—see .
* **Calculation >= 4.2.***—we have changed the way the discount amount is aggregated.
* **Cart >= 4.2.***—we have added a new facade method to rebuild cart items when currency is changed. Extension point to watch for cart item rebuild.
* **CartCurrencyConnector** - new module provides plugin for cart rebuilding. <!-- See [Currency configuration](/docs/scos/dev/back-end-development/data-manipulation/datapayload-conversion/multiple-currencies-per-store-configuration.html) for more details.-->
* **ProductDiscountConnector >= 3.2.***—we have changed the way the net price is assigned.
* **ProductLabelDiscountConnector >= 1.2.***—we have changed the way the net price is assigned.
* **ShipmentDiscountConnector >= 1.1.***—we have changed the way the net price is assigned.

4. For Shipment, we have changed the way the default price is assigned (currency-aware). Zed money input form has also been changed to accept multi-currency:
* **Shipment >= 6.***—see [Migration Guide - Shipment](/docs/scos/dev/module-migration-guides/migration-guide-shipment.html).
* **ShipmentCartConnector** - is a new module, which provides plugins for cart to handle cases when currency changed. <!-- add a link See Integration guide for more details.-->

5. In Products, the way the price is entered in Zed has been changed to support multi-currency, price mode as well as price type variants. We have also changed the way the collector collects prices, the way Elasticsearch exports prices, the way the results coming from Elasticsearch are formatted, the way the prices are picked in cart when item is added:
 * **CatalogPriceProductConnector** - we have added new currency aware formatter plugins for formatting prices when reading results from Elasticsearch. See Integration guide for more details.
* **Price >= 5.***—see [Migration Guide - Price](/docs/scos/dev/module-migration-guides/migration-guide-price.html).
* **PriceProduct** - new module handling price product prices. Migration is a part of [Migration Guide - Price](/docs/scos/dev/module-migration-guides/migration-guide-price.html).
* **PriceCartConnector >= 4.***— [Migration Guide - PriceCartConnector](/docs/scos/dev/module-migration-guides/migration-guide-pricecartconnector.html) uses the new PriceProduct module.
* **PriceDataFeed >= 0.2.***—uses the new `PriceProduct` module.
* **ProductBundle >= 4.***—[Migration Guide - ProductBundle](/docs/scos/dev/module-migration-guides/migration-guide-productbundle.html) uses the new `PriceProduct` module, the new plugin to watch cart item reload action.
* **ProductLabelGui >= 2.***—see [Migration Guide - ProductLabelGui](/docs/scos/dev/module-migration-guides/migration-guide-productlabelgui.html).
* **ProductManagement >= 0.9.***—see [Migration Guide - ProductManagement](/docs/scos/dev/module-migration-guides/migration-guide-productmanagement.html). New forms and views have been added.
* **ProductRelation >= 2.***—see [Migration Guide - ProductRelation](/docs/scos/dev/module-migration-guides/migration-guide-productrelation.html).
* **ProductRelationCollector >= 2.***—see [Migration Guide - ProductRelationCollector](/docs/scos/dev/module-migration-guides/migration-guide-productrelationcollector.html).
* **ProductSetGui >= 2.***—see [Migration Guide - ProductSetGui](/docs/scos/dev/module-migration-guides/migration-guide-productsetgui.html).
* **Wishlist >= 2.***—see [Migration Guide - Wishlist](/docs/scos/dev/module-migration-guides/migration-guide-wishlist.html).
* **Search >= 7.0** - see [Migration Guide - Search](/docs/scos/dev/module-migration-guides/migration-guide-search.html).

6. Regarding the Product Options, the way the price is entered in Zed Admin UI has been changed to support multi-currency behavior. Now Collector collects prices by store and cart checkout has been amended to support multi-currency product options.
* **ProductOptionCartConnector >= 5.***—see [Migration Guide - Product Option Cart Connector](/docs/scos/dev/module-migration-guides/migration-guide-productoptioncartconnector.html).
* **ProductOption >= 6.***—see [Migration Guide - Product Option](/docs/scos/dev/module-migration-guides/migration-guide-productoption.html).

Some new configuration options have been made for the whole multi-currency feature: earlier the default price type was defined in environment configuration like `$config[PriceProductConstants::DEFAULT_PRICE_TYPE] = 'DEFAULT'`, now it's moved to: `\Spryker\Shared\PriceProduct\PriceProductConfig::getPriceTypeDefaultName`. Please note that you might get an exception that constant is not found - you can safely remove it, unless you used it in your code. In this case replace `\Spryker\Zed\PriceProduct\Business\PriceProductFacade::getDefaultPriceTypeName` or `\Spryker\Client\PriceProduct\PriceProductClient::getPriceTypeDefaultName` accordingly. Default price mode is defined in `\Spryker\Shared\Price\PriceConfig::getDefaultPriceMode`. Default currency is defined based on `config/Shared/stores.php`, array key `currencyIsoCodes` will be the first item in the list.
