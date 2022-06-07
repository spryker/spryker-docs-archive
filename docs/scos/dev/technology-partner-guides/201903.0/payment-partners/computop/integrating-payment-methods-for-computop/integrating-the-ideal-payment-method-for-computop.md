---
title: Integrating the iDeal payment method for Computop
search: exclude
description: Integrate iDeal payment through Computop into the Spryker-based shop.
last_updated: Jan 27, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v2/docs/computop-ideal
originalArticleId: 78e47366-fc2c-44d2-a752-1c8a9e711109
redirect_from:
  - /v2/docs/computop-ideal
  - /v2/docs/en/computop-ideal
  - /docs/scos/user/technology-partners/201903.0/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-ideal-payment-method-for-computop.html
related:
  - title: Integrating the Sofort payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-sofort-payment-method-for-computop.html
  - title: Integrating the PayPal payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paypal-payment-method-for-computop.html
  - title: Integrating the PayNow payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paynow-payment-method-for-computop.html
  - title: Integrating the Easy Credit payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-easy-credit-payment-method-for-computop.html
  - title: Integrating the Direct Debit payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-direct-debit-payment-method-for-computop.html
  - title: Integrating the Сredit Сard payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-credit-card-payment-method-for-computop.html
  - title: Integrating the CRIF payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-crif-payment-method-for-computop.html
  - title: Integrating the Paydirekt payment method for Computop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paydirekt-payment-method-for-computop.html
---

Example State Machine:
![Click Me](https://spryker.s3.eu-central-1.amazonaws.com/docs/Technology+Partners/Payment+Partners/Computop/computop-ideal-flow-example.png)

## Front-end Integration

To adjust the frontend appearance, provide the following templates in your theme directory:
`src/<project_name>/Yves/Computop/Theme/<custom_theme_name>/ideal.twig`

## State Machine Integration

The Computop provides a demo state machine for iDeal payment method which implements Capture flow.

To enable the demo state machine, extend the configuration with the following values:
```php
 <?php
$config[SalesConstants::PAYMENT_METHOD_STATEMACHINE_MAPPING] = [
 ...
 ComputopConfig::PAYMENT_METHOD_IDEAL => 'ComputopIdeal',
];

$config[OmsConstants::ACTIVE_PROCESSES] = [
 ...
 'ComputopIdeal',
];
```

## iDeal Payment Flow:

1. There is a radio button on "Payment" step. After submitting the order the customer will be redirected to the Computop (Paygate form implementation). The GET consists of 3 parameters:
  - data (encrypted parameters, f.e. currency, amount, description);
  - length (length of `data` parameter);
  - merchant id (assigned by Computop);
Customer sets up all data just after the redirect to Computop.
Init action: "Capture". There are no Order and Authorization calls provided for this payment method.
2. By default, on success the customer  will be redirected to "Success" step. The response contains `payId`. On error, the customer  will be redirected to "Payment" step with the error message by default. Response data is stored in the DB.
3. Refund action is implemented in the admin panel (on manage order). On requests, Spryker will use `payId` parameter stored in the DB to identify a payment.
