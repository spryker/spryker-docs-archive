---
title: Migration guide - Search
description: Use the guide to learn how to update the Search module to a newer version.
last_updated: Jun 16, 2021
template: module-migration-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/mg-search
originalArticleId: 2af7d4ac-4e84-42ff-aba5-95dae82c6856
redirect_from:
  - /2021080/docs/mg-search
  - /2021080/docs/en/mg-search
  - /docs/mg-search
  - /docs/en/mg-search
  - /v1/docs/mg-search
  - /v1/docs/en/mg-search
  - /v2/docs/mg-search
  - /v2/docs/en/mg-search
  - /v3/docs/mg-search
  - /v3/docs/en/mg-search
  - /v4/docs/mg-search
  - /v4/docs/en/mg-search
  - /v5/docs/mg-search
  - /v5/docs/en/mg-search
  - /v6/docs/mg-search
  - /v6/docs/en/mg-search
  - /docs/scos/dev/module-migration-guides/201811.0/migration-guide-search.html
  - /docs/scos/dev/module-migration-guides/201903.0/migration-guide-search.html
  - /docs/scos/dev/module-migration-guides/201907.0/migration-guide-search.html
  - /docs/scos/dev/module-migration-guides/202001.0/migration-guide-search.html
  - /docs/scos/dev/module-migration-guides/202005.0/migration-guide-search.html
  - /docs/scos/dev/module-migration-guides/202009.0/migration-guide-search.html
  - /docs/scos/dev/module-migration-guides/202108.0/migration-guide-search.html
---

## Upgrading from version 8.9.* to version 8.10.*

{% info_block errorBox "Prerequisites" %}

This migration guide is a part of the [Search migration effort](/docs/scos/dev/migration-concepts/search-migration-concept/search-migration-concept.html).

{% endinfo_block %}

To upgrade the module, do the following:
1. Install and/or update the modules with composer:
```bash
composer update spryker/search --with-dependencies
composer require spryker/search-elasticsearch
```
2. Regenerate transfer classes:
```bash
console transfer:generate
```
3. Adjust all project-level implementations of `Spryker\Client\Search\Dependency\Plugin\QueryInterface`. First, change `Spryker\Client\Search\Dependency\Plugin\QueryInterface` to `Spryker\Client\SearchExtension\Dependency\Plugin\QueryInterface`. This does not require changing any implementation details. After that implement `\Spryker\Client\SearchExtension\Dependency\Plugin\SearchContextAwareQueryInterface` as described in the [Search Migration Concept](/docs/scos/dev/migration-concepts/search-migration-concept/search-migration-concept.html#searching-for-data).
4. Remove `Pyz\Client\Search\SearchDependencyProvider::createSearchConfigBuilderPlugin()`.
5. Remove `Pyz\Client\Search\SearchDependencyProvider::createSearchConfigExpanderPlugins()`.
6. Enable `ElasticsearchSearchAdapterPlugin` and `ElasticsearchSearchContextExpanderPlugin` in `Pyz\Client\Search\SearchDependencyProvider`:

**Pyz\Client\Search**

```php
...
use Spryker\Client\SearchElasticsearch\Plugin\ElasticsearchSearchAdapterPlugin;
use Spryker\Client\SearchElasticsearch\Plugin\ElasticsearchSearchContextExpanderPlugin;

class SearchDependencyProvider extends SprykerSearchDependencyProvider
{
    ...
    /**
     * @return \Spryker\Client\SearchExtension\Dependency\Plugin\SearchAdapterPluginInterface[]
     */
    protected function getClientAdapterPlugins(): array
    {
        return [
            new ElasticsearchSearchAdapterPlugin(),
        ];
    }

    /**
     * @return \Spryker\Client\SearchExtension\Dependency\Plugin\SearchContextExpanderPluginInterface[]
     */
    protected function getSearchContextExpanderPlugins(): array
    {
        return [
            new ElasticsearchSearchContextExpanderPlugin(),
        ];
    }
    ...
}
```

7. Remove `Pyz\Zed\Search\SearchDependencyProvider::getSearchPageMapPlugins()`.

8. Enable `ElasticsearchIndexInstallerPlugin` and `ElasticsearchIndexMapInstallerPlugin` in `Pyz\Zed\Search\SearchDependencyProvider`:

**Pyz\Zed\Search**

```php
<?php

namespace Pyz\Zed\Search;

...
use Spryker\Zed\Search\SearchDependencyProvider as SprykerSearchDependencyProvider;
use Spryker\Zed\SearchElasticsearch\Communication\Plugin\Search\ElasticsearchIndexInstallerPlugin;
use Spryker\Zed\SearchElasticsearch\Communication\Plugin\Search\ElasticsearchIndexMapInstallerPlugin;

class SearchDependencyProvider extends SprykerSearchDependencyProvider
{
    /**
     * @return \Spryker\Zed\SearchExtension\Dependency\Plugin\InstallPluginInterface[]
     */
    protected function getSearchSourceInstallerPlugins(): array
    {
        return [
            new ElasticsearchIndexInstallerPlugin(),
        ];
    }
    /**
     * @return \Spryker\Zed\SearchExtension\Dependency\Plugin\InstallPluginInterface[]
     */
    protected function getSearchMapInstallerPlugins(): array
    {
        return [
            new ElasticsearchIndexMapInstallerPlugin(),
        ];
    }
}
```

9. Configure the list of sources, which are being handled by Elasticsearch, on the project level.

```php
<?php

namespace Pyz\Shared\SearchElasticsearch;
use Spryker\Shared\SearchElasticsearch\SearchElasticsearchConfig as SprykerSearchElasticsearchConfig;

class SearchElasticsearchConfig extends SprykerSearchElasticsearchConfig
{
    protected const SUPPORTED_SOURCE_IDENTIFIERS = [
        'page',
        'product-review',
    ];
}
```

10. Adjust all project-level Elasticsearch index definition JSON files (if any) as follows:
- Each JSON file should be renamed, so it would have one of the source identifiers (see above) as its name. The name of the definition file matters and will later be translated into index name.
- Each JSON file should provide a definition only for one mapping type, suitable for that index. By default, *index’s only* mapping type should have the same name as the JSON file it’s described by. For example, `page.json` should only contain a definition for the `page` mapping type.
- Each JSON file should be placed inside of the directory, which matches a path pattern defined by `SearchElasticsearchConfig::getJsonSchemaDefinitionDirectories()`.
## Upgrading from Version 7.* to Version 8.*
With this version of the Search module we have migrated to Elasticsearch 5.6. Please read the [Elasticsearch Breaking Changes in 5.0](https://www.elastic.co/guide/en/elasticsearch/reference/5.5/breaking-changes-5.0.html) official documentation to adjust your custom implementation accordingly.

Your development environment needs to be updated with Elasticsearch 5.6.x. In case you are using the Spryker DevVM, you can download the latest release that provides the necessary services. Follow our [Installation Guide](/docs/scos/dev/developer-getting-started-guide.html) for detailed instructions about installing the Spryker DevVM.

**Elasticsearch 5 Related BC Breaking Change Highlights**

* `string fields` replaced by text/keyword field: mapping changed for all string fields in the indexes.
* `index` property: the index property now only accepts `true/false` instead of `not_analyzed/no`.
* `size`: 0 on Terms, Significant Terms and Geohash Grid Aggregations: the Demoshop used this feature to aggregate infinite number of categories. Size should be set to a fixed number instead.
* `missing` query was removed, use a negated exists query instead.

**Other BC Breaking Changes**
Previously the `vendor/bin/console setup:search` command installed indexes for all stores.
Now it only installs the index for the current store.
***
## Upgrading from Version 6.* to Version 7.*

**Zed changes:**
With version 7 we have fixed a bug with incorrect mapping of a filter name with request parameters.
If you have modified/extended:

* `\Spryker\Client\Search\Model\Elasticsearch\AggregationExtractor\CategoryExtractor`
* `\Spryker\Client\Search\Model\Elasticsearch\AggregationExtractor\FacetExtractor`
*  `\Spryker\Client\Search\Model\Elasticsearch\AggregationExtractor\RangeExtractor`

you have to merge the latest changes with the core. Especially this is important for `extractDataFromAggregations` method.

* `\Spryker\Client\Search\Plugin\Config\FacetConfigBuilder` now looks for facet from the request parameters.
* `\Spryker\Client\Search\Plugin\Config\SortConfigBuilder` now looks for configuration by configuration field name.

**Yves changes:**
The `UrlGenerator` was incorrectly setting the request parameters, therefore now it is necessary to change processFacetSearchResultTransfer and processRangeSearchResultTransfer as shown in the code sample below.

**Code sample:**

```php
namespace Pyz\Yves\Catalog\ActiveSearchFilter;

class UrlGenerator implements UrlGeneratorInterface
{
    /**
     * @param array $params
     * @param \Generated\Shared\Transfer\FacetSearchResultTransfer $searchResultTransfer
     * @param string|null $filterValue
     *
     * @return array
     */
    protected function processFacetSearchResultTransfer(array $params, FacetSearchResultTransfer $searchResultTransfer, $filterValue = null)
    {
        $param = $params[$searchResultTransfer->getName()];
        if (is_array($param) && $filterValue !== null) {
            $index = array_search($filterValue, $param);
            unset($params[$searchResultTransfer->getName()][$index]);

            return $params;
        }

        unset($params[$searchResultTransfer->getName()]);

        return $params;
    }

    /**
     * @param array $params
     * @param \Generated\Shared\Transfer\RangeSearchResultTransfer $searchResultTransfer
     *
     * @return array
     */
    protected function processRangeSearchResultTransfer(array $params, RangeSearchResultTransfer $searchResultTransfer)
    {
        unset($params[$searchResultTransfer->getName()]);

        return $params;
    }
```

You have to change the way filters are configured in twig templates. Previously there was an incorrect setting on using a name, instead of a request parameter. The filters are under `Pyz/Yves/Catalog/Theme/default/catalog/partials/filters` directory.

**Twig templates also require changes:**
* **"multi-select.twig"**:
`<input type="checkbox" name="{% raw %}{{{% endraw %} filter.name {% raw %}}}{% endraw %}[]" ...`  should be `<input type="checkbox" name="{% raw %}{{{% endraw %} filter.config.parameterName {% raw %}}}{% endraw %}[]" ...`

* **"price-range.twig"**:
`<input type="number" name="{% raw %}{{{% endraw %} filter.name {% raw %}}}{% endraw %}[min]" ... ... <input type="number" name="{% raw %}{{{% endraw %} filter.name {% raw %}}}{% endraw %}[max]"`  should be `<input type="number" name="{% raw %}{{{% endraw %} filter.config.parameterName {% raw %}}}{% endraw %}[min]" ... ... <input type="number" name="{% raw %}{{{% endraw %} filter.config.parameterName {% raw %}}}{% endraw %}[max]" ...`

* **"range.twig":**
`<input type="number" name="{% raw %}{{{% endraw %} filter.name {% raw %}}}{% endraw %}[min]" ... ... <input type="number" name="{% raw %}{{{% endraw %} filter.name {% raw %}}}{% endraw %}[max]" ...` should be `<input type="number" name="{% raw %}{{{% endraw %} filter.config.parameterName {% raw %}}}{% endraw %}[min]" ... ... <input type="number" name="{% raw %}{{{% endraw %} filter.config.parameterName {% raw %}}}{% endraw %}[max]" ...`

* **"rating.twig":**
`<input type="hidden" name="{% raw %}{{{% endraw %} filter.name {% raw %}}}{% endraw %}[min]" ...`  should be `<input type="hidden" name="{% raw %}{{{% endraw %} filter.config.parameterName {% raw %}}}{% endraw %}[min]" ...`

* **"single-select.twig"**
`<input type="radio" name="{% raw %}{{{% endraw %} filter.name {% raw %}}}{% endraw %}" ...`  should be `<input type="radio" name="{% raw %}{{{% endraw %} filter.config.parameterName {% raw %}}}{% endraw %}" ...`

* **"Pyz/Yves/Catalog/Theme/default/catalog/partials/filters.twig":**
`{% raw %}{{{% endraw %} ('product.filter.' ~ filter.name) | trans {% raw %}}}{% endraw %}` should be `{% raw %}{{{% endraw %} ('product.filter.' ~ filter.name | lower) | trans {% raw %}}}{% endraw %}`
***
## Upgrading from Version 4.* to Version 5.*

We changed the way dynamic search configuration was cached and then used. This feature caused the following non-backward compatible changes:

* The `Spryker\Shared\Search\SearchConstants::SEARCH_CONFIG_CACHE_KEY` config was removed, but previously it was required to be filled with a key that was used to save the search config cache into Redis.
* Removed `SearchFacade::saveSearchConfigCache()` method which stored the given search cache configuration into Redis.
* In the new version, instead of the removed code mentioned above, you’ll need to provide a list of `Spryker\Client\Search\Dependency\Plugin\SearchConfigExpanderPluginInterface` in `Pyz\Client\Search\SearchDependencyProvider::createSearchConfigExpanderPlugins()` instead.

We moved the possible facet type option constants from `Spryker\Client\Search\Plugin\Config\FacetConfigBuilder` to `\Spryker\Shared\Search\SearchConstants`:

* `FacetConfigBuilder::TYPE_ENUMERATION` -> `SearchConstants::FACET_TYPE_ENUMERATION`
* `FacetConfigBuilder::TYPE_RANGE` -> SearchConstants::FACET_TYPE_RANGE
* `FacetConfigBuilder::TYPE_PRICE_RANGE` -> `SearchConstants::FACET_TYPE_PRICE_RANGE`
* `FacetConfigBuilder::TYPE_CATEGORY` -> `SearchConstants::FACET_TYPE_CATEGORY`
* `FacetConfigBuilder::TYPE_BOOL`-> not supported

We have added a type field to the default “page” index type defined by `Search/src/Spryker/Shared/Search/IndexMap/search.json`. With this field it’s possible to differentiate multiple item types (e.g. products, cms pages, categories, etc.). Additionally, we also fixed the indexing strategy of store and `locale` field, they are set to “not_analyzed”. These changes require a repeated indexation of your existing data. In a non-production environment this means that you need to delete your index and then install the new one by running `vendor/bin/console setup:search`.

{% info_block errorBox "Important" %}

In production environments, follow the official Elasticsearch guide about [Index Aliases and Zero Downtime](https://www.elastic.co/guide/en/elasticsearch/guide/current/index-aliases.html).

{% endinfo_block %}

***

## Upgrading from Version 3.* to Version 4.*

With the version 4 of the Search module, the logic and configuration of how the results are sorted has been changed. Previously there were two request parameters that controlled what field we are sorting by as well as the direction of the sorting (e.g /?sort=price&sort_order=desc).

The new version now works with one parameter only (e.g. `/?sort=price_asc`). To migrate to the new version, you’ll need to change your configurations in your classes that implement `\Spryker\Client\Search\Dependency\Plugin\SearchConfigBuilderInterface`. Instead of providing one `SortConfigTransfer` per sorted attribute, now you need to provide two if you wish to sort by both ascending and descending order. To do this, use the `SortConfigTransfer::setIsDescending()` method, and make sure that the values in `SortConfigTransfer::setParameterName()` are unique.

<!-- See the Search documentation for a detailed [example](/docs/scos/dev/back-end-development/data-manipulation/data-interaction/search/configuring-the-search-features.html). -->
