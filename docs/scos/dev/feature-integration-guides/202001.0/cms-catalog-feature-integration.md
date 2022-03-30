---
title: CMS + Catalog feature integration
description: The CMS Page Search Catalog feature allows viewing search results for subcategory pages. The guide describes how to enable the feature in the project.
last_updated: Mar 5, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v4/docs/cms-pages-in-search-results-integration
originalArticleId: e6b727af-7bb7-4dd5-9912-b3c5ac3c3301
redirect_from:
  - /v4/docs/cms-pages-in-search-results-integration
  - /v4/docs/en/cms-pages-in-search-results-integration
---

## Install Feature Core

### Prerequisites

To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Catalog | 202001.0 |
| Cms | 202001.0 |

### 1) Set up Behavior

#### Configure the CMS Page Search Query.

Add the following Query Expander Plugins to your project:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `StoreQueryExpanderPlugin` | Extends a search query by filtering down results to the current Store. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\StoreQueryExpanderPlugin` |
|  `LocalizedQueryExpanderPlugin` | Extends a search query by filtering down results to the current Locale. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\LocalizedQueryExpanderPlugin` |
|  `SortedCmsPageQueryExpanderPlugin` | Extends a search query by sorting parameters. | None |  `\Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\QueryExpander\SortedCmsPageQueryExpanderPlugin` |
|  `PaginatedCmsPageQueryExpanderPlugin` | Extends a search query by pagination parameters. | None |  `\Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\QueryExpander\PaginatedCmsPageQueryExpanderPlugin` |
|  `IsActiveQueryExpanderPlugin` | Extends a search query by filtering down only active results. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveQueryExpanderPlugin` |
|  `IsActiveInDateRangeQueryExpanderPlugin` | Extends a search query by filtering down results to be active by the current date time. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveInDateRangeQueryExpanderPlugin` |

Add the following Result Formatter Plugins to your project:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `SortedCmsPageSearchResultFormatterPlugin` | Formats the sort-related raw search result data. | None |  `\Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\ResultFormatter\SortedCmsPageSearchResultFormatterPlugin` |
|  `PaginatedCmsPageResultFormatterPlugin` | Formats the pagination-related raw search result data. | None |  `\Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\ResultFormatter\PaginatedCmsPageResultFormatterPlugin` |
|  `RawCmsPageSearchResultFormatterPlugin` | Formats the CMS page hits related raw search result data. | None |  `\Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\ResultFormatter\RawCmsPageSearchResultFormatterPlugin` |

**src/Pyz/Client/CmsPageSearch/CmsPageSearchDependencyProvider.php**

```php
<?php

namespace Pyz\Client\CmsPageSearch;

use Spryker\Client\CmsPageSearch\CmsPageSearchDependencyProvider as SprykerCmsPageSearchDependencyProvider;
use Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\QueryExpander\PaginatedCmsPageQueryExpanderPlugin;
use Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\QueryExpander\SortedCmsPageQueryExpanderPlugin;
use Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\ResultFormatter\PaginatedCmsPageResultFormatterPlugin;
use Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\ResultFormatter\RawCmsPageSearchResultFormatterPlugin;
use Spryker\Client\CmsPageSearch\Plugin\Elasticsearch\ResultFormatter\SortedCmsPageSearchResultFormatterPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveInDateRangeQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\LocalizedQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\StoreQueryExpanderPlugin;

class CmsPageSearchDependencyProvider extends SprykerCmsPageSearchDependencyProvider
{
 /**
 * @return \Spryker\Client\Search\Dependency\Plugin\QueryExpanderPluginInterface[]
 */
 protected function createCmsPageSearchQueryExpanderPlugins(): array
 {
 return [
 new StoreQueryExpanderPlugin(),
 new LocalizedQueryExpanderPlugin(),
 new SortedCmsPageQueryExpanderPlugin(),
 new PaginatedCmsPageQueryExpanderPlugin(),
 new IsActiveQueryExpanderPlugin(),
 new IsActiveInDateRangeQueryExpanderPlugin(),
 ];
 }

 /**
 * @return \Spryker\Client\Search\Dependency\Plugin\ResultFormatterPluginInterface[]
 */
 protected function createCmsPageSearchResultFormatterPlugins(): array
 {
 return [
 new SortedCmsPageSearchResultFormatterPlugin(),
 new PaginatedCmsPageResultFormatterPlugin(),
 new RawCmsPageSearchResultFormatterPlugin(),
 ];
 }
}
 ```

{% info_block warningBox "Verification" %}

Once you have finished the full integration of the feature, make sure that the actual CMS page results match the expectations (filtered, sorted, and paginated correctly).

{% endinfo_block %}

#### Configure the CMS Page Search Count Query

Add the following plugins to your project:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `StoreQueryExpanderPlugin` | Extends a search query by filtering down results to the current Store. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\StoreQueryExpanderPlugin` |
|  `LocalizedQueryExpanderPlugin` | Extends a search query by filtering down results to the current Locale. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\LocalizedQueryExpanderPlugin` |
|  `IsActiveQueryExpanderPlugin` | Extends a search query by filtering down only active results. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveQueryExpanderPlugin` |
|  `IsActiveInDateRangeQueryExpanderPlugin` | Extends a search query by filtering down results to be active by the current date time. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveInDateRangeQueryExpanderPlugin` |

**src/Pyz/Client/CmsPageSearch/CmsPageSearchDependencyProvider.php**

```php
<?php

namespace Pyz\Client\CmsPageSearch;

use Spryker\Client\CmsPageSearch\CmsPageSearchDependencyProvider as SprykerCmsPageSearchDependencyProvider;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveInDateRangeQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\LocalizedQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\StoreQueryExpanderPlugin;

class CmsPageSearchDependencyProvider extends SprykerCmsPageSearchDependencyProvider
{
 /**
 * @return \Spryker\Client\Search\Dependency\Plugin\QueryExpanderPluginInterface[]
 */
 protected function createCmsPageSearchCountQueryExpanderPlugins(): array
 {
 return [
 new StoreQueryExpanderPlugin(),
 new LocalizedQueryExpanderPlugin(),
 new IsActiveQueryExpanderPlugin(),
 new IsActiveInDateRangeQueryExpanderPlugin(),
 ];
 }
}
 ```

{% info_block warningBox "Verification" %}

Once you have finished the full integration of the feature, make sure that the actual count of CMS pages as a result matches the expectations (filtered correctly).

{% endinfo_block %}

#### Configure the Catalog Search Count Query

Add the following plugins to your project:

| Plugin | Specification | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `StoreQueryExpanderPlugin` | Extends a search query by filtering down results to the current Store. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\StoreQueryExpanderPlugin` |
|  `LocalizedQueryExpanderPlugin` | Extends a search query by filtering down results to the current Locale. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\LocalizedQueryExpanderPlugin` |
|  `IsActiveQueryExpanderPlugin` | Extends a search query by filtering down only active results. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveQueryExpanderPlugin` |
|  `IsActiveInDateRangeQueryExpanderPlugin` | Extends a search query by filtering down results to be active by the current date time. | None |  `\Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveInDateRangeQueryExpanderPlugin` |

**src/Pyz/Client/Catalog/CatalogDependencyProvider.php**

```php
<?php

namespace Pyz\Client\Catalog;

use Spryker\Client\Catalog\CatalogDependencyProvider as SprykerCatalogDependencyProvider;
use Spryker\Client\CustomerCatalog\Plugin\Search\ProductListQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveInDateRangeQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\IsActiveQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\LocalizedQueryExpanderPlugin;
use Spryker\Client\Search\Plugin\Elasticsearch\QueryExpander\StoreQueryExpanderPlugin;

class CatalogDependencyProvider extends SprykerCatalogDependencyProvider
{
 /**
 * @return \Spryker\Client\Search\Dependency\Plugin\QueryExpanderPluginInterface[]
 */
 protected function createCatalogSearchCountQueryExpanderPlugins(): array
 {
 return [
 new StoreQueryExpanderPlugin(),
 new LocalizedQueryExpanderPlugin(),
 new IsActiveQueryExpanderPlugin(),
 new IsActiveInDateRangeQueryExpanderPlugin(),
 new ProductListQueryExpanderPlugin(),
 ];
 }
}
 ```

{% info_block warningBox "Verification" %}

Once you have finished the full integration of the feature, make sure that the actual count of products as a result matches the expectations (filtered correctly).

{% endinfo_block %}

## Install Feature Frontend

### Prerequisites

To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Catalog | 202001.0 |
| Cms | 202001.0 |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/catalog:"^202001.0" spryker-feature/cms:"^202001.0" spryker-shop/tabs-widget-extension:"^1.0.0" --update-with-dependencies 
```

{% info_block warningBox "Verification" %}

Make sure that the following modules were installed:

|Module|Expected directory|
|--- |--- |
|`CmsSearchPage`|`vendor/spryker-shop/cms-search-page`|
|`TabsWidget`|`vendor/spryker-shop/tabs-widget`|
|`TabsWidgetExtension`|`vendor/spryker-shop/tabs-widget-extension`|

{% endinfo_block %}

### 2) Add Translations

Append glossary according to your language configuration:

src/data/import/glossary.csv

```yaml
global.search.pages,Seiten,de_DE
global.search.pages,Pages,en_US
global.search.results.view,Ansehen,de_DE
global.search.results.view,View,en_US
cms.page.sort.relevance,Nach Relevanz sortieren,de_DE
cms.page.sort.relevance,Sort by relevance,en_US
cms.page.sort.name_asc,Nach Name aufsteigend sortieren,de_DE
cms.page.sort.name_asc,Sort by name ascending,en_US
cms.page.sort.name_desc,Nach Name absteigend sortieren,de_DE
cms.page.sort.name_desc,Sort by name descending,en_US
cms.page.itemsFound,Artikel gefunden,de_DE
cms.page.itemsFound,Items found,en_US
```

Run the following console command to import it 

```bash
shelldata:console data:import glossary 
```
{% info_block warningBox "Verification" %}

Make sure that in the database the configured data is added to the `spy_glossary` table.

{% endinfo_block %}

### 3) Enable Controllers

#### Controller Provider List

Register controller provider(s) to the Yves application:

|Provider|Namespace|Enabled Controller|Specification|
|---|---|---|---|
|`CmsSearchPageControllerProvider`|`\SprykerShop\Yves\CmsSearchPage\Plugin\Provider\CmsSearchPageControllerProvider`|`CmsSearchController`|Provides functionality to execute full-text search for CMS pages.|

**src/Pyz/Yves/ShopApplication/YvesBootstrap.php**

```php
<?php

namespace Pyz\Yves\ShopApplication;

use SprykerShop\Yves\CmsSearchPage\Plugin\Provider\CmsSearchPageControllerProvider;
use SprykerShop\Yves\ShopApplication\YvesBootstrap as SprykerYvesBootstrap;

class YvesBootstrap extends SprykerYvesBootstrap
{
	/**
	* @param bool|null $isSsl
	*
	* @return \SprykerShop\Yves\ShopApplication\Plugin\Provider\AbstractYvesControllerProvider[]
	*/
	protected function getControllerProviderStack($isSsl)
	{
		return [
			new CmsSearchPageControllerProvider($isSsl),
		];
	}
}
			
```

{% info_block warningBox "Verification" %}

Verify the changes by opening the CMS search page with, for example: `http://mysprykershop.com/search/cms`.

{% endinfo_block %}

### 4)Set up Widgets

#### Configure Widgets

Add the following plugins to your project:

|Plugin|Specification|Prerequisites|Namespace|
|---|---|---|---|
|`FullTextSearchProductsTabPlugin`|Adds a tab item to the Catalog Page full-text search results.|None|`\SprykerShop\Yves\CatalogPage\Plugin\FullTextSearchProductsTabPlugin`|`FullTextSearchCmsPageTabPlugin`|Adds a tab item for CMS Search Page full-text search results.|None|`\SprykerShop\Yves\CmsSearchPage\Plugin\FullTextSearchCmsPageTabPlugin`|

**src/Pyz/Yves/TabsWidget/TabsWidgetDependencyProvider.php**

```php
<?php

namespace Pyz\Yves\TabsWidget;

use SprykerShop\Yves\CatalogPage\Plugin\FullTextSearchProductsTabPlugin;
use SprykerShop\Yves\CmsSearchPage\Plugin\FullTextSearchCmsPageTabPlugin;
use SprykerShop\Yves\TabsWidget\TabsWidgetDependencyProvider as SprykerTabsWidgetDependencyProvider;

class TabsWidgetDependencyProvider extends SprykerTabsWidgetDependencyProvider
{
	/**
	* @return \SprykerShop\Yves\TabsWidgetExtension\Plugin\FullTextSearchTabPluginInterface[]
	*/
	protected function createFullTextSearchPlugins(): array
	{
		return [
			new FullTextSearchProductsTabPlugin(),
			new FullTextSearchCmsPageTabPlugin(),
		];
	}
}
```

{% info_block warningBox "Verification" %}

Make sure that one tab item is displayed correctly per each registered plugin, after you have finished the full integration of the feature.

{% endinfo_block %}

#### Enable Widgets

Register the following global widgets:

|Widget|Description|Namespace|
|---|---|---|
|`FullTextSearchTabsWidget`|Displays a tabs component with its items configured by a stack of plugins implementing| `FullTextSearchTabPluginInterface`.|`\SprykerShop\Yves\TabsWidget\Widget\FullTextSearchTabsWidget`|

**src/Pyz/Yves/ShopApplication/ShopApplicationDependencyProvider.php**

```php
<?php

namespace Pyz\Yves\ShopApplication;

use SprykerShop\Yves\ShopApplication\ShopApplicationDependencyProvider as SprykerShopApplicationDependencyProvider;
use SprykerShop\Yves\TabsWidget\Widget\FullTextSearchTabsWidget;

class ShopApplicationDependencyProvider extends SprykerShopApplicationDependencyProvider
{
	/**
	* @return string[]
	*/
	protected function getGlobalWidgets(): array
	{
		return [
			FullTextSearchTabsWidget::class,
		];
	}
}
```

{% info_block warningBox "Verification" %}

Make sure that the following widgets have been registered:

|Module|Test|
|--- |--- |
|`FullTextSearchTabsWidget`|Go to the full-text search page (by searching for something in the search bar and search) for a term that matches some products and CMS pages as well.Make sure that the tabs component displays the activated tab items properly at the top of the search results.|

{% endinfo_block %} 
