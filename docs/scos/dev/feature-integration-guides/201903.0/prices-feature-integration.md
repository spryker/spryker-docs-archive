---
title: Prices feature integration
description: The Volume Prices Feature allows setting specific prices for units based on quantities. The guide describes how to integrate the feature into your project.
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v2/docs/prices-feature-integration-201903
originalArticleId: 7b32ae6f-1cc5-4bda-9df6-165c35fd2377
redirect_from:
  - /v2/docs/prices-feature-integration-201903
  - /v2/docs/en/prices-feature-integration-201903
related:
  - title: Volume Prices Feature Overview
    link: docs/scos/user/features/page.version/prices-feature-overview/volume-prices-overview.html
---

{% info_block errorBox "Attention!" %}
The following feature integration guide expects the basic feature to be in place.The current feature integration guide only adds the **Volume Prices** functionality.
{% endinfo_block %}

## Install Feature Core

### Prerequisites

To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Spryker Core | 201903.0 |
| Prices | 201903.0 |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:
 ```bash
 composer require spryker-feature/prices: "^201903.0" --update-with-dependencies
 ```

{% info_block warningBox "Verification" %}
Make sure that the following modules were installed:<table><thead><tr><th>Module</th><th>Expected Directory</th></tr></thead><tbody><tr><td>`PriceProductVolume`</td><td>`vendor/spryker/price-product-volume`</td></tr><tr><td>`PriceProductDataImport`</td><td>`vendor/spryker/price-product-data-import`</td></tr></tbody></table>
{% endinfo_block %}

### 2) Set up the Transfer Objects

Run the following commands to generate transfer changes:
 ```bash
 console transfer:generate
 ```

{% info_block warningBox "Verification" %}
Make sure that the following changes have been applied to transfer objects:<table><thead><tr><th>Transfer</th><th>Type</th><th>Event</th><th>Path</th></tr></thead><tbody><tr><td>`PriceProduct.volumeQuantity`</td><td>property</td><td>created</td><td>`src/Generated/Shared/Transfer/PriceProductTransfer`</td></tr><tr><td>`PriceProductVolume`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/PriceProductVolumeTransfer`</td></tr><tr><td>`PriceProductVolumeCollection`</td><td>class</td><td>created</td><td>`src/Generated/Shared/Transfer/PriceProductVolumeCollectionTransfer`</td></tr></tbody></table>
{% endinfo_block %}

### 3) Import Data

#### Import Volume Prices

{% info_block infoBox "Note" %}
The following imported entities will be used as *productvol* in Spryker OS.
{% endinfo_block %}

Prepare your data according to your requirements using our demo data:
<details open>
    <summary markdown='span'>src/data/import/product_price.csv</summary>

```yaml           abstract_sku,concrete_sku,price_type,store,currency,value_net,value_gross,price_data.volume_prices
193,,DEFAULT,DE,EUR,16195,17994,"[{""quantity"":5,""net_price"":150,""gross_price"":165}, {""quantity"":10,""net_price"":145,""gross_price"":158}, {""quantity"":20,""net_price"":140,""gross_price"":152}]"
195,,DEFAULT,DE,CHF,40848,45387,"[{""quantity"":3,""net_price"":350,""gross_price"":385}, {""quantity"":8,""net_price"":340,""gross_price"":375}]"
194,,DEFAULT,AT,EUR,20780,23089,"[{""quantity"":5,""net_price"":265,""gross_price"":295}, {""quantity"":10,""net_price"":275,""gross_price"":310}, {""quantity"":20,""net_price"":285,""gross_price"":320}]"
```
<br>
</details>

| Column | REQUIRED? | Data Type | Data Example | Data Explanation |
| --- | --- | --- | --- | --- |
|  `abstract_sku` | optional | string | 193 | Either `abstract_sku` or `concrete_sku` should exist to attach the given prices to the correct product. |
|  `concrete_sku` | optional | string | 117_29890338 | Either `abstract_sku` or `concrete_sku` should exist to attach the given prices to the correct product. |
|  `price_type` | mandatory | string | DEFAULT | None |
| store | mandatory | string | DE | Store in which the specific product has that specific price. |
| currency | mandatory | string | EUR | Currency in which the specific product has that specific price. |
|  `value_net` | mandatory | integer | 10200 | Net (after tax is applied) price in cents. |
|  `value_gross` | mandatory | integer | 12000 | Gross (before tax is applied) price in cents. |
|  `price_data.volume_prices` | optional | json string |  "[{""quantity"":5,""net_price"":150,""gross_price"":165}]" | JSON description of the prices when the quantity is changed (volume-based pricing). In the given example, the product bought, when it has a quantity of less than 5, uses the normal price, but it uses this Volume Price when the quantity is greater than 5. |

Register the following plugin to enable data import:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `PriceProductDataImportPlugin` | Imports demo product price data into the database. | None |  `Spryker\Zed\PriceProductDataImport\Communication\Plugin` |

<details open>
    <summary markdown='span'>src/Pyz/Zed/DataImport/DataImportDependencyProvider.php</summary>

```php
 <?php

namespace Pyz\Zed\DataImport;

use Spryker\Zed\DataImport\DataImportDependencyProvider as SprykerDataImportDependencyProvider;
use Spryker\Zed\PriceProductDataImport\Communication\Plugin\PriceProductDataImportPlugin;

class DataImportDependencyProvider extends SprykerDataImportDependencyProvider
{
	protected function getDataImporterPlugins(): array
	{
		return [
			new PriceProductDataImportPlugin(),
		];
	}
}
```
<br>
</details>

Run the following console command to import data:
 ```bash
console data:import price-product 
```

{% info_block warningBox "Verification" %}
Make sure that the configured data is added to the `spy_product_price` table in the database.
{% endinfo_block %}

### 4) Set up Behavior

Enable the following behaviors by registering the plugins:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `PriceProductVolumeExtractorPlugin` | Provides the ability to extract Volume Prices from an array of `PriceProductTransfers` for abstract or concrete products to show them to the customer on the Frontend side during the buying process. | None |  `Spryker\Client\PriceProductVolume\Plugin\PriceProductStorageExtension` |
|  `PriceProductVolumeExtractorPlugin` | Provides the ability to extract Volume Prices from an array of `PriceProductTransfers` for abstract or concrete products to validate prices when adding items to cart or to validate prices on the backend side. | None |  `Spryker\Zed\PriceProductVolume\Communication\Plugin\PriceProductExtension` |
|  `PriceProductVolumeFilterPlugin` | Provides the ability to decide based on the selected product quantity, which `PriceProduct` should be chosen based on the Volume Prices set. | None |  `Spryker\Service\PriceProductVolume\Plugin\PriceProductExtension` |

<details open>
<summary markdown='span'>src/Pyz/Zed/PriceProduct/PriceProductDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\PriceProduct;

use Spryker\Zed\PriceProduct\PriceProductDependencyProvider as SprykerPriceProductDependencyProvider;
use Spryker\Zed\PriceProductVolume\Communication\Plugin\PriceProductExtension\PriceProductVolumeExtractorPlugin;

class PriceProductDependencyProvider extends SprykerPriceProductDependencyProvider
{
	/**
	* @return \Spryker\Zed\PriceProductExtension\Dependency\Plugin\PriceProductReaderPricesExtractorPluginInterface[]
	*/
	protected function getPriceProductPricesExtractorPlugins(): array
	{
		return [
			new PriceProductVolumeExtractorPlugin(),
		];
	}
}
```
<br>
</details>

<details open>
<summary markdown='span'>src/Pyz/Client/PriceProductStorage/PriceProductStorageDependencyProvider.php</summary>

 ```php
<?php

namespace Pyz\Client\PriceProductStorage;

use Spryker\Client\PriceProductStorage\PriceProductStorageDependencyProvider as SprykerPriceProductStorageDependencyProvider;
use Spryker\Client\PriceProductVolume\Plugin\PriceProductStorageExtension\PriceProductVolumeExtractorPlugin;

class PriceProductStorageDependencyProvider extends SprykerPriceProductStorageDependencyProvider
{
	/**
	* @return \Spryker\Client\PriceProductStorageExtension\Dependency\Plugin\PriceProductStoragePricesExtractorPluginInterface[]
	*/
	protected function getPriceProductPricesExtractorPlugins(): array
	{
		return [
			new PriceProductVolumeExtractorPlugin(),
		];
	}
}

```
<br>
</details>

<details open>
<summary markdown='span'>src/Pyz/Service/PriceProduct/PriceProductDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Service\PriceProduct;

use Spryker\Service\PriceProduct\PriceProductDependencyProvider as SprykerPriceProductDependencyProvider;
use Spryker\Service\PriceProductVolume\Plugin\PriceProductExtension\PriceProductVolumeFilterPlugin;

class PriceProductDependencyProvider extends SprykerPriceProductDependencyProvider
{
	/**
	* {@inheritdoc}
	*
	* @return \Spryker\Service\PriceProductExtension\Dependency\Plugin\PriceProductFilterPluginInterface[]
	*/
	protected function getPriceProductDecisionPlugins(): array
	{
		return array_merge([
			new PriceProductVolumeFilterPlugin(),
		], parent::getPriceProductDecisionPlugins());
	}
}
```
<br>
</details>

{% info_block warningBox "Verification" %}
Go to the Product Detail page of the product with the Volume Prices set, update the quantity to meet any of Volume Prices boundaries and check the price. Then, add the product to the cart and if the item price in cart remains the same as it was on the Product Detail page, the plugins are installed.
{% endinfo_block %}

## Install Feature Frontend

### Prerequisites

Please overview and install the necessary features before beginning the integration step.

| Name | Version |
| --- | --- |
| Spryker Core E-commerce | 201903.0 |
| Prices | 201903.0 |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:
 ```bash
composer require spryker-feature/prices: "^201903.0" --update-with-dependencies
```

{% info_block warningBox "Verification" %}
Make sure that the following modules were installed:<table><thead><tr><th>Module</th><th>Expected Directory</th></tr></thead><tbody><tr><td>`PriceProductVolumeWidget`</td><td>`vendor/spryker-shop/price-product-volume-widget`</td></tr></tbody></table>
{% endinfo_block %}

### 2) Add Translations

Append glossary according to your configuration:
<details open>
<summary markdown='span'>src/data/import/glossary.csv</summary>

```yaml
page.detail.volume_price.quantity,Quantity,en_US
page.detail.volume_price.quantity,Anzahl,de_DE
page.detail.volume_price.price,Price,en_US
page.detail.volume_price.price,Preis,de_DE
```
<br>
</details>

Run the following console command to import data:
 ```bash
console data:import glossary
```

{% info_block warningBox "Verification" %}
Make sure that in the database the configured data are added to the `spy_glossary` table.
{% endinfo_block %}

### 3) Set up Widgets

Enable Global Widgets:

| Widget | Description | Namespace |
| --- | --- | --- |
|  `ProductPriceVolumeWidget` | Shows a table of Volume Prices for a product that contains the following columns: quantity and price for that quantity threshold. |  `SprykerShop\Yves\PriceProductVolumeWidget\Widget` |

<details open>
<summary markdown='span'>src/Pyz/Yves/ShopApplication/ShopApplicationDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Yves\ShopApplication;

use SprykerShop\Yves\ShopApplication\ShopApplicationDependencyProvider as SprykerShopApplicationDependencyProvider;
use SprykerShop\Yves\PriceProductVolumeWidget\Widget\ProductPriceVolumeWidget;

class ShopApplicationDependencyProvider extends SprykerShopApplicationDependencyProvider
{
	/**
	* @return string[]
	*/
	protected function getGlobalWidgets(): array
	{
		return [
			ProductPriceVolumeWidget::class,
		];
	}
}
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make sure that the following widgets were registered:<table><thead><tr><th>Module</th><th>Test</th></tr></thead><tbody><tr><td>`ProductPriceVolumeWidget`</td><td>Go to the Product Detail page for a product with the Volume Prices set, and view the table in the detail area that contains the Volume Prices data.</td></tr></tbody></table>
{% endinfo_block %}
