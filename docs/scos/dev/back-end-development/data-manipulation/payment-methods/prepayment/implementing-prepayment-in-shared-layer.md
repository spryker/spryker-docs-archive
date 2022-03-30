---
title: Implementing Prepayment in Shared Layer
description: This procedure will help us to identify the new payment type through some unique constants.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/ht-prepayment-shared
originalArticleId: 2c67a631-daed-4aeb-871b-6a797a8452bb
redirect_from:
  - /2021080/docs/ht-prepayment-shared
  - /2021080/docs/en/ht-prepayment-shared
  - /docs/ht-prepayment-shared
  - /docs/en/ht-prepayment-shared
  - /v6/docs/ht-prepayment-shared
  - /v6/docs/en/ht-prepayment-shared
  - /v5/docs/ht-prepayment-shared
  - /v5/docs/en/ht-prepayment-shared
  - /v4/docs/ht-prepayment-shared
  - /v4/docs/en/ht-prepayment-shared
  - /v3/docs/ht-prepayment-shared
  - /v3/docs/en/ht-prepayment-shared
  - /v2/docs/ht-prepayment-shared
  - /v2/docs/en/ht-prepayment-shared
  - /v1/docs/ht-prepayment-shared
  - /v1/docs/en/ht-prepayment-shared
---

This procedure will help us to identify the new payment type through some unique constants. We are going to define those constants under the Shared namespace, since they’re needed both by Yves and Zed.

1. Create the `PaymentMethodsConstants` interface under the `Shared` namespace, where you’ll define these unique constants.

<details open>
<summary markdown='span'>Code sample:</summary>

```php
<?php

namespace Pyz\Shared\PaymentMethods;

interface PaymentMethodsConstants
{

    /**
     * @const string
     */
    const PROVIDER = 'paymentmethods';

    /**
     * @const string
     */
    const PAYMENT_METHOD_PREPAYMENT = 'prepayment';

    /**
     * @const string
     */
    const PAYMENT_PREPAYMENT_FORM_PROPERTY_PATH = static::PROVIDER . static::PAYMENT_METHOD_PREPAYMENT;

}
```

<br>
</details>

2. Enrich the `Payment` transfer file with a new property that corresponds to the new payment method.

<details open>
<summary markdown='span'>Code sample:</summary>

```xml
<?xml version="1.0"?>
<transfers xmlns="spryker:transfer-01"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="spryker:transfer-01 http://static.spryker.com/transfer-01.xsd">

    <transfer name="Payment">
        <!-- Should be equal to PaymentMethodsConstants::PAYMENT_PREPAYMENT_FORM_PROPERTY_PATH. Then the form fields can be automatically mapped to the transfer object inside this field. -->
        <property name="paymentmethodsprepayment" type="string"/>
    </transfer>
    </transfers>
```

<br>
</details>

3. Run the `vendor/bin/console transfer:generate` command to have the `PaymentTransfer` class updated.
