---
title: Tutorial - Interacting with Third Party Payment Providers via Glue API
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/t-interacting-with-third-party-payment-providers-via-glue-api
originalArticleId: c9d486b4-ac75-46f5-917e-f3935043f018
redirect_from:
  - /2021080/docs/t-interacting-with-third-party-payment-providers-via-glue-api
  - /2021080/docs/en/t-interacting-with-third-party-payment-providers-via-glue-api
  - /docs/t-interacting-with-third-party-payment-providers-via-glue-api
  - /docs/en/t-interacting-with-third-party-payment-providers-via-glue-api
  - /v6/docs/t-interacting-with-third-party-payment-providers-via-glue-api
  - /v6/docs/en/t-interacting-with-third-party-payment-providers-via-glue-api
  - /v5/docs/t-interacting-with-third-party-payment-providers-via-glue-api
  - /v5/docs/en/t-interacting-with-third-party-payment-providers-via-glue-api
  - /v4/docs/t-interacting-with-third-party-payment-providers-via-glue-api
  - /v4/docs/en/t-interacting-with-third-party-payment-providers-via-glue-api
  - /v3/docs/t-interacting-with-third-party-payment-providers-via-glue-api
  - /v3/docs/en/t-interacting-with-third-party-payment-providers-via-glue-api

related:
  - title: Technology Partner Integration
    link: docs/scos/user/technology-partners/page.version/technology-partners.html
---

The checkout process of Spryker Glue API can be leveraged to involve third parties in the process of order confirmation. This can be required, for example, when the method of payment selected by the user requires additional steps to complete the purchase. These can include, but not limited to, card validation, processing a bank transfer, etc.
{% info_block infoBox %}

For details, see [Checking Out Purchases and Getting Checkout Data](/docs/scos/dev/glue-api-guides/{{site.version}}/checking-out/checking-out-purchases.html).

{% endinfo_block %}
In this tutorial, you will find out how to invoke third parties in the API payment process.

## 1. Create New Module
To implement third party interactions, first, you need to create a new module or extend an existing one. Let us create one on the Project level. The module needs to interact with 2 layers of Spryker Commerce OS: **Glue** (API) and **Zed** (backend). Thus, you need to create the following folders for module *MyModule*:

* `src/Pyz/Glue/MyModule`
* `src/Pyz/Zed/MyModule`

The module needs to implement 2 plugins:
1. A plugin that maps the response of the `/checkout` API endpoint and fills it with the necessary attributes.
{% info_block infoBox %}

The `redirectUrl` and `isExternalRedirect` attributes are auto-mapped out of the box. If necessary, you can add your own attributes. For example, if a payment system requires a vendor ID for order confirmation, you can create a separate attribute to pass the ID to the API Client.

{% endinfo_block %}
2. A plugin to process the response of the payment service provider.
The overall interaction diagram between Glue API, the API Client, and the third party is as follows:

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/Advanced/Glue+API/Tutorial+Interacting+with+Third+Party+Payment+Providers+via+Glue+API/multi-step-checkout-glue-infrastructure.png)

## 2. Implement Checkout Response Mapper Plugin
First, we need to implement a plugin that maps the checkout response and fills it with the necessary redirect URL and other attributes that are mapped. To do so, create a plugin file on the **Glue** layer: `src/Pyz/Glue/MyModule/Plugin/CheckoutRestApi/CheckoutResponseMapperPlugin.php`.

The plugin must implement the **CheckoutResponseMapperPluginInterface**. Using the the `mapRestCheckoutResponseTransferToRestCheckoutResponseAttributesTransfer` function of the interface, you can set the redirect URL and specify whether it is an internal or external redirect.

**Sample implementation**

```php
<?php

namespace Pyz\Glue\MyModule\Plugin\CheckoutRestApi;

use Generated\Shared\Transfer\RestCheckoutResponseAttributesTransfer;
use Generated\Shared\Transfer\RestCheckoutResponseTransfer;
use Spryker\Glue\CheckoutRestApiExtension\Dependency\Plugin\CheckoutResponseMapperPluginInterface;
use Spryker\Glue\Kernel\AbstractPlugin;

class CheckoutResponseMapperPlugin extends AbstractPlugin implements CheckoutResponseMapperPluginInterface
{
    /**
     * @param \Generated\Shared\Transfer\RestCheckoutResponseTransfer $restCheckoutResponseTransfer
     * @param \Generated\Shared\Transfer\RestCheckoutResponseAttributesTransfer $restCheckoutResponseAttributesTransfer
     *
     * @return \Generated\Shared\Transfer\RestCheckoutResponseAttributesTransfer
     */
    public function mapRestCheckoutResponseTransferToRestCheckoutResponseAttributesTransfer(
        RestCheckoutResponseTransfer $restCheckoutResponseTransfer,
        RestCheckoutResponseAttributesTransfer $restCheckoutResponseAttributesTransfer
    ): RestCheckoutResponseAttributesTransfer {
        $restCheckoutResponseTransfer->getCheckoutResponse()->getRedirectUrl();

        $restCheckoutResponseAttributesTransfer
            ->setIsExternalRedirect($restCheckoutResponseTransfer->getCheckoutResponse()->getIsExternalRedirect())
            ->setRedirectUrl($restCheckoutResponseTransfer->getCheckoutResponse()->getRedirectUrl());

        return $restCheckoutResponseAttributesTransfer;
    }
}
```

## 3. Implement Payload Processor Plugin

After a user completes payment verification, the payment service provider will submit a payload containing the relevant payment information. The payload will be submitted by the API client to the `/order-payments` endpoint.

To process the data, we need to implement another plugin on the Zed layer. The plugin will update the payment information in the database. Create a plugin file as follows: `src/Pyz/Zed/MyModule/Communication/Plugin/OrderPaymentsRestApi/OrderPaymentUpdaterPlugin.php`.

The plugin must extend the OrderPaymentUpdaterPluginInterface and implement the following two functions:

* `isAppplicable` - this function determines whether a specific payment is processed by the plugin. The function must return true if the payment should be processed, otherwise it must return false.
* `updateOrderPayment` - this function should update the payment data in the database.

To help you understand which payments need to be processed, you can use the optional **paymentIdentifier** field in POST requests to the `/order-payments` endpoint. To make sure it is always present in a request, you may require the API client to set the field to a specific value to invoke your payment plugin. The value of the field can be retrieved using the `getPaymentIdentifier` helper function.

{% info_block infoBox %}

For details, see [Updating Payment Data](/docs/scos/dev/glue-api-guides/{{site.version}}/checking-out/updating-payment-data.html).

{% endinfo_block %}

**Sample implementation**

```php
<?php

namespace Pyz\Zed\MyModule\Communication\Plugin\OrderPaymentsRestApi;

use Generated\Shared\Transfer\UpdateOrderPaymentRequestTransfer;
use Generated\Shared\Transfer\UpdateOrderPaymentResponseTransfer;
use Spryker\Zed\Kernel\Communication\AbstractPlugin;
use Spryker\Zed\OrderPaymentsRestApiExtension\Dependency\Plugin\OrderPaymentUpdaterPluginInterface;

class OrderPaymentUpdaterPlugin extends AbstractPlugin implements OrderPaymentUpdaterPluginInterface
{
    /**
     * @param \Generated\Shared\Transfer\UpdateOrderPaymentRequestTransfer $updateOrderPaymentRequestTransfer
     *
     * @return bool
     */
    public function isApplicable(UpdateOrderPaymentRequestTransfer $updateOrderPaymentRequestTransfer): bool
    {
        if ($updateOrderPaymentRequestTransfer->getPaymentIdentifier()) {
            return true;
        }

        return false;
    }

    /**
     * @param \Generated\Shared\Transfer\UpdateOrderPaymentRequestTransfer $updateOrderPaymentRequestTransfer
     *
     * @return \Generated\Shared\Transfer\UpdateOrderPaymentResponseTransfer
     */
    public function updateOrderPayment(UpdateOrderPaymentRequestTransfer $updateOrderPaymentRequestTransfer): UpdateOrderPaymentResponseTransfer
    {
        $payload = $updateOrderPaymentRequestTransfer->getDataPayload();

        return (new UpdateOrderPaymentResponseTransfer())
            ->setIsSuccessful(true)
            ->setPaymentIdentifier($updateOrderPaymentRequestTransfer->getPaymentIdentifier())
            ->setDataPayload($updateOrderPaymentRequestTransfer->getDataPayload());
    }
}

```

## 4. Plugin Wiring

Now, you need to wire the plugins so that they could be invoked during checkout. The Checkout *Response Mapper Plugin* needs to be registered in `\Pyz\Glue\CheckoutRestApi\CheckoutRestApiDependencyProvider::getCheckoutResponseMapperPlugins()`:

```php
...
    /**
     * @return \Spryker\Glue\CheckoutRestApiExtension\Dependency\Plugin\CheckoutResponseMapperPluginInterface[]
     */
    protected function getCheckoutResponseMapperPlugins(): array
    {
        return [
            ...
            new CheckoutResponseMapperPlugin
        ];
    }
...
```

The *Payment Processor Plugin* is registered in `\Spryker\Zed\OrderPaymentsRestApi\OrderPaymentsRestApiDependencyProvider::getOrderPaymentUpdaterPlugins()`

```php
...
    /**
     * @return \Spryker\Zed\OrderPaymentsRestApiExtension\Dependency\Plugin\OrderPaymentUpdaterPluginInterface[]
     */
    protected function getOrderPaymentUpdaterPlugins(): array
    {
        return [
            ...
            new OrderPaymentUpdaterPlugin
        ];
    }
...
```

After wiring the plugins, the response of the `/checkout` endpoint will contain a correct redirect URL, and the `/order-payments` endpoint will process payloads received from the payment provider. Try accessing the endpoints to verify that the plugins process the data.
