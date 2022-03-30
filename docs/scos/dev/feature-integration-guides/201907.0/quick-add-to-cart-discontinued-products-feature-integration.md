---
title: Quick Add to Cart + Discontinued Products feature integration
description: Quick Add to Cart + Discontinued Products allow showing products in cart as "discontinued". This guide describes how to integrate the feature into the project.
last_updated: Dec 24, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v3/docs/quick-order-discontinued-products-feature-integration
originalArticleId: d76d79f0-d0f8-448a-8c3a-1e7b58d10541
redirect_from:
  - /v3/docs/quick-order-discontinued-products-feature-integration
  - /v3/docs/en/quick-order-discontinued-products-feature-integration
---

## Install Feature Core
### Prerequisites
To start feature integration, overview and install the necessary features:

|  Name|Version  |
| --- | --- |
|Quick Add To Cart  |201903.0  |
|Discontinued Products  |  201903.0|

### 1) Set up Behavior
#### Set up the Additional Functionality
Enable the following behaviors by registering the plugins:

|Plugin  |  Specification|  Prerequisites| Namespace |
| --- | --- | --- | --- |
| `ProductDiscontinuedItemValidatorPlugin` |Checks if the provided product SKU is discontinued, if yes - adds an error message.  | None | `Spryker\Client\ProductDiscontinuedStorage\Plugin\QuickOrder` |

<details open>
<summary markdown='span'> src/Pyz/Client/QuickOrder/QuickOrderDependencyProvider.php</summary>

```php
 <?php
 
namespace Pyz\Client\QuickOrder;
 
use Spryker\Client\ProductDiscontinuedStorage\Plugin\QuickOrder\ProductDiscontinuedItemValidatorPlugin;
use Spryker\Client\QuickOrder\QuickOrderDependencyProvider as SprykerQuickOrderDependencyProvider;
 
class QuickOrderDependencyProvider extends SprykerQuickOrderDependencyProvider
{
	/**
	* @return \Spryker\Client\QuickOrderExtension\Dependency\Plugin\ItemValidatorPluginInterface[]
	*/
	protected function getQuickOrderBuildItemValidatorPlugins(): array
	{
		return [
			new ProductDiscontinuedItemValidatorPlugin(),
		];
	}
    }
```

<br>
</details>

{% info_block warningBox "Verification" %}
Make the following checks at `https://mysprykershop.com/quick-order`:<ul><li>`ProductDiscontinuedItemValidatorPlugin`validates discontinued products. Provide the SKU of a discontinued product on the **Quick Add To Cart** page and verify that the error message is displayed and you are not allowed to work with this product.</li></ul>
{% endinfo_block %}

<!-- Last review date: Mar 28, 2019 by Dmitry Lymarenko, Yuliia Boiko -->
