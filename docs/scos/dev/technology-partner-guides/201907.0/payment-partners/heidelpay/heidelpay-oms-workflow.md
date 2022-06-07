---
title: Heidelpay OMS workflow
search: exclude
last_updated: Nov 4, 2020
template: concept-topic-template
---

We use state machines for handling and managing orders and payments.
To use Heidelpay, [create a new OMS](/docs/scos/dev/back-end-development/data-manipulation/creating-an-order-management-system-spryker-commerce-os.html) which includes necessary Heildelpay payment methods. You can use the same state machines or build new ones. The state machine commands and conditions trigger Heidelpay facade calls in order to perform the needed requests to Heidelpay API.

Some examples of the basic and fully functional state machines for each payment method were already built: `vendor/spryker-eco/heidelpay/config/Zed/Oms`

* `HeidelpaySofort01.xml`
* `HeidelpayPaypalDebit01.xml`
* `HeidelpayIdeal01.xml`
* `HeidelpaySofort01.xml`
* `HeidelpayCreditCardSecureAuthorize01.xml`
