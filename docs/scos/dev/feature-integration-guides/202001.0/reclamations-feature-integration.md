---
title: Reclamations feature integration
search: exclude
last_updated: Mar 6, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v4/docs/reclamations-feature-integration
originalArticleId: da07c7a0-b0a5-4955-9ec5-a4d03434a5d2
redirect_from:
  - /v4/docs/reclamations-feature-integration
  - /v4/docs/en/reclamations-feature-integration
---

## Install Feature Core
### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Order Management | 202001.0 |
| Spryker Core | 202001.0 |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/reclamations: "^202001.0" --update-with-dependencies`
```

{% info_block warningBox “Verification” %}
    
Make sure that the following modules have been installed:
    
| Module | Expected Directory |
| --- | --- |
| `SalesReclamation` | `vendor/spryker/sales-reclamation` |
| `SalesReclamationGui` | `vendor/spryker/sales-reclamation-gui` |

{% endinfo_block %}

### 2) Set up the Database Schema and Transfer Objects

Run the following commands to apply database changes and generate entity and transfer changes:

```bash
console transfer:generate
console propel:install
console transfer:generate
```

{% info_block warningBox “Verification” %}
    
Make sure that the following changes have been applied by checking your database:
    
| Database Entity | Type |
| --- | --- |
| `spy_sales_reclamation` | table |
| `spy_sales_reclamation_item` | table |

{% endinfo_block %}

{% info_block warningBox “Verification” %}
    
Make sure that the following changes were implemented in the transfer objects:
    
| Transfer | Type | Path |
| --- | --- | --- |
| `Reclamation` | class | `src/Generated/Shared/Transfer/ReclamationTransfer` |
| `ReclamationItem` | class | `src/Generated/Shared/Transfer/ReclamationItemTransfer` |
| `ReclamationCreateRequest` | class | `src/Generated/Shared/Transfer/ReclamationCreateRequestTransfer` |
| `SpySalesReclamationEntity` | class | `src/Generated/Shared/Transfer/SpySalesReclamationEntityTransfer` |
| `SpySalesReclamationItemEntity` | class | `src/Generated/Shared/SpySalesReclamationItemEntityTransfer` |

{% endinfo_block %}

### 3) Set up Behavior

Enable the following behaviors by registering the plugins:

|Plugin  |Specification  | Prerequisites |Namespace  |
| --- | --- | --- | --- |
| `ReclamationSalesTablePlugin` | Expands sales order table with a "Claim" button, that redirects to "Create Reclamation" page, where the whole order or its specific items can be reclaimed. | None | `Spryker\Zed\SalesReclamationGui\Communication\Plugin\Sales` |

**src/Pyz/Zed/Sales/SalesDependencyProvider.php**

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

{% info_block warningBox "Verification" %}

Make sure that the sales order table in the back office has a "Claim" button for each order, clicking on which will redirect you to create reclamation page.

{% endinfo_block %}
