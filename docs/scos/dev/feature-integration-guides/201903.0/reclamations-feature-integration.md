---
title: Reclamations feature integration
description: The guide walks you through the process of installing the Reclamations feature in your project.
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v2/docs/reclamations-feature-integration
originalArticleId: f7043557-10e4-4fea-905d-6940f4899948
redirect_from:
  - /v2/docs/reclamations-feature-integration
  - /v2/docs/en/reclamations-feature-integration
---

## Install Feature Core
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Order Management | 201903.0 |
| Spryker Core | 201903.0 |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/reclamations: "^201903.0" --update-with-dependencies`
```

<section contenteditable="false" class="warningBox"><div class="content">
    
**Verification**
    
Make sure that the following modules have been installed:
    
| Module | Expected Directory |
| --- | --- |
| `SalesReclamation` | `vendor/spryker/sales-reclamation` |
| `SalesReclamationGui` | `vendor/spryker/sales-reclamation-gui` |
</div></section>

### 2) Set up the Database Schema and Transfer Objects

Run the following commands to apply database changes and generate entity and transfer changes:

```bash
console transfer:generate
console propel:install
console transfer:generate
```

<section contenteditable="false" class="warningBox"><div class="content">
    
**Verification**
    
Make sure that the following changes have been applied by checking your database:
    
| Database Entity | Type |
| --- | --- |
| `spy_sales_reclamation` | table |
| `spy_sales_reclamation_item` | table |

</div></section>

<section contenteditable="false" class="warningBox"><div class="content">
    
**Verification**
    
Make sure that the following changes were implemented in the transfer objects:
    
| Transfer | Type | Path |
| --- | --- | --- |
| `Reclamation` | class | `src/Generated/Shared/Transfer/ReclamationTransfer` |
| `ReclamationItem` | class | `src/Generated/Shared/Transfer/ReclamationItemTransfer` |
| `ReclamationCreateRequest` | class | `src/Generated/Shared/Transfer/ReclamationCreateRequestTransfer` |
| `SpySalesReclamationEntity` | class | `src/Generated/Shared/Transfer/SpySalesReclamationEntityTransfer` |
| `SpySalesReclamationItemEntity` | class | `src/Generated/Shared/SpySalesReclamationItemEntityTransfer` |
</div></section>

### 3) Set up Behavior

Enable the following behaviors by registering the plugins:

|Plugin  |Specification  | Prerequisites |Namespace  |
| --- | --- | --- | --- |
| `ReclamationSalesTablePlugin` | Expands sales order table with a "Claim" button, that redirects to "Create Reclamation" page, where the whole order or its specific items can be reclaimed. | None | `Spryker\Zed\SalesReclamationGui\Communication\Plugin\Sales` |

<details open>
<summary markdown='span'>src/Pyz/Zed/Sales/SalesDependencyProvider.php</summary>

```php
<?php
 
namespace Pyz\Zed\Sales;
 
use Spryker\Zed\Sales\SalesDependencyProvider as SprykerSalesDependencyProvider;
use Spryker\Zed\SalesReclamationGui\Communication\Plugin\Sales\ReclamationSalesTablePlugin;
 
class SalesDependencyProvider extends SprykerSalesDependencyProvider
{
	/**
	 * @return \Spryker\Zed\SalesExtension\Dependency\Plugin\SalesTablePluginInterface[]
	 */
	protected function getSalesTablePlugins()
	{
		return [
			new ReclamationSalesTablePlugin(),
		];
	}
}
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make sure that the sales order table in the back office has a "Claim" button for each order, clicking on which will redirect you to create reclamation page.
{% endinfo_block %}
