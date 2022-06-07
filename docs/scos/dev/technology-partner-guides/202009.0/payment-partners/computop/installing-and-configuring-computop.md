---
title: Installing and configuring Computop
search: exclude
last_updated: Nov 4, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v6/docs/computop-installation-and-configuration
originalArticleId: e2ff7cd2-015b-47c5-8de6-a46efc0164b6
redirect_from:
  - /v6/docs/computop-installation-and-configuration
  - /v6/docs/en/computop-installation-and-configuration
---

To integrate Computop into your project, first you need to install and configure the Computop module. This topic describes how to do that.

The [SprykerEco.Computop](https://github.com/spryker-eco/computop) bundle provides integration of the Computop industry partner with Spryker Commerce OS. It requires the [SprykerEco.ComputopApi](https://github.com/spryker-eco/computop-api) bundle that provides the REST Client for making API calls to the Computop Payment Provider.

The `SprykerEco.Computop` module includes the integrations:
* Checkout process - payment forms with all the necessary fields that are required to make payment requests, save order information and so on.
* OMS (Order Management System) - state machines, all necessary commands for making modification requests and conditions for changing order statuses accordingly.


The `SprykerEco.Computop` module provides the following payment methods:

* [Credit Card](/docs/scos/dev/technology-partner-guides/{{page.version}}/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-credit-card-payment-method-for-computop.html)
* [Direct Debit](/docs/scos/dev/technology-partner-guides/{{page.version}}/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-direct-debit-payment-method-for-computop.html)
* [EasyCredit](/docs/scos/dev/technology-partner-guides/{{page.version}}/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-easy-credit-payment-method-for-computop.html)
* [iDeal](/docs/scos/dev/technology-partner-guides/{{page.version}}/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-ideal-payment-method-for-computop.html)
* [Paydirekt](/docs/scos/dev/technology-partner-guides/{{page.version}}/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paydirekt-payment-method-for-computop.html)
* [PayNow](/docs/scos/dev/technology-partner-guides/{{page.version}}/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paynow-payment-method-for-computop.html)
* [PayPal](/docs/scos/dev/technology-partner-guides/{{page.version}}/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-paypal-payment-method-for-computop.html)
* [SofortÜberweisung](/docs/scos/dev/technology-partner-guides/{{page.version}}/payment-partners/computop/integrating-payment-methods-for-computop/integrating-the-sofort-payment-method-for-computop.html)

## Installing Computop

To install the Computop module, run the command:

```bash
composer require spryker-eco/computop
```

## Configuration

You can check all the necessary configurations in `vendor/spryker-eco/computop/config/config.dist.php`.

Find an example of the Computop module configuration below:

<details open>
<summary>config/Shared/config_default.php</summary>

```php
// Spryker security configuration
$config[KernelConstants::DOMAIN_WHITELIST] = [
	...
    'www.computop-paygate.com', // trusted Computop domain, required for redirects to third party services.
];
$config[SessionConstants::YVES_SESSION_COOKIE_SAMESITE] = 'none'; //Allows redirect customer via POST from Computop back to the shop.

// Credantials
$config[ComputopApiConstants::MERCHANT_ID] = 'Computop merchant identifier';
$config[ComputopApiConstants::BLOWFISH_PASSWORD] = 'Password for blowfish hashing';
$config[ComputopApiConstants::HMAC_PASSWORD] = 'Password for hmac hashing';
$config[ComputopConstants::IDEAL_ISSUER_ID] = 'IDeal issuer identifier';
$config[ComputopConstants::PAYDIREKT_SHOP_KEY] = 'Paydirekt shop key';

// Init API call endpoints
$config[ComputopConstants::PAY_NOW_INIT_ACTION] = 'https://www.computop-paygate.com/paynow.aspx';
$config[ComputopConstants::CREDIT_CARD_INIT_ACTION] = 'https://www.computop-paygate.com/payssl.aspx';
$config[ComputopConstants::PAYPAL_INIT_ACTION] = 'https://www.computop-paygate.com/paypal.aspx';
$config[ComputopConstants::DIRECT_DEBIT_INIT_ACTION] = 'https://www.computop-paygate.com/paysdd.aspx';
$config[ComputopConstants::SOFORT_INIT_ACTION] = 'https://www.computop-paygate.com/sofort.aspx';
$config[ComputopConstants::PAYDIREKT_INIT_ACTION] = 'https://www.computop-paygate.com/paydirekt.aspx';
$config[ComputopConstants::IDEAL_INIT_ACTION] = 'https://www.computop-paygate.com/ideal.aspx';
$config[ComputopConstants::EASY_CREDIT_INIT_ACTION] = 'https://www.computop-paygate.com/easyCredit.aspx';
$config[ComputopConstants::PAYU_CEE_SINGLE_INIT_ACTION] = 'https://www.computop-paygate.com/payu.aspx';

// Post order place API calls endpoints
$config[ComputopApiConstants::PAYPAL_EXPRESS_PREPARE_ACTION] = 'https://www.computop-paygate.com/ExternalServices/paypalorders.aspx';
$config[ComputopApiConstants::PAYPAL_EXPRESS_COMPLETE_ACTION] = 'https://www.computop-paygate.com/paypalComplete.aspx';
$config[ComputopApiConstants::EASY_CREDIT_STATUS_ACTION] = 'https://www.computop-paygate.com/easyCreditDirect.aspx';
$config[ComputopApiConstants::EASY_CREDIT_AUTHORIZE_ACTION] = 'https://www.computop-paygate.com/easyCreditDirect.aspx';
$config[ComputopApiConstants::AUTHORIZE_ACTION] = 'https://www.computop-paygate.com/authorize.aspx';
$config[ComputopApiConstants::CAPTURE_ACTION] = 'https://www.computop-paygate.com/capture.aspx';
$config[ComputopApiConstants::REVERSE_ACTION] = 'https://www.computop-paygate.com/reverse.aspx';
$config[ComputopApiConstants::INQUIRE_ACTION] = 'https://www.computop-paygate.com/inquire.aspx';
$config[ComputopApiConstants::REFUND_ACTION] = 'https://www.computop-paygate.com/credit.aspx';

// Payment method specific configuration
$config[ComputopApiConstants::RESPONSE_MAC_REQUIRED] = [
    ComputopConfig::INIT_METHOD,
];
$config[ComputopConstants::CREDIT_CARD_TEMPLATE_ENABLED] = false;
$config[ComputopConstants::CREDIT_CARD_TX_TYPE] = '';
$config[ComputopConstants::PAY_NOW_TX_TYPE] = '';
$config[ComputopConstants::PAY_PAL_TX_TYPE] = ComputopConfig::TX_TYPE_AUTH;
$config[ComputopConstants::PAY_PAL_EXPRESS_PAYPAL_METHOD] = '';
$config[ComputopConstants::PAYMENT_METHODS_WITHOUT_ORDER_CALL] = [
    ComputopConfig::PAYMENT_METHOD_SOFORT,
    ComputopConfig::PAYMENT_METHOD_PAYDIREKT,
    ComputopConfig::PAYMENT_METHOD_IDEAL,
    ComputopConfig::PAYMENT_METHOD_CREDIT_CARD,
    ComputopConfig::PAYMENT_METHOD_PAY_NOW,
    ComputopConfig::PAYMENT_METHOD_PAY_PAL,
    ComputopConfig::PAYMENT_METHOD_PAY_PAL_EXPRESS,
    ComputopConfig::PAYMENT_METHOD_DIRECT_DEBIT,
    ComputopConfig::PAYMENT_METHOD_EASY_CREDIT,
    ComputopConfig::PAYMENT_METHOD_PAYU_CEE_SINGLE,
];
$config[ComputopApiConstants::PAYMENT_METHODS_CAPTURE_TYPES] = [
    ComputopApiConfig::PAYMENT_METHOD_PAYDIREKT => ComputopApiConfig::CAPTURE_TYPE_MANUAL,
    ComputopApiConfig::PAYMENT_METHOD_CREDIT_CARD => ComputopApiConfig::CAPTURE_TYPE_MANUAL,
    ComputopApiConfig::PAYMENT_METHOD_PAY_NOW => ComputopApiConfig::CAPTURE_TYPE_MANUAL,
    ComputopApiConfig::PAYMENT_METHOD_PAY_PAL => ComputopApiConfig::CAPTURE_TYPE_MANUAL,
    ComputopApiConfig::PAYMENT_METHOD_PAY_PAL_EXPRESS => ComputopApiConfig::CAPTURE_TYPE_MANUAL,
    ComputopApiConfig::PAYMENT_METHOD_DIRECT_DEBIT => ComputopApiConfig::CAPTURE_TYPE_MANUAL,
    ComputopApiConfig::PAYMENT_METHOD_PAYU_CEE_SINGLE => ComputopApiConfig::CAPTURE_TYPE_MANUAL,
];

// CRIF (formerly Deltavista) configuration
$config[ComputopConstants::CRIF_ENABLED] = true;
$config[ComputopApiConstants::CRIF_ACTION] = 'https://www.computop-paygate.com/deltavista.aspx';
$config[ComputopApiConstants::CRIF_PRODUCT_NAME] = ComputopConfig::CRIF_PRODUCT_NAME_QUICK_CHECK_CONSUMER;
$config[ComputopApiConstants::CRIF_LEGAL_FORM] = ComputopConfig::CRIF_LEGAL_FORM_PERSON;
$config[ComputopConstants::CRIF_GREEN_AVAILABLE_PAYMENT_METHODS] = [
    ComputopConfig::PAYMENT_METHOD_SOFORT,
    ComputopConfig::PAYMENT_METHOD_PAYDIREKT,
    ComputopConfig::PAYMENT_METHOD_IDEAL,
    ComputopConfig::PAYMENT_METHOD_CREDIT_CARD,
    ComputopConfig::PAYMENT_METHOD_PAY_NOW,
    ComputopConfig::PAYMENT_METHOD_PAY_PAL,
    ComputopConfig::PAYMENT_METHOD_PAY_PAL_EXPRESS,
    ComputopConfig::PAYMENT_METHOD_DIRECT_DEBIT,
    ComputopConfig::PAYMENT_METHOD_EASY_CREDIT,
    ComputopConfig::PAYMENT_METHOD_PAYU_CEE_SINGLE,
];
$config[ComputopConstants::CRIF_YELLOW_AVAILABLE_PAYMENT_METHODS] = [
    ComputopConfig::PAYMENT_METHOD_CREDIT_CARD,
    ComputopConfig::PAYMENT_METHOD_PAY_NOW,
    ComputopConfig::PAYMENT_METHOD_PAY_PAL,
    ComputopConfig::PAYMENT_METHOD_PAY_PAL_EXPRESS,
];
$config[ComputopConstants::CRIF_RED_AVAILABLE_PAYMENT_METHODS] = [
    ComputopConfig::PAYMENT_METHOD_CREDIT_CARD,
    ComputopConfig::PAYMENT_METHOD_EASY_CREDIT,
];
$config[ComputopShipmentConstants::PAYPAL_EXPRESS_DEFAULT_SHIPMENT_METHOD_KEY] = 'spryker_dummy_shipment-standard';
```

</details>

| Configuration Key | Type | Description |
| --- | --- | --- |
| `$config[ComputopApiConstants::MERCHANT_ID]` | string | Computop merchant identifier. |
| `$config[ComputopApiConstants::BLOWFISH_PASSWORD]` | string | Password for blowfish hashing. |
| `$config[ComputopApiConstants::HMAC_PASSWORD]` | string | Password for hmac hashing. |
| `$config[ComputopConstants::PAYDIREKT_SHOP_KEY]` | string | Shop key for Paydirect payment method. |
| `$config[ComputopConstants::IDEAL_ISSUER_ID]`  | string  | Issuer ID for Ideal payment method.  |
| `$config[ComputopConstants::PAY_NOW_INIT_ACTION]`  | string  | Init API call endpoint for PayNow payment method.  |
| `$config[ComputopConstants::CREDIT_CARD_INIT_ACTION]`  |string | Init API call endpoint for Credit Card payment method.  |
| `$config[ComputopConstants::PAYPAL_INIT_ACTION]`  | string  | Init API call endpoint for PayPal payment method.  |
| `$config[ComputopConstants::DIRECT_DEBIT_INIT_ACTION]`  | string  | Init API call endpoint for Direct Debit payment method.  |
| `$config[ComputopConstants::SOFORT_INIT_ACTION]`  | string  | Init API call endpoint for Sofort payment method.  |
| `$config[ComputopConstants::PAYDIREKT_INIT_ACTION]`  |string   | Init API call endpoint for Paydirect payment method.  |
| `$config[ComputopConstants::IDEAL_INIT_ACTION]`  | string  | Init API call endpoint for Ideal payment method.  |
| `$config[ComputopConstants::EASY_CREDIT_INIT_ACTION]`  | string  | Init API call endpoint for Easy Credit payment method.  |
| `$config[ComputopConstants::PAYU_CEE_SINGLE_INIT_ACTION]` | string | Init API call endpoint for PayU CEE Single payment method. |
| `$config[ComputopApiConstants::PAYPAL_EXPRESS_PREPARE_ACTION]` | string | Prepare API call endpoint for PayPal Express payment method. |
| `$config[ComputopApiConstants::PAYPAL_EXPRESS_COMPLETE_ACTION]` | string | Complete API call endpoint for PayPal Express payment method. |
| `$config[ComputopApiConstants::EASY_CREDIT_STATUS_ACTION]`  | string  | Status API call endpoint for Easy Credit payment method.  |
| `$config[ComputopApiConstants::EASY_CREDIT_AUTHORIZE_ACTION]` | string  | Authorize API call endpoint for Easy Credit payment method.  |
| `$config[ComputopApiConstants::AUTHORIZE_ACTION]`  | string  | Authorize API call endpoint.  |
| `$config[ComputopApiConstants::CAPTURE_ACTION]`  | string  | Capture API call endpoint.  |
| `$config[ComputopApiConstants::REVERSE_ACTION]`  | string  | Reserve API call endpoint.  |
| `$config[ComputopApiConstants::INQUIRE_ACTION]`  | string  | Inquire API call endpoint.  |
| `$config[ComputopApiConstants::REFUND_ACTION]`  | string  | Refund API call endpoint.  |
| `$config[ComputopApiConstants::RESPONSE_MAC_REQUIRED]`  | array  | MAC is required for methods (to check MAC on response).  |
| `$config[ComputopConstants::CREDIT_CARD_TEMPLATE_ENABLED]`  | bool  | Is custom template enabled for Credit Card payment method.  |
| `$config[ComputopConstants::CREDIT_CARD_TX_TYPE]`  | string  | TX TYPE for Credit Card payment method (empty string).  |
| `$config[ComputopConstants::PAY_NOW_TX_TYPE]`  | string  | TX TYPE for PayNow payment method (empty string).  |
| `$config[ComputopConstants::PAY_PAL_TX_TYPE]`  | string  |  TX TYPE for PayPal payment method (Auth). |
| `$config[ComputopConstants::PAY_PAL_EXPRESS_PAYPAL_METHOD]` | string | Using method for PayPal Express payment method. |
| `$config[ComputopConstants::PAYMENT_METHODS_WITHOUT_ORDER_CALL]`  | array  | Array of payment methods without order call.  |
| `$config[ComputopApiConstants::PAYMENT_METHODS_CAPTURE_TYPES]`  | array  | Array with mapping payment methods and their capture types (MANUAL or AUTO).  |
| `$config[ComputopConstants::CRIF_ENABLED]`  | bool  | Is CRIF risk check enabled.  |
| `$config[ComputopApiConstants::CRIF_ACTION]`  | string  | CRIF API call endpoint.  |
| `$config[ComputopApiConstants::CRIF_PRODUCT_NAME]`  | string  | `QuickCheckConsumer` or <br> `CreditCheckConsumer` or <br> `QuickCheckBusiness`  or  <br>`CreditCheckBusiness`  or <br>`IdentCheckConsume`.  |
| `$config[ComputopApiConstants::CRIF_LEGAL_FORM]`  | string  | PERSON or COMPANY or UNKNOWN.  |
| `$config[ComputopConstants::CRIF_GREEN_AVAILABLE_PAYMENT_METHODS]`  | array  | List of payment methods available with green response code.  |
| `$config[ComputopConstants::CRIF_YELLOW_AVAILABLE_PAYMENT_METHODS] ` | array  | List of payment methods available with yellow response code.  |
| `$config[ComputopConstants::CRIF_RED_AVAILABLE_PAYMENT_METHODS]`  | array  | List of payment methods available with red response code.  |
