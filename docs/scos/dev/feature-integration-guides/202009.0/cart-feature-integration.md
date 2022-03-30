---
title: Cart feature integration
description: This guide provides step-by-step instruction for integrating Add product to cart from the Catalog page feature into your project.
last_updated: Apr 9, 2021
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v6/docs/cart-feature-integration
originalArticleId: 53170360-66be-4642-938b-84479d9f1c33
redirect_from:
  - /v6/docs/cart-feature-integration
  - /v6/docs/en/cart-feature-integration
related:
  - title: "Cart module: Reference information"
    link: docs/scos/dev/feature-walkthroughs/page.version/cart-feature-walkthrough/cart-module-reference-information.html
---

{% info_block errorBox %}

The following feature integration guide expects the basic feature to be in place.

The current feature integration guide only adds the [Add product to cart from the Catalog page](/docs/scos/user/features/{{page.version}}/cart-feature-overview/quick-order-from-the-catalog-page-overview.html) functionality.

{% endinfo_block %}

## Install Feature Core

### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Spryker Core | 202009.0 |

### 1) Install the required modules using Composer
Run the following command(s) to install the required modules:
```bash
composer require spryker-feature/cart 202009.0 --update-with-dependencies
```

### 2) Add Translations
Append glossary according to your configuration:

**src/data/import/glossary.csv**
```yaml
global.add-to-cart,In den Warenkorb,de_DE
global.add-to-cart,Add to Cart,en_US
cart_page.error_message.unexpected_error,Unexpected error occurred.,en_US
cart_page.error_message.unexpected_error,Ein unerwarteter Fehler aufgetreten.,de_DE
```

Run the following console command to import data:
```bash
console data:import glossary
```
{% info_block warningBox "Verification" %}

Make sure that above keys and corresponding translations are present in the `spy_glossary_key` and `spy_glossary_translation` tables.

{% endinfo_block %}

## Install Feature Frontend

### Prerequisites
Please overview and install the necessary features before beginning the integration step.
| Name | Version |
| --- | --- |
| Spryker Core | 202009.0 |

### 1) Install the required modules using Composer
Run the following command(s) to install the required modules:
```bash
composer require spryker-feature/cart 202009.0 --update-with-dependencies
```
{% info_block warningBox "Verification" %}

Make sure that the following modules have been installed:

| Module | Expected Directory |
| --- | --- |
| `CartPage` | `vendor/spryker-shop/cart-page` |

{% endinfo_block %}

### 2) Set up Widgets
Register the following widgets:
| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `ProductAbstractAddToCartButtonWidget` | Displays a button for adding the product abstract to the cart in case the product is eligible. | None | `SprykerShop\Yves\CartPage\Widget` |

**src/Pyz/Yves/ShopApplication/ShopApplicationDependencyProvider.php**
```php
<?php
 
namespace Pyz\Yves\ShopApplication;

use SprykerShop\Yves\CartPage\Widget\ProductAbstractAddToCartButtonWidget;
use SprykerShop\Yves\ShopApplication\ShopApplicationDependencyProvider as SprykerShopApplicationDependencyProvider;
 
class ShopApplicationDependencyProvider extends SprykerShopApplicationDependencyProvider
{
    /**
     * @return string[]
     */
    protected function getGlobalWidgets(): array
    {
        return [
            ProductAbstractAddToCartButtonWidget::class,
        ];
    }
}
```
Run the following command to enable Javascript and CSS changes:
```bash
console frontend:yves:build
```
{% info_block warningBox "Verification" %}

Navigate to catalog and find an abstract product with single concrete. You should see a button for adding this concrete product to the cart right from the catalog page.

{% endinfo_block %}

