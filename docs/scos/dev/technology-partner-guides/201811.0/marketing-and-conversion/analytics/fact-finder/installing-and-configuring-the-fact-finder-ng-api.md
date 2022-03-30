---
title: Installing and configuring FACT-Finder NG API
description: Fact Finder NG API integration is used for search, tracking, and importing endpoints.
last_updated: Jan 27, 2020
template: howto-guide-template
originalLink: https://documentation.spryker.com/v1/docs/fact-finder-ng
originalArticleId: 3769f5d6-4097-4002-bdf8-a2bf8bab0d47
redirect_from:
  - /v1/docs/fact-finder-ng
  - /v1/docs/en/fact-finder-ng
related:
  - title: FACT-Finder
    link: docs/scos/user/technology-partners/page.version/marketing-and-conversion/analytics/fact-finder.html
  - title: Using FACT-Finder search suggestions
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-search-suggestions.html
  - title: Using FACT-Finder search
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-search.html
  - title: Using FACT-Finder recommendation engine
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-recommendation-engine.html
  - title: Using FACT-Finder tracking
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-tracking.html
  - title: Using FACT-Finder campaigns
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-campaigns.html
  - title: Exporting product data for FACT-Finder
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/exporting-product-data-for-fact-finder.html
---

## Installation
To install the package use `composer require spryker-eco/fact-finder-ng` command.

## Configuration
For using the package you have to set configuration parameters.
```php
$config[FactFinderNgConstants::FACT_FINDER_URL] = ''; # Fact-Finder URL
$config[FactFinderNgConstants::FACT_FINDER_CHANNEL] = ''; # Fact-Finder channel value
$config[FactFinderNgConstants::FACT_FINDER_USERNAME] = ''; # Fact-Finder user for authorization.
$config[FactFinderNgConstants::FACT_FINDER_PASSWORD] = ''; # Fact-Finder password for authorization.
```
## Import Usage
Fact-Finder has an import API call. It can be used to update product information by URL set on the Fact-Finder side. To trigger the import, you have to add Console command to `ConsoleDependecyProvider`.
<details open>
<summary markdown='span'>ConsoleDependencyProvider.php</summary>

```php
<?php
 
class ConsoleDependencyProvider extends SprykerConsoleDependencyProvider
{
    /**
     * @param \Spryker\Zed\Kernel\Container $container
     *
     * @return \Symfony\Component\Console\Command\Command[]
     */
    protected function getConsoleCommands(Container $container)
    {
        $commands = [
            ...
            new FactFinderNgImportSearchConsole()
        ];
        ...
    {% raw %}}}{% endraw %}
```
<br>
</details>
You can import using the console fact-finder-ng:import:search command.

## Tracking Usage
There are tracking functions at the Client layer in the module. 
<details open>
<summary markdown='span'>FactFinderNgClientInterface.php</summary>

```php
<?php
 
namespace SprykerEco\Client\FactFinderNg;
 
interface FactFinderNgClientInterface
{
    ...
 
    /**
     * Specification:
     * - Method send request to Fact finder for tracking checkout completed event.
     *
     * @api
     *
     * @param \Generated\Shared\Transfer\CartOrCheckoutEventTransfer[] $cartOrCheckoutEventTransfers
     *
     * @return \Generated\Shared\Transfer\FactFinderNgResponseTransfer
     */
    public function trackCheckoutEvent(array $cartOrCheckoutEventTransfers): FactFinderNgResponseTransfer;
 
    /**
     * Specification:
     * - Method send request to Fact finder for tracking adding to cart event.
     *
     * @api
     *
     * @param \Generated\Shared\Transfer\CartOrCheckoutEventTransfer[] $cartOrCheckoutEventTransfers
     *
     * @return \Generated\Shared\Transfer\FactFinderNgResponseTransfer
     */
    public function trackCartEvent(array $cartOrCheckoutEventTransfers): FactFinderNgResponseTransfer;
 
    /**
     * Specification:
     * - Method send request to Fact finder for tracking clicking by product event.
     *
     * @api
     *
     * @param \Generated\Shared\Transfer\ClickEventTransfer[] $clickEventTransfers
     *
     * @return \Generated\Shared\Transfer\FactFinderNgResponseTransfer
     */
    public function trackClickEvent(array $clickEventTransfers): FactFinderNgResponseTransfer;
 
    ...
}
```
<br>
</details>
You can use it anywhere you want in your application. You can send a few events together. All these methods expect an array of event transfers. 

E.g., you can use it on the Success step during the checkout process:
<details open>
<summary markdown='span'>SuccessStep</summary>

```php
<?php
 
namespace Pyz\Yves\CheckoutPage\Process\Steps;
 
class SuccessStep extends SprykerSuccessStep
{
    /**
     * @param Request $request
     * @param QuoteTransfer $quoteTransfer
     *
     * @return QuoteTransfer
     */
    public function execute(Request $request, AbstractTransfer $quoteTransfer)
    {
        $this->factFinderNgClient->trackCheckoutEvent($this->preparedCheckoutEventTransfers($quoteTransfer));
 
        return parent::execute($request, $quoteTransfer);
    }
 
    /**
     * @param QuoteTransfer $quoteTransfer
     *
     * @return CartOrCheckoutEventTransfer[]
     */
    protected function preparedCheckoutEventTransfers(QuoteTransfer $quoteTransfer): array
    {
        $eventTransfers = [];
        foreach ($quoteTransfer->getItems() as $itemTransfer) {
            $eventTransfer = new CartOrCheckoutEventTransfer();
            $eventTransfer->setCount($itemTransfer->getQuantity());
            $eventTransfer->setId($itemTransfer->getSku());
            $eventTransfer->setMasterId($itemTransfer->getAbstractSku());
            $eventTransfer->setPrice($itemTransfer->getUnitPriceToPayAggregation());
            $eventTransfer->setSid(uniqid());
 
            $eventTransfers[] = $eventTransfer;
        }
 
        return $eventTransfers;
    }
}
```
<br>
</details>

## Search, Suggestion, Navigation Usage
For using search functions, you have to extend SearchClient on the project level. If you want to use different search engines, you might need to create search router, for choosing the right engine. 

<details open>
<summary markdown='span'>SearchRouter</summary>

```php
<?php
 
/**
 * This file is part of the Spryker Suite.
 * For full license information, please view the LICENSE file that was distributed with this source code.
 */
 
namespace Pyz\Client\Search\Model\Router;
 
use Spryker\Client\Search\Dependency\Plugin\QueryInterface;
 
class SearchRouter implements SearchRouterInterface
{
    /**
     * @var array
     */
    protected $searchPlugins;
 
    /**
     * @param array $searchPlugins
     */
    public function __construct(array $searchPlugins)
    {
        $this->searchPlugins = $searchPlugins;
    }
 
    /**
     * Resolve here what the handler should be work
     *
     * @param \Spryker\Client\Search\Dependency\Plugin\QueryInterface $searchQuery
     * @param array $resultFormatters
     * @param array $requestParameters
     *
     * @return array|\Elastica\ResultSet
     */
    public function search(QueryInterface $searchQuery, array $resultFormatters = [], array $requestParameters = [])
    {
        foreach ($this->searchPlugins as $searchPlugin) {
            if ($searchPlugin->isApplicable($requestParameters)) {
                return $searchPlugin->handle($searchQuery, $resultFormatters, $requestParameters);
            }
        }
 
        return [];
    }
}
```
 <br>
</details>

If you want to use ElasticSearch for specific cases, you have to create a plugin on the project level
<details open>
<summary markdown='span'>ElasticSearchHandlerPlugin</summary>

```php
<?php
 
/**
 * This file is part of the Spryker Suite.
 * For full license information, please view the LICENSE file that was distributed with this source code.
 */
 
namespace Pyz\Client\Search\Plugin;
 
use Spryker\Client\Kernel\AbstractPlugin;
use Spryker\Client\Search\Dependency\Plugin\QueryInterface;
 
/**
 * @method \Pyz\Client\Search\SearchFactory getFactory()
 */
class ElasticSearchHandlerPlugin extends AbstractPlugin
{
    /**
     * @param \Spryker\Client\Search\Dependency\Plugin\QueryInterface $searchQuery
     * @param array $resultFormatters
     * @param array $requestParameters
     *
     * @return array|\Elastica\ResultSet
     */
    public function handle(QueryInterface $searchQuery, array $resultFormatters = [], array $requestParameters = [])
    {
        return $this->getFactory()->createElasticsearchSearchHandler()->search($searchQuery, $resultFormatters, $requestParameters);
    }
 
    /**
     * @param array $requestParameters
     *
     * @return bool
     */
    public function isApplicable(array $requestParameters): bool
    {
        return true;
    }
}
```
 <br>
</details>

The Fact-Finder Ng module contains plugins for choosing search, suggestion, or navigation request should be used. By now you can create plugin stack in `SearchDependencyProvider` for using in `SearchRouter`. 

<details open>
<summary markdown='span'>SearchDependencyProvider</summary>

```php
<?php
 
/**
 * This file is part of the Spryker Suite.
 * For full license information, please view the LICENSE file that was distributed with this source code.
 */
 
namespace Pyz\Client\Search;
 
use Pyz\Client\Search\Plugin\ElasticSearchHandlerPlugin;
use Spryker\Client\Kernel\Container;
use Spryker\Client\Search\SearchDependencyProvider as SprykerSearchDependencyProvider;
use SprykerEco\Client\FactFinderNg\Plugin\FactFinderNgNavigationHandlerPlugin;
use SprykerEco\Client\FactFinderNg\Plugin\FactFinderNgSearchHandlerPlugin;
use SprykerEco\Client\FactFinderNg\Plugin\FactFinderNgSuggestHandlerPlugin;
 
class SearchDependencyProvider extends SprykerSearchDependencyProvider
{
    public const CLIENT_FACT_FINDER_NG = 'CLIENT_FACT_FINDER_NG';
    public const PLUGINS_SEARCH = 'SEARCH_PLUGINS';
 
    /**
     * @param \Spryker\Client\Kernel\Container $container
     *
     * @return \Spryker\Client\Kernel\Container
     */
    public function provideServiceLayerDependencies(Container $container): Container
    {
        $container = parent::provideServiceLayerDependencies($container);
        $container = $this->provideFactFinderNgClient($container);
        $container = $this->addSearchPlugins($container);
 
        return $container;
    }
 
    /**
     * @return \Pyz\Client\Search\Plugin\SearchHandlerPluginInterface[]
     */
    protected function getSearchPlugins(): array
    {
        return [
            new FactFinderNgNavigationHandlerPlugin(),
            new FactFinderNgSearchHandlerPlugin(),
            new FactFinderNgSuggestHandlerPlugin(),
            new ElasticSearchHandlerPlugin(),
        ];
    }
 
    /**
     * @param \Spryker\Client\Kernel\Container $container
     *
     * @return \Spryker\Client\Kernel\Container
     */
    protected function provideFactFinderNgClient(Container $container): Container
    {
        $container[static::CLIENT_FACT_FINDER_NG] = function (Container $container) {
            return $container->getLocator()->factFinderNg()->client();
        };
 
        return $container;
    }
 
    /**
     * @param \Spryker\Client\Kernel\Container $container
     *
     * @return \Spryker\Client\Kernel\Container
     */
    protected function addSearchPlugins(Container $container): Container
    {
        $container[static::PLUGINS_SEARCH] = function () {
            return $this->getSearchPlugins();
        };
 
        return $container;
    }
}
```
<br>
</details>

Then SearchClient can be adjusted:

<details open>
<summary markdown='span'>SearchRouter</summary>

```php
<?php
 
/**
 * This file is part of the Spryker Suite.
 * For full license information, please view the LICENSE file that was distributed with this source code.
 */
 
namespace Pyz\Client\Search;
 
use Spryker\Client\Search\Dependency\Plugin\QueryInterface;
use Spryker\Client\Search\SearchClient as SprykerSearchClient;
 
/**
 * @method \Pyz\Client\Search\SearchFactory getFactory()
 */
class SearchClient extends SprykerSearchClient
{
    /**
     * {@inheritdoc}
     *
     * @api
     *
     * @param \Spryker\Client\Search\Dependency\Plugin\QueryInterface $searchQuery
     * @param \Spryker\Client\Search\Dependency\Plugin\ResultFormatterPluginInterface[] $resultFormatters
     * @param array $requestParameters
     *
     * @return array|\Elastica\ResultSet
     */
    public function search(QueryInterface $searchQuery, array $resultFormatters = [], array $requestParameters = [])
    {
        return $this
            ->getFactory()
            ->createSearchRouter()
            ->search($searchQuery, $resultFormatters, $requestParameters);
    }
}
```
<br>
</details>

The idea that you have to adjust places, where the search is called for adding needed params to request parameters. For example, you can adjust `SuggestionController` for adding a suggest parameter, so `FactFinderNgSuggestHandlerPlugin` will know that it should be called.

<details open>
<summary markdown='span'>SuggestionController</summary>

```php
<?php
 
/**
 * This file is part of the Spryker Suite.
 * For full license information, please view the LICENSE file that was distributed with this source code.
 */
 
namespace Pyz\Yves\CatalogPage\Controller;
 
use SprykerShop\Yves\CatalogPage\Controller\SuggestionController as SprykerSuggestionController;
use Symfony\Component\HttpFoundation\Request;
 
/**
 * @method \SprykerShop\Yves\CatalogPage\CatalogPageFactory getFactory()
 */
class SuggestionController extends SprykerSuggestionController
{
    /**
     * @param \Symfony\Component\HttpFoundation\Request $request
     *
     * @return \Symfony\Component\HttpFoundation\JsonResponse
     */
    public function indexAction(Request $request)
    {
        $searchString = $request->query->get(self::PARAM_SEARCH_QUERY);
 
        if (!$searchString) {
            return $this->jsonResponse();
        }
 
        $requestParameters = array_merge($request->query->all(), ['suggest' => 1]); # Here you add new request parameter.
 
        $searchResults = $this
            ->getFactory()
            ->getCatalogClient()
            ->catalogSuggestSearch($searchString, $requestParameters);
 
        return $this->jsonResponse([
            'completion' => ($searchResults['completion'] ? $searchResults['completion'][0] : null),
            'suggestion' => $this->renderView('@CatalogPage/views/suggestion-results/suggestion-results.twig', $searchResults)->getContent(),
        ]);
    }
}
```
<br>
</details>

## Pagination, Sorting, and Filters
### Pagination
For the Yves layer, pagination should work out of the box. Request mapper cares about page and ipp (items for page) parameters and map it to Fact-Finder parameters.

If you use the Glue layer, you have to add page and ipp value to request parameters.

### Sorting
By default, the Yves layer doesn't care about sort options which suggested by Fact-Finder. If you want to use them, you have to change `SortedResultFormatterPlugin` in `CatalogDependencyProvider`.
```php
<?php
 
/**
 * This file is part of the Spryker Suite.
 * For full license information, please view the LICENSE file that was distributed with this source code.
 */
 
namespace Pyz\Client\Catalog;
 
class CatalogDependencyProvider extends SprykerCatalogDependencyProvider
{
    ...
        /**
     * @return \Spryker\Client\Search\Dependency\Plugin\ResultFormatterPluginInterface[]
     */
    protected function createCatalogSearchResultFormatterPlugins()
    {
        return [
            new FacetResultFormatterPlugin(),
//            new SortedResultFormatterPlugin(),
            new FactFinderSortedResultFormatterPlugin(), # This plugin exists in FactFinderNg module.
            new PaginatedResultFormatterPlugin(),
            new CurrencyAwareCatalogSearchResultFormatterPlugin(
                new RawCatalogSearchResultFormatterPlugin()
            ),
            new SpellingSuggestionResultFormatterPlugin(),
        ];
    }
    ...
}
```
If you use the Glue layer, you have to check a response where you can find a sortItems key. There you can see all the available sort options. You can use them to sort your results. The typical response looks like:
 ```
"sortItems": [
        {
            "order": "desc",
            "name": "Relevancy",
            "description": "sort.relevanceDescription",
            "searchParams": {
                "query": "*",
                "channel": "product_de_DE"
            },
            "selected": false
        },
        {
            "order": "asc",
            "name": "Name",
            "description": "sort.titleAsc",
            "searchParams": {
                "query": "*",
                "sortItems": [
                    {
                        "order": "asc",
                        "name": "Name"
                    }
                ],
                "channel": "product_de_DE"
            },
            "selected": true
        }
]
```
and you have to use it as a request parameter sort. The format is sort=lowercase({name})_{order}.

### Filters and Navigation
Navigation works in the same way as filters. By default, `FactFinderNg` module doesn't care about showing filters. You can find the list of available filters in the Fact-Finder response. You can map and display it on your pages as you wish.

The typical response of filters looks like:
```
"facets": [
        {
            "name": "CategoryPath",
            "elements": [
                {
                    "text": "Kameras+%26+Camcorders",
                    "associatedFieldName": "CategoryPath",
                    "totalHits": 67,
                    "searchParams": {
                        "query": "*",
                        "filters": [
                            {
                                "name": "CategoryPath",
                                "values": [
                                    {
                                        "value": "Kameras+%26+Camcorders",
                                        "type": "or",
                                        "exclude": false
                                    }
                                ],
                                "substring": false
                            }
                        ],
                        "sortItems": [
                            {
                                "order": "asc",
                                "name": "Name"
                            }
                        ],
                        "channel": "product_de_DE"
                    },
                    "selected": false,
                    "clusterLevel": 0
                },
			]
		}
	]
```
You can add the values to request parameters as `?{name}={elements.text}`. E.g. `?CategoryPath=Kameras+%26+Camcorders`. Request mapper cares about these filter params and will map them to Fact-Finder understandable list. 
