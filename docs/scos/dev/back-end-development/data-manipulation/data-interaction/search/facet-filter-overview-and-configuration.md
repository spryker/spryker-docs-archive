---
title: Facet Filter Overview and Configuration
description: Facets provide aggregated data based on a search query.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/t-working-filter-facets
originalArticleId: ec19f80a-9fad-4f44-8d60-8957e2665e0e
redirect_from:
  - /2021080/docs/t-working-filter-facets
  - /2021080/docs/en/t-working-filter-facets
  - /docs/t-working-filter-facets
  - /docs/en/t-working-filter-facets
  - /v6/docs/t-working-filter-facets
  - /v6/docs/en/t-working-filter-facets
  - /v5/docs/t-working-filter-facets
  - /v5/docs/en/t-working-filter-facets
  - /v4/docs/t-working-filter-facets
  - /v4/docs/en/t-working-filter-facets
  - /v3/docs/t-working-filter-facets
  - /v3/docs/en/t-working-filter-facets
  - /v2/docs/t-working-filter-facets
  - /v2/docs/en/t-working-filter-facets
  - /v1/docs/t-working-filter-facets
  - /v1/docs/en/t-working-filter-facets
---

<!--used to be: http://spryker.github.io/tutorials/yves/working-with-filter-facets/-->
A search engine facilitates a better navigation, allowing customers to quickly locate desired products.

The search engine should return a small number of items that match the query.

Facets provide aggregated data based on a search query. For example, we need to query for all the shirts that are in color blue. The search engine has configured a facet on a category and one on the color attribute. Therefore, the search query will be executed using these 2 facets. The search result will return the entries that are aggregated both in the category facet with the shirt category ID and in the color facet with the value blue.

## Category facet filter
`CatalogClient` enables creating a search query when a request is submitted. `CatalogClient` exposes the operation:

* `catalogSearch($searchString, array $requestParameters = [])`

The operation can contain other facet filters (such as color or size)  in the request.

On the category detail page, the `catalogSearch($searchString, $parameters)` should be used, as in the example below:

```php
<?php
 public function indexAction(array $categoryNode, Request $request)
    {
        $idCategoryNode = $categoryNode['node_id'];

        $viewData = $this->executeIndexAction($categoryNode, $idCategoryNode, $request);

        return $this->view(
            $viewData,
            $this->getFactory()->getCatalogPageWidgetPlugins(),
            $this->getCategoryNodeTemplate($idCategoryNode)
        );
    }

    protected function executeIndexAction(array $categoryNode, int $idCategoryNode, Request $request): array
    {
        $searchString = $request->query->get('q', '');
        $idCategory = $categoryNode['id_category'];
        $isEmptyCategoryFilterValueVisible = $this->getFactory()
            ->getModuleConfig()
            ->isEmptyCategoryFilterValueVisible();

        $parameters = $this->getAllowedRequestParameters($request);
        $parameters[PageIndexMap::CATEGORY] = $idCategoryNode;

        $searchResults = $this
            ->getFactory()
            ->getCatalogClient()
            ->catalogSearch($searchString, $parameters);

        $searchResults = $this->reduceRestrictedSortingOptions($searchResults);
        $searchResults = $this->updateFacetFiltersByCategory($searchResults, $idCategory);
        $searchResults = $this->filterFacetsInSearchResults($searchResults);

        $metaTitle = isset($categoryNode['meta_title']) ? $categoryNode['meta_title'] : '';
        $metaDescription = isset($categoryNode['meta_description']) ? $categoryNode['meta_description'] : '';
        $metaKeywords = isset($categoryNode['meta_keywords']) ? $categoryNode['meta_keywords'] : '';

        $metaAttributes = [
            'idCategory' => $idCategory,
            'category' => $categoryNode,
            'isEmptyCategoryFilterValueVisible' => $isEmptyCategoryFilterValueVisible,
            'pageTitle' => ($metaTitle ?: $categoryNode['name']),
            'pageDescription' => $metaDescription,
            'pageKeywords' => $metaKeywords,
            'searchString' => $searchString,
            'viewMode' => $this->getFactory()
                ->getCatalogClient()
                ->getCatalogViewMode($request),
        ];

        return array_merge($searchResults, $metaAttributes);
    }
```
**Example:**
Making a request on the URL `https://mysprykershop.com/en/computers/notebooks` in Demoshop will be routed to the `CatalogController:indexAction` controller action, which is designated for a category detail page.

A facet search will be executed using the category facet with the provided category node as a parameter.

## Configuring facet filters
As mentioned above, the category facet is a special case and needs to be handled this way because a call needs to be made to Redis to retrieve the category node ID when a category detail page is requested.

Other than that, the `CatalogClient` operation can handle requests that contain other facet filters.

You can integrate as many facet filters in your search query, as long as they are configured. The facet configuration is done in the `CatalogDependencyProvider` class.

Keep in mind that the configuration you make in the `CatalogDependencyProvider` must be in sync with the structure of the data exported to Elasticsearch.

Also, keep in mind that even if you have the facets exported in Elasticsearch, without adding the necessary configuration in the `CatalogDependencyProvider` you won’t be able to submit the correct queries.

The search attributes must be configured in the `CatalogDependencyProvider`.

**Example:**

```php
<?php
    protected function getFacetConfigTransferBuilderPlugins()
    {
        return [
            new CategoryFacetConfigTransferBuilderPlugin(),
            new PriceFacetConfigTransferBuilderPlugin(),
            new RatingFacetConfigTransferBuilderPlugin(),
            new ProductLabelFacetConfigTransferBuilderPlugin(),
        ];
    }

    protected function createCatalogSearchResultFormatterPlugins()
    {
        return [
            new FacetResultFormatterPlugin(),
            new SortedResultFormatterPlugin(),
            new PaginatedResultFormatterPlugin(),
            new CurrencyAwareCatalogSearchResultFormatterPlugin(
                new RawCatalogSearchResultFormatterPlugin()
            ),
            new SpellingSuggestionResultFormatterPlugin(),
        ];
    }
```

Having the price attribute added to configuration as an active facet enables us to filter the products on the value of this attribute.

`https://mysprykershop.com/en/computers/notebooks?price=0-300` request will perform a search using the category and price facets. It will return the products that are under the notebooks category with the price range between 0 and 300.

`https://mysprykershop.com/search?q=tablet&price=0-300` request will perform a full-text search with the search string tablet and with the facet filter price (price in the range 0-300).
