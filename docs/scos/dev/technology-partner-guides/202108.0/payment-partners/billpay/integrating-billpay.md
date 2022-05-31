---
title: Integrating Billpay
last_updated: Jun 16, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/billpay-integration
originalArticleId: 3d4bf922-652c-45c7-b130-951015ff3b65
redirect_from:
  - /2021080/docs/billpay-integration
  - /2021080/docs/en/billpay-integration
  - /docs/billpay-integration
  - /docs/en/billpay-integration
  - /docs/scos/user/technology-partners/202108.0/payment-partners/billpay/billpay-integration.html
related:
  - title: Billpay
    link: docs/scos/user/technology-partners/page.version/payment-partners/billpay.html
---

Billpay offers multiple payment methods (Invoice, Direct Debit, PayLater, Instalment). Availability of payment methods differs from country to country. Please contact Billpay directly or visit the [Billpay website](https://www.billpay.de/en/)e  for details.

The Billpay module provides integration with the [Invoice with prescoring](https://www.billpay.de/en/klarna-group-for-business/index.html) payment method.

## Configuration

Billpay comes with a `config.dist.php` file that you can use as a sample configuration for your project by copying its content to your project configuration file. You can find all of your project configuration files in the `config `folder.

See [Configuration Management](/docs/scos/dev/back-end-development/data-manipulation/configuration-management.html) for details on the configuration.

### Configuration Options:

| NAME | DESCRIPTION |
| --- | --- |
| `GATEWAY_URL` | url to Billpay API |
| `BILLPAY_MERCHANT_ID` | Merchant ID that Billpay will provide to you |
| `BILLPAY_PORTAL_ID` | Portal ID that Billpay will provide to you |
| `BILLPAY_SECURITY_KEY` | MD5 hash of the security key generated for this portal. (generated and delivered by BillPay) |
| `BILLPAY_PUBLIC_API_KEY` | Public API Key; generated and delivered by BillPay for your portal. |
| `BILLPAY_MAX_DELAY_IN_DAYS` | Amount of days that will be added to the payment due date (e.g. in case of delayed shipping) |
| `USE_MD5_HASH` | If your security key is not md5 hash encrypted, you can do that by setting this config to 1 |
| `USE_PRESCORE` | In if it is necessary to show all Billpay payment methods despite of Billpay prescore response, you can set this option to 0. It should be set to 1 by default. |

When you add options above to your project configuration, it should look somewhat like this:

```php
<?php
$config[BillpayConstants::GATEWAY_URL] = 'https://test-api.billpay.de/xml/offline';
$config[BillpayConstants::BILLPAY_MERCHANT_ID] = '6063';
$config[BillpayConstants::BILLPAY_PORTAL_ID] = '8635';
$config[BillpayConstants::BILLPAY_SECURITY_KEY] = 'IzjZ8hUwPQt6';
$config[BillpayConstants::BILLPAY_PUBLIC_API_KEY] = 'a39eb681636dec360000008635';
$config[BillpayConstants::BILLPAY_MAX_DELAY_IN_DAYS] = 20;
$config[BillpayConstants::USE_MD5_HASH] = 1;
$config[BillpayConstants::USE_PRESCORE] = 1;
```

## Additional Configuration Options

Payone module provides dependency injectors to extend checkout and order processing. Please add or extend with the corresponding keys:

```php
<?php
$config[KernelConstants::DEPENDENCY_INJECTOR_YVES] = [
 'Checkout' => [
 'Billpay',
 ],
];

$config[KernelConstants::DEPENDENCY_INJECTOR_ZED] = [
 'Payment' => [
 'Billpay',
 ],
 'Oms' => [
 'Billpay',
 ],
];
```

In order to use the Billpay module state machines,  add the location path to configuration:

```php
<?php
$config[OmsConstants::PROCESS_LOCATION] = [
 OmsConfig::DEFAULT_PROCESS_LOCATION,
 $config[KernelConstants::SPRYKER_ROOT] . '/Billpay/config/Zed/Oms',
];

$config[OmsConstants::ACTIVE_PROCESSES] = [
 'BillpayInvoice01',
];
```

We link the OMS state machine with payment method as shown bellow:

```php
<?php
$config[SalesConstants::PAYMENT_METHOD_STATEMACHINE_MAPPING] = [
 BillpayConstants::PAYMENT_METHOD_INVOICE => 'BillpayInvoice01',
];
```
