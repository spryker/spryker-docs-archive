---
title: Multi-step Checkout
search: exclude
description: The checkout is based on a flexible step engine and can be adjusted to any use case.
last_updated: May 28, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/v6/docs/multi-step-checkout
originalArticleId: a79df6fe-d952-45fa-b041-37a40bed5c64
redirect_from:
  - /v6/docs/multi-step-checkout
  - /v6/docs/en/multi-step-checkout
---

The checkout workflow is a fully customizable multi-step process. The standard steps include customer registration and login, shipping and billing address, shipment method and costs, payment method, checkout overview, and checkout success.

Using the Spryker step engine, you can design different checkout types, like a one-page checkout or an invoice page replacing the payment page. The step engine enables the following:

* Checkout as guest, registered customer or register in the checkout flow.
* Hooks for integrating payment or shipment methods.
* Progress bar to navigate between checkout steps.

The following example shows how the checkout works in the Spryker Demo Shop for a guest user:

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Checkout/Multi-Step+Checkout/shop-guide-checkout.gif)

