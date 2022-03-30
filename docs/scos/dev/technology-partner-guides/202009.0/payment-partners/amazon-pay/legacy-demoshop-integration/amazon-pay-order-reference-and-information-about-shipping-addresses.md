---
title: Amazon Pay - Order Reference and Information about Shipping Addresses
description: This article contains information about order reference and shipping address information in the Spryker Legacy Demoshop.
last_updated: Aug 27, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v6/docs/amazon-pay-order-ref-info-demoshop
originalArticleId: daa93e41-08e2-43ff-9f81-2d009db904cd
redirect_from:
  - /v6/docs/amazon-pay-order-ref-info-demoshop
  - /v6/docs/en/amazon-pay-order-ref-info-demoshop
related:
  - title: Amazon Pay - Configuration for the Legacy Demoshop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-configuration-for-the-legacy-demoshop.html
  - title: Amazon Pay - Refund
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-refund.html
  - title: Handling orders with Amazon Pay API
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/legacy-demoshop-handling-orders-with-amazon-pay-api.html
  - title: Amazon Pay - Email Notifications
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-email-notifications.html
  - title: Amazon Pay - Sandbox Simulations
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-sandbox-simulations.html
  - title: Amazon Pay - State Machine
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-state-machine.html
  - title: Amazon Pay - Support of Bundled Products
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-support-of-bundled-products.html
  - title: Amazon Pay - Rendering a “Pay with Amazon” Button on the Cart Page
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-rendering-a-pay-with-amazon-button-on-the-cart-page.html
---

After successful authorization, a buyer will be redirected to an order details page to enter all the information necessary for placing an order: address of shipment, payment method, delivery method and some calculations about taxes, possible discounts, delivery cost, etc.

Amazon Pay provides solutions for choosing shipping addresses and payment methods based on what the buyer previously used on Amazon. As addresses differ by country, the delivery method selection must be implemented by the shop and aligned with shipping address information.

Amazon provides two widgets for choosing shipment and payment information, they can be placed together on the same page or separately.

* Add the following widget on your page:

```xml
{% raw %}{{{% endraw %} render(path('amazonpay_checkout_widget')) {% raw %}}}{% endraw %}
```

Configuration would be used from your current settings profile.

<b>Place order</b> button should look like this:
```xml
<a href="{% raw %}{{{% endraw %} path('amazonpay_confirm_purchase') {% raw %}}}{% endraw %}" disabled="true" id="amazonpayPlaceOrderLink" class="button expanded __no-margin-bottom">Place order</a>
```

Both widgets are similar to the `paybutton` widget that we described earlier.

All necessary credentials have to be specified the same way and in order to retrieve the selected information, Amazon provides JavaScript callbacks.

The first of them to use is `onOrderReferenceCreate`, which provides an Amazon order reference ID.

This ID is a unique identifier of an order, created on Amazon's side and is required for Handling orders with Amazon Pay API calls.

Other important callbacks are `onAddressSelect` and `onPaymentSelect`. These callbacks are triggered after selecting shipment address information and payment method respectively. Callbacks are client side notifications informing that an event has happened.

Use the Handling orders with Amazon Pay API to retrieve data and run order operations.

### Checkout Step Rendering

Since payment module is generic, `PaymentController` provides method `getItems` in order to extend display of items.

For example, in order to handle bundled products, follow these steps:

Create template on project level `AmazonPay/Theme/default/payment/patials/checkout-item.twig`:
```twig
{% raw %}{%{% endraw %} if item.bundleProduct is defined {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} include '@checkout/checkout/partials/summary-item.twig' with {'item': item.bundleProduct, 'bundleItems' : item.bundleItems} {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} else {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} include '@checkout/checkout/partials/summary-item.twig' {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} endif {% raw %}%}{% endraw %}
 ```

Extend `AmazonPay/Controller/PaymentController` and add the following method:
```php 
/**
 * @param \Generated\Shared\Transfer\QuoteTransfer $quoteTransfer
 *
 * @return \ArrayObject|\Generated\Shared\Transfer\ItemTransfer[]
 */
 protected function getCartItems(QuoteTransfer $quoteTransfer)
 {
 return $this->getFactory()->createProductBundleGrouper()->getGroupedBundleItems(
 $quoteTransfer->getItems(),
 $quoteTransfer->getBundleItems()
 );
 }
 ```

Add corresponding method to `AmazonPayFactory`:
```php 
/**
 * @return \Spryker\Yves\ProductBundle\Grouper\ProductBundleGrouperInterface
 */
 public function createProductBundleGrouper()
 {
 return new ProductBundleGrouper();
 }
 ```
