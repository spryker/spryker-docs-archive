---
title: Quick Add to Cart + Measurement Units feature integration
description: Quick Add to Cart + Measurement Units allow selling products by any unit of measure with a click. This guide describes how to integrate this feature into your project.
last_updated: Mar 6, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v4/docs/quick-order-measurement-units-feature-integration
originalArticleId: 9903fc5b-7b37-4c2a-ba51-1d683af52295
redirect_from:
  - /v4/docs/quick-order-measurement-units-feature-integration
  - /v4/docs/en/quick-order-measurement-units-feature-integration
---

## Install Feature Frontend
### Prerequisites
To start feature integration, overview and install the necessary features:

|Name|Version|
|---|---|
|Quick Add To Cart|201903.0|
|Measurement units|201903.0|

### 1) Set up Behavior
#### Set up the Additional Functionality

Enable the following behaviors by registering the plugins:
|Plugin|Specification|Prerequisites|Namespace|
|---|---|---|---|
|`QuickOrderFormMeasurementUnitColumnPlugin`|Adds the additional **Measuring Unit** column to a quick order table.|None|`SprykerShop\Yves\QuickOrderPage\Plugin\QuickOrder`|

src/Pyz/Yves/QuickOrderPage/QuickOrderPageDependencyProvider.php

```php
<?php
 
namespace Pyz\Yves\QuickOrderPage;
 
use SprykerShop\Yves\QuickOrderPage\Plugin\QuickOrder\QuickOrderFormMeasurementUnitColumnPlugin;
use SprykerShop\Yves\QuickOrderPage\QuickOrderPageDependencyProvider as SprykerQuickOrderPageDependencyProvider;
 
class QuickOrderPageDependencyProvider extends SprykerQuickOrderPageDependencyProvider
{
    /**
     * @return \SprykerShop\Yves\QuickOrderPageExtension\Dependency\Plugin\QuickOrderFormColumnPluginInterface[]
     */
				protected function getQuickOrderFormColumnPlugins(): array
				{
				return [
				    new QuickOrderFormMeasurementUnitColumnPlugin(),
				];
			}
		}
```

{% info_block warningBox "Verification" %}
Make the following checks at  https://mysprykershop.com/quick-order:<br> `QuickOrderFormMeasurementUnitColumnPlugin` adds the *Measuring Unit* column to the **Quick Add To Cart** page. Check if the column is displayed on the page.
{% endinfo_block %}

|Plugin|Specification|Prerequisites|Namespace|
|---|---|---|---|
|`ProductConcreteTransferBaseMeasurementUnitExpanderPlugin`|Expands the provided array of `ProductConcreteTransfers` with the base measurement unit information (if available) for the product.|None|`Spryker\Client\ProductMeasurementUnitStorage\Plugin\QuickOrder`|

src/Pyz/Client/QuickOrder/QuickOrderDependencyProvider.php

```php
<?php
 
namespace Pyz\Client\QuickOrder;
 
use Spryker\Client\ProductMeasurementUnitStorage\Plugin\QuickOrder\ProductConcreteTransferBaseMeasurementUnitExpanderPlugin;
use Spryker\Client\QuickOrder\QuickOrderDependencyProvider as SprykerQuickOrderDependencyProvider;
 
class QuickOrderDependencyProvider extends SprykerQuickOrderDependencyProvider
{
		/**
		 * @return \Spryker\Client\QuickOrderExtension\Dependency\Plugin\ProductConcreteExpanderPluginInterface[]
		 */
		protected function getProductConcreteExpanderPlugins(): array
		{
			return [
				new ProductConcreteTransferBaseMeasurementUnitExpanderPlugin(),
			];
		}
}
```

{% info_block warningBox "Verification" %}
Make the following checks at  `https://mysprykershop.com/quick-order`: `ProductConcreteTransferBaseMeasurementUnitExpanderPlugin` expands Product Concrete data for Product search on **Quick Add To Cart** page with measurement unit data. Provide an SKU with measurement unit data on the **Quick Add To Cart** page and verify that the default measurement unit data appears in the measurement unit column.
{% endinfo_block %}
