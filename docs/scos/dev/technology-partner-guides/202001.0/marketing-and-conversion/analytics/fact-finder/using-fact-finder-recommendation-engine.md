---
title: Using FACT-Finder recommendation engine
search: exclude
description: The FACT-Finder recommendation engine analyzes product and category relationships. The results are rendered in recommendations widget, which can be displayed on product details pages, homepage or in the shopping cart.
last_updated: Dec 25, 2019
template: howto-guide-template
originalLink: https://documentation.spryker.com/v4/docs/search-factfinder-recommendation
originalArticleId: 56df61f9-750b-4a45-ab44-cb07dad109dc
redirect_from:
  - /v4/docs/search-factfinder-recommendation
  - /v4/docs/en/search-factfinder-recommendation
related:
  - title: Installing and configuring FACT-Finder NG API
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/installing-and-configuring-the-fact-finder-ng-api.html
  - title: FACT-Finder
    link: docs/scos/user/technology-partners/page.version/marketing-and-conversion/analytics/fact-finder.html
  - title: Using FACT-Finder tracking
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-tracking.html
  - title: Using FACT-Finder search suggestions
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-search-suggestions.html
  - title: Using FACT-Finder search
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-search.html
  - title: Using FACT-Finder campaigns
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/using-fact-finder-campaigns.html
  - title: Exporting product data for FACT-Finder
    link: docs/scos/dev/technology-partner-guides/page.version/marketing-and-conversion/analytics/fact-finder/exporting-product-data-for-fact-finder.html
---

## Prerequisites

The FACT-Finder recommendation engine analyzes product and category relationships. The results are rendered in recommendations widget, which can be displayed on product details pages, homepage or in the shopping cart.

## Usage

To add recommendations widget to product page, insert the following code into `src/Pyz/Yves/Product/Theme/default/product/detail.twig`:
```html
{% raw %}{{{% endraw %} fact_finder_recommendations({id: product.sku, mainId: product.idProductAbstract}, '@FactFinder/recommendations/products.twig') {% raw %}}}{% endraw %}
```
To add recommendations widget to cart page, modify cart controller  (`src/Pyz/Yves/Cart/Controller/CartController.php`) to add array of product ids into template variables:

<details open>
<summary markdown='span'>Click here to expand the code sample</summary>

```php
<?php
...

class CartController extends AbstractController
{

 /**
 * @return array
 */
 public function indexAction(Request $request, ?array $selectedAttributes = null)
 {
 $quoteTransfer = $this->getClient()
 ->getQuote();

 $factFinderSid = $request->cookies->get(FactFinderConstants::COOKIE_SID_NAME);
 $quoteTransfer->setFactFinderSid($factFinderSid);

 $voucherForm = $this->getFactory()
 ->getVoucherForm();

 $cartItems = $this->getFactory()
 ->createProductBundleGrouper()
 ->getGroupedBundleItems($quoteTransfer->getItems(), $quoteTransfer->getBundleItems());

 $cartItemsIds = [];
 $cartItemsNames = [];
 foreach ($cartItems as $cartItem) {
 $cartItemsNames[] = $cartItem->getName();
 $cartItemsIds[] = $cartItem->getSku();
 }

 $stepBreadcrumbsTransfer = $this->getFactory()
 ->getCheckoutBreadcrumbPlugin()
 ->generateStepBreadcrumbs($quoteTransfer);

 $itemAttributesBySku = $this->getFactory()
 ->createCartItemsAttributeProvider()
 ->getItemsAttributes($quoteTransfer, $selectedAttributes);

 $promotionStorageProducts = $this->getFactory()
 ->getProductPromotionMapperPlugin()
 ->mapPromotionItemsFromProductStorage(
 $quoteTransfer,
 $request
 );

 $factFinderSdkProductCampaignRequestTransfer = $this->getFactory()
 ->createFactFinderSdkProductCampaignRequestTransfer();
 $factFinderSdkProductCampaignRequestTransfer->setProductNumber($cartItemsIds);
 $factFinderSdkProductCampaignRequestTransfer->setSid($factFinderSid);

 $campaigns = $this->getCampaigns(
 $factFinderSdkProductCampaignRequestTransfer,
 $cartItems
 );

 return $this->viewResponse([
 'cart' => $quoteTransfer,
 'cartItems' => $cartItems,
 'attributes' => $itemAttributesBySku,
 'cartItemsIds' => $cartItemsIds,
 'cartItemsNames' => $cartItemsNames,
 'voucherForm' => $voucherForm->createView(),
 'stepBreadcrumbs' => $stepBreadcrumbsTransfer,
 'promotionStorageProducts' => $promotionStorageProducts,
 'campaigns' => $campaigns,
 ]);
 }

...
```
<br>
</details>

Then add recommendations widget to cart  page template `src/Pyz/Yves/Cart/Theme/default/cart/index.twig`:

```twig
{% raw %}{{{% endraw %} fact_finder_recommendations({id: cartItemsIds, mainId: cartItemsIds}, '@FactFinder/recommendations/products.twig') {% raw %}}}{% endraw %}
```
