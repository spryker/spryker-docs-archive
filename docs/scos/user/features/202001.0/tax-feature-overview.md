---
title: Tax feature overview
search: exclude
description: With the Tax feature you can define taxes for the items you sell.
last_updated: Apr 3, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v4/docs/international-tax-rates-sets-1
originalArticleId: 8154d4a6-f229-4f15-bc05-22f1356e7c75
redirect_from:
  - /v4/docs/tax
  - /v4/docs/en/tax
  - /v4/docs/manage-tax-rates-sets
  - /v4/docs/en/manage-tax-rates-sets
  - /v4/docs/international-tax-rates-sets-1
  - /v4/docs/en/international-tax-rates-sets-1
  - /v4/docs/international-tax-rates-sets
  - /v4/docs/en/international-tax-rates-sets
  - /v4/docs/internationalization
  - /v4/docs/en/internationalization
---

The *Tax* feature allows you to define taxes for the items you sell. The feature is represented by two entities: tax rates and tax sets.

The tax rate is the percentage of the sales price that buyer pays as a tax. In the default Spryker implementation, the tax rate is defined per country where the tax applies. See [Managing tax rates](/docs/scos/user/back-office-user-guides/{{page.version}}/administration/tax-rates/managing-tax-rates.html) for details on how to create and manage tax rates for countries in the Back Office.

A tax set is a set of tax rates. You can [define tax sets in the Back office](/docs/scos/user/back-office-user-guides/{{page.version}}/administration/tax-sets/managing-tax-sets.html).

Tax sets can be applied to abstract product, product option and shipment:


| ENTITY | INSTRUCTIONS ON DEFINING TAX SETS FOR THE ENTITY IN THE BACK OFFICE  |
| --- | --- |
| Abstract product | [Defining prices](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/products/manage-abstract-products/creating-abstract-products-and-product-bundles.html) |
| Product option | [Creating a product option](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/product-options/creating-product-options.html) |
| Shipment | [Creating a delivery method](/docs/scos/user/back-office-user-guides/{{page.version}}/administration/delivery-methods/creating-and-managing-delivery-methods.html#creating-a-delivery-method) |

## International tax rates and sets

Align your business with international tax standards by defining tax rates and sets. Determine country-based tax rates for products, options and shipments, that will automatically be applied to the respective shops.

In a tax system, the tax rate is the ratio (usually expressed as a percentage) at which a business, person, items are taxed.

Tax set is a set of tax rates that can be applied to a specific product.

Keeping that in mind, the tax rate is created first.
![Tax rate](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Tax/International+Tax+Rates+&+Sets/tax-rate.gif)

Once the rate is defined, you can attach it to a tax set(s). A tax set can contain from one to many tax rates.
![Tax set](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Tax/International+Tax+Rates+&+Sets/tax-set.gif)

The described values are defined in the **Back Office** > **Taxes** section.

![Tax section](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Tax/International+Tax+Rates+&+Sets/taxes-section.gif)

## Related Business User articles

|BACK OFFICE USER GUIDES|
|---|
| [Get a general idea of the Tax feature](/docs/scos/user/features/{{page.version}}/tax-feature-overview.html) |
| [Manage tax rates](/docs/scos/user/back-office-user-guides/{{page.version}}/administration/tax-rates/managing-tax-rates.html) |
| [Manage tax sets](/docs/scos/user/back-office-user-guides/{{page.version}}/administration/tax-sets/managing-tax-sets.html) |

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Tax feature walkthrough](/docs/scos/dev/feature-walkthroughs/{{page.version}}/tax-feature-walkthrough/tax-feature-walkthrough.html) for developers.

{% endinfo_block %}
