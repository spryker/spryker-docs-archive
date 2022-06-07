---
title: Managing Payment Methods
search: exclude
description: Use the guide to view, update, activate, and assign to stores payment methods in the Back Office.
last_updated: Dec 10, 2019
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v4/docs/managing-payment-methods
originalArticleId: c38e80af-d839-4196-ab29-9d93696a6279
redirect_from:
  - /v4/docs/managing-payment-methods
  - /v4/docs/en/managing-payment-methods
related:
  - title: Payments feature overview
    link: docs/scos/user/features/page.version/payments-feature-overview.html
  - title: Payment Methods- Reference Information
    link: docs/scos/user/back-office-user-guides/page.version/administration/payment-methods/references/payment-methods-reference-information.html
---

The topic describes the procedures you can perform on payment methods:

* View payment methods available on the Storefront
* Edit payment methods: update payment method details, assign payment methods to store, and/or (de)activate payment methods
***

To start managing payment methods, navigate to the **Administration > Payment Management > Payment Methods** section.
***

## Viewing Payment Methods

To view the payment method details, click **View** for the payment method in the *Actions* column. On the **View Payment Method: [Payment Method name]** page, you can see the following information:

* Payment method key
* Name of the payment method
* Payment provider
* Payment method status
* Availability of the payment method per store

See Payment Methods: Reference Information <!-- link --> for more details on the attributes you see on the page.
***

## Editing Payment Method Details

To edit a payment method:

1. On the **Payment Methods** page, click **Edit** in the *Actions* column for the payment method you want to update. This will redirect you to the **Edit Payment Method [Payment Method Name]** page containing two tabs: **Configuration** and **Store relation**.
2. In the **Configuration** tab, update the availability status of the payment method under **Is the Payment Method active?**:
   - Select the checkbox to make the payment method available in the *Payment* step during the checkout process
   - Clear the checkbox to make the payment method unavailable in the *Payment* step during the checkout process.

![Edit the payment method](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Back+Office+User+Guides/Administration/Payment+Management/Payment+Methods/Managing+Payment+Methods/edit-payment-method.png)

3. In the **Store relation** tab, select stores you want the payment method to be displayed in.
4. To apply the changes, click **Save**.

{% info_block warningBox "Note" %}

The payment method must be assigned to a store, otherwise, it won’t be displayed during the checkout process.

{% endinfo_block %}
