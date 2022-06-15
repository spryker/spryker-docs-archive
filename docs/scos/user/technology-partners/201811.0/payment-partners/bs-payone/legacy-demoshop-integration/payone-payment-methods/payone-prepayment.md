---
title: PayOne - Prepayment
search: exclude
description: Integrate prepayment through Payone into the Spryker-based shop.
last_updated: Oct 22, 2019
template: concept-topic-template
originalLink: https://documentation.spryker.com/v1/docs/payone-prepayment
originalArticleId: 20225f1c-0df1-4498-97d2-6d7a6b7fabdd
redirect_from:
  - /v1/docs/payone-prepayment
  - /v1/docs/en/payone-prepayment
  - /docs/scos/user/technology-partners/201811.0/payment-partners/bs-payone/legacy-demoshop-integration/payone-prepayment.html
related:
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

Prepayment method is a safe alternative to payments involving credit cards or debit cards (such as online banking transfer). Usually bank transfer would require manual processing to mark transaction as cancelled or completed, but the process is fully automated through the integration with the Payone platform.

The payment status is transmitted to the shop via a notification from the payment provider(Payone).

## Front-end Integration
To adjust the frontend appearance, provide the following templates in your theme directory:
`src/<project_name>/Yves/Payone/Theme/<custom_theme_name>/prepayment.twig`

## State Machine Integration
Payone module provides a demo state machine for Prepayment payment method which implements Preauthorization/Capture flow.

To enable the demo state machine, extend the configuration with the following values:

```php
<?php
$config[SalesConstants::PAYMENT_METHOD_STATEMACHINE_MAPPING] = [
 ...
 PayoneConfig::PAYMENT_METHOD_PRE_PAYMENT => 'PayonePrePayment',
];

$config[OmsConstants::ACTIVE_PROCESSES] = [
 ...
 'PayonePrePayment',
];
```
