---
title: Customer Account Management + Order Management feature integration
description: This guide provides step-by-step instruction on integrating Customer Account Management + Order Management feature into the Spryker-based project.
last_updated: Aug 27, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v6/docs/customer-account-management-order-management-feature-integration
originalArticleId: 52110a13-9b4e-4003-9f55-7a0507b37a67
redirect_from:
  - /v6/docs/customer-account-management-order-management-feature-integration
  - /v6/docs/en/customer-account-management-order-management-feature-integration
---

## Install Feature Core

### Prerequisites
To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Customer Account Management | master |
| Order Management | master |
| Spryker Core | master |

### 1) Set up Configuration
To enable order search functionality, adjust config as shown below.

**src/Pyz/Yves/CustomerPage/CustomerPageConfig.php**

```php
<?php

namespace Pyz\Yves\CustomerPage;

use SprykerShop\Yves\CustomerPage\CustomerPageConfig as SprykerCustomerPageConfig;

class CustomerPageConfig extends SprykerCustomerPageConfig
{
    protected const IS_ORDER_HISTORY_SEARCH_ENABLED = true;
}
```
{% info_block warningBox "Verification" %}

Make sure you see the order search form at the Order History page.

{% endinfo_block %}

### 2) Add Translations
Append glossary according to your configuration:

**src/data/import/glossary.csv**

```yaml
customer.order.number_of_items,No. of Items,en_US
customer.order.number_of_items,Anzahl der Artikel,de_DE
customer.order.reference,Reference,en_US
customer.order.reference,Referenz,de_DE
customer.order.email,Email,en_US
customer.order.email,E-Mail-Adresse,de_DE
customer.order_history.search_type.all,All,en_US
customer.order_history.search_type.all,Alle,de_DE
customer.order_history.search_type.orderReference,Order Reference,en_US
customer.order_history.search_type.orderReference,Bestellnummer,de_DE
customer.order_history.search_type.itemName,Product Name,en_US
customer.order_history.search_type.itemName,Produktname,de_DE
customer.order_history.search_type.itemSku,Product SKU,en_US
customer.order_history.search_type.itemSku,Produkt-SKU,de_DE
customer.order_history.search,Search,en_US
customer.order_history.search,Suchen,de_DE
customer.order_history.date_from,From,en_US
customer.order_history.date_from,Von,de_DE
customer.order_history.date_to,To,en_US
customer.order_history.date_to,Bis,de_DE
customer.order_history.apply,Apply,en_US
customer.order_history.apply,Anwenden,de_DE
customer.order_history.is_order_items_visible,Show products in search results,en_US
customer.order_history.is_order_items_visible,Produkte in Suchergebnissen anzeigen,de_DE
customer.order_history.active_filters,Active Filters:,en_US
customer.order_history.active_filters,Aktive Filter:,de_DE
customer.order_history.reset_all,Reset All,en_US
customer.order_history.reset_all,Alles zurücksetzen,de_DE
```

Run the following console command to import data:
```bash
console data:import glossary
```
{% info_block warningBox "Verification" %}

Make sure that in the database the configured data are added to the `spy_glossary` table.

{% endinfo_block %}
