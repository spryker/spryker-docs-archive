---
title: Integrating the Сredit Сard payment method for Computop
description: Integrate  Credit Card payment through Computop into the Spryker-based shop.
last_updated: Jul 31, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v2/docs/computop-credit-card
originalArticleId: d3e31474-ec4c-43d6-afa5-0d19c64fde73
redirect_from:
  - /v2/docs/computop-credit-card
  - /v2/docs/en/computop-credit-card
  - /docs/scos/user/technology-partners/201903.0/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-credit-card-payment-method-for-computop.html
related:
  - title: Computop
    link: docs/scos/user/technology-partners/page.version/payment-partners/computop.html
  - title: Integrating the Sofort payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-sofort-payment-method-for-computop.html
  - title: Integrating the PayPal payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paypal-payment-method-for-computop.html
  - title: Integrating the PayNow payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paynow-payment-method-for-computop.html
  - title: Computop API calls
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/computop-api-calls.html
  - title: Integrating the Direct Debit payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-direct-debit-payment-method-for-computop.html
  - title: Integrating the iDeal payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-ideal-payment-method-for-computop.html
  - title: Integrating the Easy Credit payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-easy-credit-payment-method-for-computop.html
  - title: Integrating the Paydirekt payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paydirekt-payment-method-for-computop.html
  - title: Integrating the CRIF payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-crif-payment-method-for-computop.html
---

Example State Machine:
![Click Me](https://cdn.document360.io/9fafa0d5-d76f-40c5-8b02-ab9515d3e879/Images/Documentation/computop-credit-card-flow-example.png)

## Front-end Integration

To adjust the frontend appearance, provide the following templates in your theme directory:
`src/<project_name>/Yves/Computop/Theme/<custom_theme_name>/credit_card.twig`

## State Machine Integration

The Computop provides a demo state machine for the Credit Card payment method which implements Authorization/Capture flow.

To enable the demo state machine, extend the configuration with the following values:

```php
 <?php
$config[SalesConstants::PAYMENT_METHOD_STATEMACHINE_MAPPING] = [
 ...
 ComputopConfig::PAYMENT_METHOD_CREDIT_CARD => 'ComputopCreditCard',
];

$config[OmsConstants::ACTIVE_PROCESSES] = [
 ...
 'ComputopCreditCard',
];
```

## Credit Card Payment Flow

1. There is a radio button on "Payment" step. After submitting the order the customer will be redirected to the to Computop (Pay gate form implementation). The GET consists of 3 parameters:
  - data (encrypted parameters, e.g. currency, amount, description);
  - length (length of 'data' parameter);
  - merchant id (assigned by Computop).The customer sets up all data just after redirect to Computop.
         Init action: "Order".
2. By default, on success the customer  will be redirected to "Success" step. The response contains `payId` On error, the customer will be redirected to "Payment" step with the error message by defaul.  Response data is stored in the DB.
3. Authorization is added  right after success init action by default. Capture/Refund and Cancel actions are implemented in the admin panel (on manage order).  On requests, Spryker will use `payId` parameter stored in the DB to identify a payment.

## Set Up Details:

For partial capturing:

1. Case: Merchant uses neither ETM nor PCN (`PseudoCardNumber`). After authorization has been done, you are able to do one capture. This can be a partial or a complete capture of the authorized amount. After the capture is performed you cannot do another capture. If it is a partial capture, the rest of the initial authorized amount is released.
2. Case: Merchant uses ETM (Extended Transactions Management). You can do partial captures as long as the as the initial amount of the authorization has not been reached or you send `FinishAuth=Y` with the last capture you like to do. (see page 83 of Computop documentation)
3. Case: Merchant uses PCN. With the authorization request you get back the PCN and other credit card parameter (Expiry Date, Brand). PCN and the other parameters can be stored.

You capture the full amount of the authorization via `capture.aspx` => Nothing else has to be done.

You capture a partial amount of the authorization => The rest of the amount forfeited. To do the next partial capture, you have to use the PCN with the `direct.aspx` (page 53  of Computop documentation) and the additional parameter VBV=NO in the request to get a new authorization. After that you proceed as described above.

**See also:**

* [Get a general idea about Computop](/docs/scos/user/technology-partners/201903.0/payment-partners/computop.html)
* [Learn about Computop API](/docs/scos/user/technology-partners/201903.0/payment-partners/computop/computop-api-calls.html)
* [Get acquainted with Computop OMS functioning](/docs/scos/user/technology-partners/201903.0/payment-partners/computop/computop-oms-plugins.html)
* [Configure Computop CRIF](/docs/scos/user/technology-partners/201903.0/payment-partners/computop.html)
* [Configure Direct Debit payment method for Computop](/docs/scos/user/technology-partners/201903.0/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-direct-debit-payment-method-for-computop.html)
* [Configure Easy Credit payment method for Computop](/docs/scos/user/technology-partners/201903.0/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-easy-credit-payment-method-for-computop.html)
* [Configure iDeal payment method for Computop](/docs/scos/user/technology-partners/201903.0/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-ideal-payment-method-for-computop.html)
* [Configure Paydirekt payment method for Computop](/docs/scos/user/technology-partners/201903.0/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paydirekt-payment-method-for-computop.html)
* [Configure PayNow payment method for Computop](/docs/scos/user/technology-partners/201903.0/payment-partners/computop.html)
* [Configure PayPal payment method for Computop](/docs/scos/user/technology-partners/201903.0/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paypal-payment-method-for-computop.html)
* [Configure Sofort payment method for Computop](/docs/scos/user/technology-partners/201903.0//payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-sofort-payment-method-for-computop.html)
