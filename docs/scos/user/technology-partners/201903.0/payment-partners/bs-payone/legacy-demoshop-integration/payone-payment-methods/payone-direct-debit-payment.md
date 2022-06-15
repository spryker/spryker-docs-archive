---
title: PayOne - Direct Debit Payment
search: exclude
description: Integrate Direct Debit payment through Payone into the Spryker-based shop.
last_updated: Nov 22, 2019
template: concept-topic-template
originalLink: https://documentation.spryker.com/v2/docs/payone-direct-debit
originalArticleId: b8d52b5d-29df-4b4b-9bb1-84df8d7b2c4c
redirect_from:
  - /v2/docs/payone-direct-debit
  - /v2/docs/en/payone-direct-debit
  - /docs/scos/user/technology-partners/201903.0/payment-partners/bs-payone/legacy-demoshop-integration/payone-direct-debit-payment.html
related:
  - title: PayOne - Prepayment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-prepayment.html
  - title: PayOne - Authorization and Preauthorization Capture Flows
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-authorization-and-preauthorization-capture-flows.html
  - title: PayOne - Invoice Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-invoice-payment.html
  - title: PayOne - Cash on Delivery
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/scos-integration/payone-cash-on-delivery.html
  - title: PayOne - Security Invoice Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-security-invoice-payment.html
  - title: PayOne - Online Transfer Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-online-transfer-payment.html
---

## Front-End Integration

Run the `antelope build yves` after you include the javascript file for credit card check inside the payment step template (e.g. `src/<project_name>/Yves/Checkout/Theme/<custom_theme_name>/checkout/payment.twig`)

```php
{% raw %}{%{% endraw %} block content {% raw %}%}{% endraw %}
<script src="/assets/default/js/spryker-yves-payone-main.js"></script>
{% raw %}{%{% endraw %} endblock {% raw %}%}{% endraw %}```

In order to display SEPA mandate text and references, apply next modifications to project templates:

To display SEPA mandate text on summary page of checkout, add the following reference into `src/<project_name>/Yves/Checkout/Theme/<custom_theme_name>/checkout/summary.twig`
```php
{% raw %}{%{% endraw %} include '@payone/checkout/partials/summary-payment-details.twig' {% raw %}%}{% endraw %}
```

To display a link to the SEPA mandate in PDF format on checkout success page, add the following reference into `src/<project_name>/Yves/Checkout/Theme/<custom_theme_name>/checkout/success.twig`
```php
{% raw %}{%{% endraw %} include '@payone/checkout/partials/success-payment-details.twig' {% raw %}%}{% endraw %}
```

To display link to SEPA mandate in PDF format on order details page in customer cabinet, add the following reference into `src/<project_name>/Yves/Customer/Theme/<custom_theme_name>/order/details.twig`
```php
{% raw %}{%{% endraw %} include '@payone/order/partials/details-payment-data.twig' {% raw %}%}{% endraw %}
```

To adjust frontend appearance, provide following templates in your theme directory:

* `src/<project_name>/Yves/Payone/Theme/<custom_theme_name>/direct_debit.twig`
* `src/<project_name>/Yves/Payone/Theme/<custom_theme_name>/index/get-file.twig`
* `src/<project_name>/Yves/Payone/Theme/<custom_theme_name>/checkout/partials/summary-payment-details.twig`
* `src/<project_name>/Yves/Payone/Theme/<custom_theme_name>/checkout/partials/success-payment-details.twig`
* `src/<project_name>/Yves/Payone/Theme/<custom_theme_name>/order/partials/details-payment-data.twig`

## State Machine Integration

The Payone module provides demo state machine for Direct Debit payment method which implements Pre-Authorization/Capture flow. It's also possible to implement Authorization flow using corresponding command.

To enable the demo state machine, extend the configuration with following values:

```php
<?php
$config[SalesConstants::PAYMENT_METHOD_STATEMACHINE_MAPPING] = [
 ...
 PayoneConfig::PAYMENT_METHOD_DIRECT_DEBIT => 'PayoneDirectDebit',
];

$config[OmsConstants::ACTIVE_PROCESSES] = [
 ...
 'PayoneDirectDebit',
];
```

## Direct Debit Payment Flow:

1. When customer enters the payment details on checkout, a manage mandate request is submitted to Payone, which serves for automatic bank account data translation into IBAN/BIC pair(only for DE), IBAN/BIC validation and for SEPA mandate management (either an existing one will be used or a new one will be created).
2. If a new mandate was created, the customer is presented with a SEPA mandate text on checkout summary step. User agrees with SEPA mandate terms by placing an order. There's no agreement text displayed if existing SEPA mandate was found and was recognized by Payone.
3. On order placement, authorize (or preauthorize) command confirms user agreement with SEPA mandate terms. The customer is presented with a link to mandate in PDF format on successful order placement. Same link is available inside the order details page in customer cabinet.
