---
title: Using FACT-Finder campaigns
search: exclude
description: The FACT-Finder Campaign Manager module allows you to target the management of search results in order to improve the customer lead process or deliberately highlight products.
last_updated: Oct 23, 2019
template: howto-guide-template
originalLink: https://documentation.spryker.com/v1/docs/search-factfinder-campaigns
originalArticleId: 0c5c56a3-532e-4f9d-8d3b-a472058ca408
redirect_from:
  - /v1/docs/search-factfinder-campaigns
  - /v1/docs/en/search-factfinder-campaigns
related:
  - title: Installing and configuring FACT-Finder NG API
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/installing-and-configuring-the-fact-finder-ng-api.html
  - title: Using FACT-Finder search
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-search.html
  - title: FACT-Finder
    link: docs/scos/user/technology-partners/page.version/marketing-and-conversion/analytics/fact-finder.html
  - title: Using FACT-Finder tracking
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-tracking.html
  - title: Exporting product data for FACT-Finder
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/exporting-product-data-for-fact-finder.html
  - title: Using FACT-Finder recommendation engine
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-recommendation-engine.html
  - title: Using FACT-Finder search suggestions
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-search-suggestions.html
---

## Prerequisites

The FACT-Finder Campaign Manager module allows you to target the management of search results in order to improve the customer lead process or deliberately highlight products.
Campaigns are activated according to the specific criteria and are then returned accordingly in the search results.

Campaigns are a powerful tool for visual merchandising. One of their numerous functions is automatic redirects to static pages for specific search terms, e.g. searching for "ToS" automatically redirects the user to the terms of service page. Even more importantly, campaigns allow for targeted placement of banners or the customization of search results.

These types of the campaign can be created with the Campaign Assistant:

* **Feedback Campaigns**: Display preset texts and banners with search results. Also used for pushed products.
* **Redirect Campaigns**: Redirect the user to the specific pages for certain search terms.
* **Advisor Campaigns**: Manages questions and answers that are presented to the shop visitor. Answers lead to specific product sets.
* **Product Campaigns**: Allows you to place campaigns on product pages instead of search result pages.

### Feedback Campaign

Feedback campaigns add predefined banners, texts, and products aimed to search results in reaction to specific search terms or other triggers.
These campaigns are best suited to pushing products.
A feedback campaign can also be used to place videos, point the customer towards the brand stores or to the designed zero-result pages.

### Redirect Campaign

Redirect campaigns react to triggers like search words and send users to specific pages, like Contact, ToS, etc.
Every webstore has a number of pages that should be available in this way.
Apart from the contact form and terms of service, payment and shipping conditions, as well as the about page, fall into that list.

### Redirect Campaign

Advisor campaigns give you the ability to set up questions as text or images which are presented to the customer in certain situations.
You group the questions with the preset answers the customer can choose. Each answer is combined with a product set which is displayed to the user on giving the answer. This gives you the ability to guide the user with targeted questions.
Advisor campaigns are especially useful to react to rising trends or frequently used filter combinations.

### Product Campaign

Product campaigns can be placed on any product detail page, shopping cart page or shop page and display a specific product set.
They employ the same method of defining product sets but are different in the way they are triggered.

## Usage

### Search Page

Search result campaigns are fetched implicitly by invoking a search request. Examples of integration of advisor, redirect, feedback and pushed products campaigns can be found in `vendor/spryker-eco/fact-finder/src/SprykerEco/Yves/FactFinder/Theme/default/search/catalog.twig`

### Product Details Page

To fetch Fact-Finder campaigns for product page, you need to make a call using Fact-Finder client. To do that:

1. Add FactFinder client to dependency provider:
<details open>
<summary markdown='span'>Click here to expand the code sample</summary>

```php
<?php

class ProductDependencyProvider extends AbstractBundleDependencyProvider
{
 ...
 const CLIENT_FACT_FINDER = 'CLIENT_FACT_FINDER';

 /**
 * @param \Spryker\Yves\Kernel\Container $container
 *
 * @return \Spryker\Yves\Kernel\Container
 */
 public function provideDependencies(Container $container)
 {
 $container = $this->provideClients($container);

 return $container;
 }

 /**
 * @param \Spryker\Yves\Kernel\Container $container
 *
 * @return \Spryker\Yves\Kernel\Container
 */
 protected function provideClients(Container $container)
 {
 ...

 $container[self::CLIENT_FACT_FINDER] = function (Container $container) {
 return $container->getLocator()->factFinderSdk()->client();
 };

 return $container;
 }

}
```
<br>
</details>

2. Add methods to get FactFinder client and to create product campaign request transfer:

<details open>
<summary markdown='span'>Click here to expand the code sample</summary>

 ```php
<?php

class ProductFactory extends AbstractFactory
{

 ...

 /**
 * @return \SprykerEco\Client\FactFinderSdk\FactFinderSdkClient
 */
 public function getFactFinderClient()
 {
 return $this->getProvidedDependency(ProductDependencyProvider::CLIENT_FACT_FINDER);
 }

 /**
 * @return \Generated\Shared\Transfer\FactFinderSdkProductCampaignRequestTransfer
 */
 public function createFactFinderSdkProductCampaignRequestTransfer()
 {
 return new FactFinderSdkProductCampaignRequestTransfer();
 }

}
 ```
<br>
</details>

3. Fetch product campaigns from controller:

 <details open>
<summary markdown='span'>Click here to expand the code sample</summary>

 ```php
<?php

class ProductController extends AbstractController
{

 /**
 * @param \Generated\Shared\Transfer\StorageProductTransfer $storageProductTransfer
 *
 * @return array
 */
 public function detailAction(Request $request, StorageProductTransfer $storageProductTransfer)
 {
 ...
 $factFinderSdkProductCampaignRequestTransfer = $this->getFactory()
 ->createFactFinderSdkProductCampaignRequestTransfer();
 $factFinderSdkProductCampaignRequestTransfer->addProductNumber($storageProductTransfer->getIdProductAbstract());
 $factFinderSdkProductCampaignRequestTransfer->setSid($request->cookies->get(FactFinderConstants::COOKIE_SID_NAME));
 $factFinderProductCampaignResponseTransfer = $this->getFactory()
 ->getFactFinderClient()
 ->getProductCampaigns($factFinderSdkProductCampaignRequestTransfer);
 $campaigns = $factFinderProductCampaignResponseTransfer->getCampaignIterator()->getCampaigns();

 $productData = [
 ...
 'campaigns' => $campaigns,
 ];

 return $productData;
 }
}
```
<br>
</details>

4. Inject feedback campaign templates into product details template, indicating position of campaign widget in `feedbackBlockPositionId` parameter e.g.:

```php
{% raw %}{%{% endraw %} if campaigns is defined {% raw %}%}{% endraw %}
    {% raw %}{%{% endraw %} include '@FactFinder/campaigns/partials/feedback.twig' with {
        campaigns: campaigns,
        feedbackBlockPositionId: 'product detail - above product',
    } {% raw %}%}{% endraw %}
{% raw %}{%{% endraw %} endif {% raw %}%}{% endraw %}
```
Additionally, you might need to add some more feedback widgets to general layout in `src/Pyz/Yves/Application/Theme/default/layout/layout.twig`
5. Inject pushed products campaign template into product details template, e.g.:

```php
{% raw %}{%{% endraw %} if campaigns is defined {% raw %}%}{% endraw %}
    {% raw %}{%{% endraw %} include '@FactFinder/campaigns/partials/pushed-products.twig' with {
        campaigns: campaigns,
    } {% raw %}%}{% endraw %}
{% raw %}{%{% endraw %} endif {% raw %}%}{% endraw %}
```

### Cart Page

To fetch Fact-Finder campaigns for cart page, perform the same actions as for product page, but under Cart module namespace.
