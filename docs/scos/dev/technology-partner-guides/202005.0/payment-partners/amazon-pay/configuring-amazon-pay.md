---
title: Configuring Amazon Pay
description: Configure and integrate Amazon Pay into the Spryker Commerce OS by following the instructions from this article.
last_updated: Apr 3, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v5/docs/amazon-pay-configuration-scos
originalArticleId: e519a437-d5d3-409b-8d3f-e4539c475e92
redirect_from:
  - /v5/docs/amazon-pay-configuration-scos
  - /v5/docs/en/amazon-pay-configuration-scos
related:
  - title: Obtaining an Amazon Order Reference and information about shipping addresses
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/obtaining-an-amazon-order-reference-and-information-about-shipping-addresses.html
  - title: Amazon Pay - Refund
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-refund.html
  - title: Handling orders with Amazon Pay API
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/handling-orders-with-amazon-pay-api.html
  - title: Amazon Pay - Sandbox Simulations
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-sandbox-simulations.html
  - title: Amazon Pay - Rendering a “Pay with Amazon” Button on the Cart Page
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-rendering-a-pay-with-amazon-button-on-the-cart-page.html
  - title: Amazon Pay - Sandbox Simulations
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/amazon-pay-sandbox-simulations.html
  - title: Handling orders with Amazon Pay API
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/legacy-demoshop-handling-orders-with-amazon-pay-api.html
  - title: Amazon Pay - Email Notifications
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-email-notifications.html
  - title: Amazon Pay - Order Reference and Information about Shipping Addresses
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-order-reference-and-information-about-shipping-addresses.html
  - title: Amazon Pay - Support of Bundled Products
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/amazon-pay/legacy-demoshop-integration/amazon-pay-support-of-bundled-products.html
---

{% info_block infoBox "Note" %}
Please refer to `config/Shared/config.dist.php` for the module configuration example.
{% endinfo_block %}


To set up the Amazon Pay initial configuration, use the credentials you received after registering as an Amazon seller:

```php
$config[AmazonPayConstants::WIDGET_SCRIPT_PATH] = 'https://static-eu.payments-amazon.com/OffAmazonPayments/eur/lpa/js/Widgets.js';
$config[AmazonPayConstants::WIDGET_SCRIPT_PATH_SANDBOX] = 'https://static-eu.payments-amazon.com/OffAmazonPayments/eur/sandbox/lpa/js/Widgets.js';
$config[AmazonPayConstants::CLIENT_ID] = '';
$config[AmazonPayConstants::CLIENT_SECRET] = '';
$config[AmazonPayConstants::SELLER_ID] = '';
$config[AmazonPayConstants::ACCESS_KEY_ID] = '';
$config[AmazonPayConstants::SECRET_ACCESS_KEY] = '';
$config[AmazonPayConstants::SECRET_ACCESS_KEY] = '';
```

In case an order is being rejected by Amazon, the module will do a redirect. The default recommendation is to redirect to cart. You need to configure this:

```php
$config[AmazonPayConstants::PAYMENT_REJECT_ROUTE] = 'cart';
```

Next, specify your country and shop:

```php
$config[AmazonPayConstants::REGION] = 'DE';
$config[AmazonPayConstants::STORE_NAME] = 'The Shop';
```

For development purposes, sandbox mode must be enabled:

```php
$config[AmazonPayConstants::SANDBOX] = true;
```

The `ERROR_REPORT_LEVEL` parameter is used for internal purposes and specifies the log verbosity level.

There are three options:

1. Log all API responses.
2. Log errors only.
3. Disable logging.

```php
$config[AmazonPayConstants::ERROR_REPORT_LEVEL] = TransactionLogger::REPORT_LEVEL_ERRORS_ONLY;
```

To configure look-and-feel of Amazon Pay button, you can use the following config values:

```php
$config[AmazonPayConstants::WIDGET_BUTTON_TYPE] = AmazonPayConfig::WIDGET_BUTTON_TYPE_FULL;
$config[AmazonPayConstants::WIDGET_BUTTON_SIZE] = AmazonPayConfig::WIDGET_BUTTON_SIZE_MEDIUM;
$config[AmazonPayConstants::WIDGET_BUTTON_COLOR] = AmazonPayConfig::WIDGET_BUTTON_COLOR_DARK_GRAY;
```

According to Amazon Pay restrictions, a module can run either on a `localhost` domain or via HTTPS. If it is not possible to use `localhost`, HTTPS connection should be configured. For testing purposes, register a test account in the [Amazon Pay dashboard](https://pay.amazon.com/us).

## OMS Configuration

Activate the following processes. If you plan to use only one process, drop the other one.

```php
$config[OmsConstants::PROCESS_LOCATION][] = APPLICATION_ROOT_DIR . '/vendor/spryker-eco/amazon-pay/config/Zed/Oms';
$config[OmsConstants::ACTIVE_PROCESSES][] = 'AmazonPayPaymentAsync01';
$config[OmsConstants::ACTIVE_PROCESSES][] = 'AmazonPayPaymentSync01';
```

Default implementation for commands and options should be added to `Pyz/Zed/Oms/OmsDependencyProvider.php`

1. Commands:

```php
$container->extend(OmsDependencyProvider::COMMAND_PLUGINS, function (CommandCollectionInterface $commandCollection) {
 $commandCollection
    ->add(new CancelOrderCommandPlugin(), 'AmazonPay/CancelOrder')
    ->add(new CloseOrderCommandPlugin(), 'AmazonPay/CloseOrder')
    ->add(new RefundOrderCommandPlugin(), 'AmazonPay/RefundOrder')
    ->add(new ReauthorizeExpiredOrderCommandPlugin(), 'AmazonPay/ReauthorizeExpiredOrder')
    ->add(new CaptureCommandPlugin(), 'AmazonPay/Capture')
    ->add(new UpdateSuspendedOrderCommandPlugin(), 'AmazonPay/UpdateSuspendedOrder')
    ->add(new UpdateAuthorizationStatusCommandPlugin(), 'AmazonPay/UpdateAuthorizationStatus')
    ->add(new UpdateCaptureStatusCommandPlugin(), 'AmazonPay/UpdateCaptureStatus')
    ->add(new UpdateRefundStatusCommandPlugin(), 'AmazonPay/UpdateRefundStatus');

 return $commandCollection;
} );
```

2. Conditions:

```php
$container->extend(OmsDependencyProvider::CONDITION_PLUGINS, function (ConditionCollectionInterface $conditionCollection) {
 $conditionCollection
    ->add(new IsClosedConditionPlugin(), 'AmazonPay/IsClosed')
    ->add(new IsCloseAllowedConditionPlugin(), 'AmazonPay/IsCloseAllowed')

    ->add(new IsCancelledConditionPlugin(), 'AmazonPay/IsCancelled')
    ->add(new IsCancelNotAllowedConditionPlugin(), 'AmazonPay/IsCancelNotAllowed')
    ->add(new IsCancelledOrderConditionPlugin(), 'AmazonPay/IsOrderCancelled')

    ->add(new IsOpenConditionPlugin(), 'AmazonPay/IsAuthOpen')
    ->add(new IsDeclinedConditionPlugin(), 'AmazonPay/IsAuthDeclined')
    ->add(new IsPendingConditionPlugin(), 'AmazonPay/IsAuthPending')
    ->add(new IsSuspendedConditionPlugin(), 'AmazonPay/IsAuthSuspended')
    ->add(new IsAuthExpiredConditionPlugin(), 'AmazonPay/IsAuthExpired')
    ->add(new IsClosedConditionPlugin(), 'AmazonPay/IsAuthClosed')
    ->add(new IsAuthTransactionTimedOutConditionPlugin(), 'AmazonPay/IsAuthTransactionTimedOut')
    ->add(new IsSuspendedConditionPlugin(), 'AmazonPay/IsPaymentMethodChanged')

    ->add(new IsCompletedConditionPlugin(), 'AmazonPay/IsCaptureCompleted')
    ->add(new IsDeclinedConditionPlugin(), 'AmazonPay/IsCaptureDeclined')
    ->add(new IsPendingConditionPlugin(), 'AmazonPay/IsCapturePending')

    ->add(new IsCompletedConditionPlugin(), 'AmazonPay/IsRefundCompleted')
    ->add(new IsDeclinedConditionPlugin(), 'AmazonPay/IsRefundDeclined')
    ->add(new IsPendingConditionPlugin(), 'AmazonPay/IsRefundPending');

 return $conditionCollection;
});
```

All default commands and conditions are stored in `SprykerEco\Zed\AmazonPay\Communication\Plugin\Oms\` namespace.

## IPN Configuration

In order to allow everyone to send push notifications, please extend `config_default.XXX.php` for desired environments:

```php
$config[AclConstants::ACL_USER_RULE_WHITELIST][] = [
 'bundle' => 'amazonpay',
 'controller' => 'ipn',
 'action' => 'endpoint',
 'type' => 'allow',
];
```

Depending on your SSL configuration, you may have to extend as well:

```php
$config[ApplicationConstants::ZED_SSL_EXCLUDED][] = 'amazonpay/ipn/endpoint';
$config[ApplicationConstants::YVES_SSL_EXCLUDED]['aie'] = '/amazonpay/ipn/endpoint';
```

## Yves Controllers

In order to enable processing of AmazonPay commands on front end, please add `AmazonPayControllerProvider` to `YvesBootstrap`:

```php
/**
 * @param bool|null $isSsl
 *
 * @return \Pyz\Yves\Application\Plugin\Provider\AbstractYvesControllerProvider[]
 */
protected function getControllerProviderStack($isSsl)
{
 return [
 ...
 new AmazonPayControllerProvider($isSsl),
 ];
}
```

## Theme Support

To make Spryker Eco themes usable, add the following line into the function `addCoreTemplatePaths` in `Pyz/Yves/Twig/TwigConfig`:

```php
$paths[] = APPLICATION_VENDOR_DIR . '/spryker-eco/%1$s/src/SprykerEco/Yves/%1$s/Theme/' . $themeName;
```

In the section <b>include</b> of `tsconfig.json`, add the following:

```php
"./vendor/spryker-eco/**/*",
```

In the section <b>paths</b> of `frontend/settings.js`, add the following:

```php
// eco folders
eco: {
 // all modules
 modules: './vendor/spryker-eco'
},
```

In the section <b>module.exports</b> property <b>dirs</b> of `frontend/settings.js` add the following:

```php
path.join(context, paths.eco.modules),
```

No matter how many <b>SprykerEco</b> modules you are using, these changes are required to be made only once.

Make sure to rebuild front-end script by running `npm run yves`.

## Checkout Integration

To plug into checkout process, you need to add plugins into `CheckoutDependencyProvider:`

```php
protected function getCheckoutPreConditions(Container $container)
{
 return [
 ....
 new AmazonPayConfirmOrderPreConditionPlugin(),
 ];
}

protected function getCheckoutOrderSavers(Container $container)
{
 return [
 ....
 new AmazonPaySaveOrderPlugin(),
 ];
}
```

`AmazonPayConfirmOrderPreConditionPlugin` should be placed as the last plugin for preconditions.

AmazonPay expects that order is not placed in some cases. For example, it happens when Synchronos mode is on, and payment cannot be processed.

In order to handle this,  extend `SuccessStep` in your project.

```php
/**
 * @param \Spryker\Shared\Kernel\Transfer\AbstractTransfer|\Generated\Shared\Transfer\QuoteTransfer $quoteTransfer
 *
 * @return bool
 */
public function postCondition(AbstractTransfer $quoteTransfer)
{
 if ($quoteTransfer->getAmazonpayPayment() === null) {
 return true;
 }

 if ($quoteTransfer->getAmazonpayPayment()->getOrderReferenceId() === null) {
 return false;
 }

 return true;
}
```
