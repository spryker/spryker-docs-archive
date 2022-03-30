---
title: Comments + Order Management feature integration
description: The guide walks you through the process of installing the Comments + Order Management feature into the project.
last_updated: Dec 24, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v3/docs/comments-order-management-feature-integration
originalArticleId: 60dd0202-8764-45ae-95ff-e30f4ea97cd5
redirect_from:
  - /v3/docs/comments-order-management-feature-integration
  - /v3/docs/en/comments-order-management-feature-integration
---

## Install Feature Core
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Comment | 201907.0 |
| Order Management | 201907.0 |

### 1) Install the required modules using Composer
Run the following command(s) to install the required modules:

```bash
composer require spryker/comment-sales-connector:"^1.0.0" --update-with-dependencies
```
{% info_block warningBox "Verification" %}
Make sure that the following modules were installed:<table><thead><tr><th>Module</th><th>Expected Directory</th></tr></thead><tbody><tr><td>`CommentSalesConnector`</td><td>`vendor/spryker/comment-sales-connector`</td></tr></tbody></table>
{% endinfo_block %}

### 2) Set up Configuration
Add the following configuration to your project:

| Configuration | Specification | Namespace |
| --- | --- | --- |
| `SalesConfig::getSalesDetailExternalBlocksUrls()` | Used to display a block with comments related to the order. | `Pyz\Zed\Sales` |

<details open>
<summary markdown='span'>Pyz\Zed\Sales\SalesConfig.php</summary>
    
```php
<?php
 
namespace Pyz\Zed\Sales;
 
use Spryker\Zed\Sales\SalesConfig as SprykerSalesConfig;
 
class SalesConfig extends SprykerSalesConfig
{
	public function getSalesDetailExternalBlocksUrls()
	{
		$projectExternalBlocks = [
			'comment' => '/comment-sales-connector/sales/list',
		];
 
		$externalBlocks = parent::getSalesDetailExternalBlocksUrls();
 
		return array_merge($externalBlocks, $projectExternalBlocks);
	}
}
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make sure that the Order detail page in Zed contains a block with comments.
{% endinfo_block %}

### 3) Set up Transfer Objects
Run the following commands to generate transfer changes:

```bash
console transfer:generate
```

{% info_block warningBox "Verification" %}
Make sure that the following changes have been applied in transfer objects:<table><thead><tr><th>Transfer</th><th>Type</th><th>Event</th><th>Path</th></tr></thead><tbody><tr><td>`Comment`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/Comment`</td></tr><tr><td>`CommentThread`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/CommentThread`</td></tr><tr><td>`CommentFilter`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/CommentFilter`</td></tr><tr><td>`CommentRequest`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/CommentRequest`</td></tr></tbody></table>
{% endinfo_block %}

### 4) Set up Behavior
Register the following plugins:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `CommentThreadOrderExpanderPlugin` | Expands `OrderTransfer` with `CommentThread`. | None | `Spryker\Zed\CommentSalesConnector\Communication\Plugin\Sales` |
| `CommentThreadAttachedCommentOrderPostSavePlugin` | Duplicates `commentThread` from Quote to a new order. | None | `Spryker\Zed\CommentSalesConnector\Communication\Plugin\Sales` |

<details open>
<summary markdown='span'>Pyz\Zed\Sales\SalesDependencyProvider.php</summary>

```php
<?php
 
namespace Pyz\Zed\Sales;
 
use Spryker\Zed\CommentSalesConnector\Communication\Plugin\Sales\CommentThreadOrderExpanderPlugin;
use Spryker\Zed\Sales\SalesDependencyProvider as SprykerSalesDependencyProvider;
 
class SalesDependencyProvider extends SprykerSalesDependencyProvider
{
	/**
	 * @return \Spryker\Zed\SalesExtension\Dependency\Plugin\OrderExpanderPluginInterface[]
	 */
	protected function getOrderHydrationPlugins()
	{
		return [
			new CommentThreadOrderExpanderPlugin(),
		];
	}
}
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make sure that `OrderTransfer::commentThread` contains information about comments when you retrieve an order from the database.
{% endinfo_block %}

<details open>
<summary markdown='span'>Pyz\Zed\Sales\SalesDependencyProvider.php</summary>

```php
<?php
 
namespace Pyz\Zed\Sales;
 
use Spryker\Zed\CommentSalesConnector\Communication\Plugin\Sales\CommentThreadAttachedCommentOrderPostSavePlugin;
use Spryker\Zed\Sales\SalesDependencyProvider as SprykerSalesDependencyProvider;
 
class SalesDependencyProvider extends SprykerSalesDependencyProvider
{
	/**
	 * @return \Spryker\Zed\SalesExtension\Dependency\Plugin\OrderPostSavePluginInterface[]
	 */
	protected function getOrderPostSavePlugins()
	{
		return [
			new CommentThreadAttachedCommentOrderPostSavePlugin(),
		];
	}
}
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make sure that all comments from `QoteTransfer::commentThread` duplicate to a new order after the successful checkout.
{% endinfo_block %}

