---
title: Quick Add to Cart + Packaging Units feature integration
description: Quick Add to Cart + Packaging Units allow buying products in different packaging units. This guide describes how to integrate this feature into your project.
last_updated: May 12, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v5/docs/quick-order-packaging-units-feature-integration
originalArticleId: 7dbd4eb8-4722-416c-92f2-10de759fcf8a
redirect_from:
  - /v5/docs/quick-order-packaging-units-feature-integration
  - /v5/docs/en/quick-order-packaging-units-feature-integration
---

## Install Feature Frontend
### Prerequisites
To start feature integration, overview and install the necessary features:
|Name|Version|
|---|---|
|Quick Order|master|
|Packaging Units|master|

### 1) Set up Behavior
#### Set up the Additional Functionality

Enable the following behaviors by registering the plugins:

|Plugin|Specification|Prerequisites|Namespace|
|---|---|---|---|
|`QuickOrderItemDefaultPackagingUnitExpanderPlugin`|Expands `ItemTransfer` with packaging unit data if available.|None|`SprykerShop\Yves\ProductPackagingUnitWidget\Plugin\QuickOrder`|

**src/Pyz/Yves/QuickOrderPage/QuickOrderPageDependencyProvider.php**

```php
<?php
 
namespace Pyz\Yves\QuickOrderPage;
 
use SprykerShop\Yves\ProductPackagingUnitWidget\Plugin\QuickOrder\QuickOrderItemDefaultPackagingUnitExpanderPlugin;
use SprykerShop\Yves\QuickOrderPage\QuickOrderPageDependencyProvider as SprykerQuickOrderPageDependencyProvider;
 
class QuickOrderPageDependencyProvider extends SprykerQuickOrderPageDependencyProvider
{
	/**
	* @return \SprykerShop\Yves\QuickOrderPageExtension\Dependency\Plugin\QuickOrderItemExpanderPluginInterface[]
	*/
	protected function getQuickOrderItemTransferExpanderPlugins(): array
	{
		return [
			new QuickOrderItemDefaultPackagingUnitExpanderPlugin(),
		];
	}
}
```

{% info_block warningBox "Verification" %}
Make the following checks at `https://mysprykershop.com/quick-order`: `QuickOrderItemDefaultPackagingUnitExpanderPlugin` sets default configuration for a product with packaging units:<ol><li>Select a product with packaging units on the **Quick Add To Cart** page and add it to the cart. </li><li>Check `ItemTransfer` in Cart if it has `amount`, `amountSalesUnit`, `amountLeadProduct`, and `productPackagingUnit` properties set.</li></ol>
{% endinfo_block %}
