---
title: Comments + Persistent Cart feature integration
description: The guide walks you through the process of integrating the Comments + Persistent Cart feature into the project.
last_updated: Dec 24, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v3/docs/comments-persistent-cart-feature-integration
originalArticleId: 6555d893-0341-400d-8436-67ce7f5532e1
redirect_from:
  - /v3/docs/comments-persistent-cart-feature-integration
  - /v3/docs/en/comments-persistent-cart-feature-integration
---

## Install Feature Core
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Comments | 201907.0 |
| Persistent Cart | 201907.0 |

### 1) Set up Behavior
Register the following plugins:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `CommentThreadQuoteExpanderPlugin` | Expands quote transfer with `CommentThread`. | None | `Spryker\Zed\Comment\Communication\Plugin\Quote` |

<details open>
<summary markdown='span'>Pyz\Zed\Quote\QuoteDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\Quote;
 
use Spryker\Zed\Comment\Communication\Plugin\Quote\CommentThreadQuoteExpanderPlugin;
use Spryker\Zed\Quote\QuoteDependencyProvider as SprykerQuoteDependencyProvider;
 
class QuoteDependencyProvider extends SprykerQuoteDependencyProvider
{
	/**
	 * @return \Spryker\Zed\QuoteExtension\Dependency\Plugin\QuoteExpanderPluginInterface[]
	 */
	protected function getQuoteExpanderPlugins(): array
	{
		return [
			new CommentThreadQuoteExpanderPlugin(),
		];
	}
}
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make sure that `QuoteTransfer::commentThread` contains information about comments when you retrieve a quote from the database.
{% endinfo_block %}

## Install Feature Frontend
### Prerequisites
Please overview and install the necessary features before beginning the integration step.

| Name | Version |
| --- | --- |
| Comments | 201907.0 |
| Cart | 201907.0 |

### 1) Set up Behavior
Register the following plugins:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
| `CartCommentThreadAfterOperationStrategyPlugin` | Updates a session quote with the comment thread. | None | `SprykerShop\Yves\CartPage\Plugin\CommentWidget` |

<details open>
<summary markdown='span'>Pyz\Yves\CommentWidget\CommentWidgetDependencyProvider.php</summary>

```php
<?php
 
namespace Pyz\Yves\CommentWidget;
 
use SprykerShop\Yves\CartPage\Plugin\CommentWidget\CartCommentThreadAfterOperationStrategyPlugin;
use SprykerShop\Yves\CommentWidget\CommentWidgetDependencyProvider as SprykerShopCommentDependencyProvider;
 
class CommentWidgetDependencyProvider extends SprykerShopCommentDependencyProvider
{
	/**
	 * @return \SprykerShop\Yves\CommentWidgetExtension\Dependency\Plugin\CommentThreadAfterOperationStrategyPluginInterface[]
	 */
	protected function getCommentThreadAfterOperationStrategyPlugins(): array
	{
		return [
			new CartCommentThreadAfterOperationStrategyPlugin(),
		];
	}
}
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make sure that add/update/remove actions update a session quote with the latest comment thread.
{% endinfo_block %}
