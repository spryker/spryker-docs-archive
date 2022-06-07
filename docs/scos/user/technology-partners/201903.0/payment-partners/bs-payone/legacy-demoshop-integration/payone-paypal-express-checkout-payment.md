---
title: PayOne - PayPal Express Checkout Payment
search: exclude
description: IntegratePaypal express checkout through Payone into the Spryker-based shop.
last_updated: Nov 22, 2019
template: concept-topic-template
originalLink: https://documentation.spryker.com/v2/docs/payone-paypal-express-checkout
originalArticleId: ecbdfcdc-a3d4-410e-bfbc-966058482f5f
redirect_from:
  - /v2/docs/payone-paypal-express-checkout
  - /v2/docs/en/payone-paypal-express-checkout
  - /docs/scos/user/technology-partners/201903.0/payment-partners/bs-payone/legacy-demoshop-integration/payone-paypal-payment.html-express-checkout
related:
  - title: PayOne - Prepayment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-prepayment.html
  - title: PayOne - Authorization and Preauthorization Capture Flows
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-authorization-and-preauthorization-capture-flows.html
  - title: PayOne - Invoice Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-invoice-payment.html
  - title: PayOne - Cash on Delivery
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/scos-integration/payone-cash-on-delivery.html
  - title: PayOne - Direct Debit Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-direct-debit-payment.html
  - title: PayOne - Security Invoice Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-security-invoice-payment.html
  - title: PayOne - Online Transfer Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-online-transfer-payment.html
---

The payment using PayPal requires redirect to PayPal website. When the customer is redirected to PayPal's website, he must authorize himself and he has the option to either cancel or validate the transaction.

A concern regarding payment flows that require redirection on third party website pages is that you loose control over the customer's action (the customer can close the browser before accepting or canceling the transaction). If this is the case, PayPal sends an instant payment notification (IPN) to Payone, then Payone notifies Spryker.

## Front-end Integration

To adjust the frontend appearance, add the following templates in your theme directory:
`src/<project_name>/Yves/Cart/Theme/<custom_theme_name>/cart/parts/cart-summary.twig`

Add the following code below the checkout button or anywhere you want depending on your design:
```php
{% raw %}{{{% endraw %} render(path('payone-checkout-with-paypal-button')) {% raw %}}}{% endraw %}
```

You can also implement your own button if you want the button to be loaded without separate call to the controller, or if you want to change the design.

## Paypal Express Checkout Integration Description:

* Once you click on the "Checkout with PayPal" button, the genericpayment request is sent to Payone with `setexpresscheckout` action and success, failure and back URLs.
* In the response we receive a workorderid which is used for all other operations until the capture request and PayPal redirect URL.
* We store wordorderid to quote and redirect customer to the URL provided by Payone.
* On the PayPal page, customer has to log in and approve the intention of paying for the desired goods.
* After the customer clicks the button, he is redirected to success or failure URL, provided by the shop in the first request to Payone.
* After redirection to success action, one more genericpayment request to Payone is made with action `getexpresscheckoutdetails`.
* Payone sends us information about the customer like email and shipment data.
* Then the order is placed in our shop.
* After placing the order, the pre-authorization call is sent to Payone (and through it to PayPal). Workorderid is sent to Payone with this request.
* Order status becomes "pre-authorized pending" after the response with status OK is received.

## State Machine Integration

Payone module provides a demo state machine for Paypal Express Checkout payment method which implements Preauthorization/Capture flow.

To enable the demo state machine, extend the configuration with the following values:
```php
<?php
$config[SalesConstants::PAYMENT_METHOD_STATEMACHINE_MAPPING] = [
 ...
 PayoneConfig::PAYMENT_METHOD_PAYPAL_EXPRESS_CHECKOUT => 'PayonePaypalExpressCheckout',
];

$config[OmsConstants::ACTIVE_PROCESSES] = [
 ...
 'PayonePaypalExpressCheckout',
];
 ```

Note: You can find all needed configuration parameters in `config.dist.php` file inside Payone module.

## Extra Configuration

Express checkout redirects customer to the cart page if something goes wrong, so project developer should specify the cart route in project config:
```
 $config[PayoneConstants::PAYONE] = [<br>
...<br>
PayoneConstants::ROUTE_CART => CartControllerProvider::ROUTE_CART<br>
];
```
Also you need to specify URLs, used by Paypal to redirect a customer to the right places:
```php
 $config[PayoneConstants::PAYONE][PayoneConstants::PAYONE_REDIRECT_EXPRESS_CHECKOUT_SUCCESS_URL] = sprintf(
 '%s/payone/expresscheckout/load-details',
 $config[ApplicationConstants::BASE_URL_YVES]
);
 <br>
$config[PayoneConstants::PAYONE][PayoneConstants::PAYONE_REDIRECT_EXPRESS_CHECKOUT_FAILURE_URL] = sprintf(
 '%s/payone/expresscheckout/error',
 $config[ApplicationConstants::BASE_URL_YVES]
);
 <br>
$config[PayoneConstants::PAYONE][PayoneConstants::PAYONE_REDIRECT_EXPRESS_CHECKOUT_BACK_URL] = sprintf(
 '%s/payone/expresscheckout/back',
 $config[ApplicationConstants::BASE_URL_YVES]
);
```

## Flow Diagram
![Click Me](https://spryker.s3.eu-central-1.amazonaws.com/docs/Technology+Partners/Payment+Partners/BS+Payone/paypal-express-checkout-spryker-flow.png)
