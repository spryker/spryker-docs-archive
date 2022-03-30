---
title: Quick Add to Cart + Non-splittable Products feature integration
description: Install the Quick Add to Cart and Non-splittable Products features in your project.
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v2/docs/quick-order-non-splittable-products-feature
originalArticleId: 9cdccdbf-e85f-49b2-9e4d-c7e9a33ec711
redirect_from:
  - /v2/docs/quick-order-non-splittable-products-feature
  - /v2/docs/en/quick-order-non-splittable-products-feature
---

## Install Feature Core
### Prerequisites

To start feature integration, review and install the necessary features:

|Name|Version|
|---|---|
|Quick Add To Cart|201903.0|
|Non-splittable Products|201903.0|

### 1) Set up Behavior

#### Set up the Additional Functionality

Enable the following behaviors by registering the plugins:

|Plugin|Specification|Prerequisites|Namespace|
|---|---|---|---|
|`ProductQuantityItemValidatorPlugin`|Checks if the provided product quantity has quantity restrictions and provided quantity fits them, if no - adds an error message.|None|`Spryker\Client\ProductQuantityStorage\Plugin\QuickOrder`|

<details open>
<summary markdown='span'>src/Pyz/Client/QuickOrder/QuickOrderDependencyProvider.php</summary>

```php
<?php
 
namespace Pyz\Client\QuickOrder;
 
use Spryker\Client\ProductQuantityStorage\Plugin\QuickOrder\ProductQuantityItemValidatorPlugin;
use Spryker\Client\QuickOrder\QuickOrderDependencyProvider as SprykerQuickOrderDependencyProvider;
 
class QuickOrderDependencyProvider extends SprykerQuickOrderDependencyProvider
{
	/**
	* @return \Spryker\Client\QuickOrderExtension\Dependency\Plugin\ItemValidatorPluginInterface[]
	*/
	protected function getQuickOrderBuildItemValidatorPlugins(): array
	{
		return [
			new ProductQuantityItemValidatorPlugin(),
		];
	}
}		
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make the following checks at https://mysprykershop.com/quick-order:<br>`ProductQuantityItemValidatorPlugin`takes care about quantities restrictions. Provide an SKU with quantity restrictions on the **Quick Add To Cart** page and verify if quantity gets automatically adjusted according to the quantity restrictions.
{% endinfo_block %}
