---
title: Integrating Prepayment into Checkout
description: This article describes how to integrate prepayment into Checkout.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/ht-prepayment-checkout
originalArticleId: 65a81e54-d406-4b80-a3fc-875d1301d2ac
redirect_from:
  - /2021080/docs/ht-prepayment-checkout
  - /2021080/docs/en/ht-prepayment-checkout
  - /docs/ht-prepayment-checkout
  - /docs/en/ht-prepayment-checkout
  - /v6/docs/ht-prepayment-checkout
  - /v6/docs/en/ht-prepayment-checkout
  - /v5/docs/ht-prepayment-checkout
  - /v5/docs/en/ht-prepayment-checkout
  - /v4/docs/ht-prepayment-checkout
  - /v4/docs/en/ht-prepayment-checkout
  - /v3/docs/ht-prepayment-checkout
  - /v3/docs/en/ht-prepayment-checkout
  - /v2/docs/ht-prepayment-checkout
  - /v2/docs/en/ht-prepayment-checkout
  - /v1/docs/ht-prepayment-checkout
  - /v1/docs/en/ht-prepayment-checkout
---

The next step is to integrate prepayment into `Checkout`. In the `PaymentMethods/Dependency/Injector` from Yves add the `CheckoutDependencyInjector` that will inject the prepayment form and handler into the `Checkout` module:

<details open>
<summary markdown='span'>Code sample:</summary>

```php
<?php

namespace Pyz\Yves\PaymentMethods\Dependency\Injector;

use Spryker\Shared\Kernel\ContainerInterface;
use Spryker\Shared\Kernel\Dependency\Injector\DependencyInjectorInterface;
use Spryker\Yves\Checkout\CheckoutDependencyProvider;
use Pyz\Yves\PaymentMethods\Plugin\PrepaymentHandlerPlugin;
use Pyz\Yves\PaymentMethods\Plugin\PrepaymentSubFormPlugin;
use Spryker\Yves\StepEngine\Dependency\Plugin\Form\SubFormPluginCollection;
use Spryker\Yves\StepEngine\Dependency\Plugin\Handler\StepHandlerPluginCollection;
use Pyz\Shared\PaymentMethods\PaymentMethodsConstants;

class CheckoutDependencyInjector implements DependencyInjectorInterface
{
    /**
     * @param \Spryker\Shared\Kernel\ContainerInterface|\Spryker\Yves\Kernel\Container $container
     *
     * @return \Spryker\Shared\Kernel\ContainerInterface|\Spryker\Yves\Kernel\Container
     */
    public function inject(ContainerInterface $container)
    {
        $container = $this->injectPaymentSubForms($container);
        $container = $this->injectPaymentMethodHandler($container);

        return $container;
    }

    /**
     * @param \Spryker\Shared\Kernel\ContainerInterface $container
     *
     * @return \Spryker\Shared\Kernel\ContainerInterface
     */
    protected function injectPaymentSubForms(ContainerInterface $container)
    {
        $container->extend(static::PAYMENT_SUB_FORMS, function (SubFormPluginCollection $paymentSubForms) {
            $paymentSubForms->add(new PrepaymentSubFormPlugin());

            return $paymentSubForms;
        });

        return $container;
    }

    /**
     * @param \Spryker\Shared\Kernel\ContainerInterface $container
     *
     * @return \Spryker\Shared\Kernel\ContainerInterface
     */
    protected function injectPaymentMethodHandler(ContainerInterface $container)
    {
        $container->extend(static::PAYMENT_METHOD_HANDLER, function (StepHandlerPluginCollection $paymentMethodHandler) {
            $paymentMethodHandler->add(new PrepaymentHandlerPlugin(), PaymentMethodsConstants::PROVIDER);

            return $paymentMethodHandler;
        });

        return $container;
    }
}
```

<br>
</details>

{% info_block errorBox %}
If you re-created this example in Demoshop, you’ll need to do some adjustments on the selectPayment() from `checkout.js`.)
{% endinfo_block %}
