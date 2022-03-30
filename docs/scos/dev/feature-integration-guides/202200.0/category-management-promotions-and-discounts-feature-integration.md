---
title: Category Management + Promotions & Discounts feature integration
description: Add the "category" parameter to calculation and conditions queries in the Promotions & Discounts feature.
last_updated: Jan 11, 2022
template: feature-integration-guide-template
---

This document describes how to add the `category` parameter to calculation and conditions queries in the [Promotions & Discounts](/docs/scos/user/features/{{page.version}}/promotions-discounts-feature-overview.html) feature.

## Install feature core

Follow the steps below to install the feature core.

### Prerequisites

To start feature integration, integrate the required features:

| NAME | VERSION | INTEGRATION GUIDE |
| --- | --- | --- |
| Promotions & Discounts | {{page.version}} | [Promotions & Discounts feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/promotions-and-discounts-feature-integration.html) |
| Category Management | {{page.version}} | [Category Management feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/category-management-feature-integration.html) |
| Spryker Core | {{page.version}} | [Spryker Сore feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/spryker-core-feature-integration.html) |

### 1) Set up behavior

Set up the following behaviors:

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE |
| --- | --- | --- | --- |
| CategoryDecisionRulePlugin | Checks if the category matches the clause. | None | Spryker\Zed\CategoryDiscountConnector\Communication\Plugin\Discount |
| CategoryDiscountableItemCollectorPlugin | Collects discountable items from the given quote by item categories. | None | Spryker\Zed\CategoryDiscountConnector\Communication\Plugin\Discount |

**src/Pyz/Zed/Discount/DiscountDependencyProvider.php**

```php
<?php

namespace Pyz\Zed\Discount;

use Spryker\Zed\CategoryDiscountConnector\Communication\Plugin\Discount\CategoryDecisionRulePlugin;
use Spryker\Zed\CategoryDiscountConnector\Communication\Plugin\Discount\CategoryDiscountableItemCollectorPlugin;
use Spryker\Zed\Discount\DiscountDependencyProvider as SprykerDiscountDependencyProvider;

class DiscountDependencyProvider extends SprykerDiscountDependencyProvider
{
    /**
     * @return array<\Spryker\Zed\DiscountExtension\Dependency\Plugin\DecisionRulePluginInterface>
     */
    protected function getDecisionRulePlugins(): array
    {
        return array_merge(parent::getDecisionRulePlugins(), [
            new CategoryDecisionRulePlugin(),
        ]);
    }

    /**
     * @return array<\Spryker\Zed\DiscountExtension\Dependency\Plugin\DiscountableItemCollectorPluginInterface>
     */
    protected function getCollectorPlugins(): array
    {
        return array_merge(parent::getCollectorPlugins(), [
            new CategoryDiscountableItemCollectorPlugin(),
        ]);
    }
}
```

{% info_block warningBox "Verification" %}

Ensure that the plugins work correctly:

1. [Create a discount](/docs/scos/user/back-office-user-guides/{{page.version}}/merchandising/discount/creating-cart-rules.html) and define its condition as a query string with a *category* field.
2. Add a product assigned to the defined category to the cart.
3. The discount should be applied to the cart.

{% endinfo_block %}


### 2) Build Zed UI frontend

Enable Javascript and CSS changes for Zed:

```bash
console frontend:zed:build
```
