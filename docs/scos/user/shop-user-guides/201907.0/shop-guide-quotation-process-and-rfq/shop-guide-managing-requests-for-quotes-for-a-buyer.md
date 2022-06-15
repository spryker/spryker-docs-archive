---
title: Shop Guide - Managing Requests for Quotes for a Buyer
search: exclude
description: The guide provides procedures on how to send a request for quote, negotiate the price, update or cancel an RFQ.
last_updated: Dec 23, 2019
template: howto-guide-template
originalLink: https://documentation.spryker.com/v3/docs/managing-rfqs-for-buyer-shop-guide
originalArticleId: 6eb7d49b-7cde-4884-b603-7dad443a51eb
redirect_from:
  - /v3/docs/managing-rfqs-for-buyer-shop-guide
  - /v3/docs/en/managing-rfqs-for-buyer-shop-guide
  - /docs/scos/user/shop-user-guides/page.version/quotation-process-and-rfq/shop-guide-managing-requests-for-quotes-for-a-buyer.html
  - /docs/scos/user/shop-user-guides/201907.0/quotation-process-and-rfq/shop-guide-managing-requests-for-quotes-for-a-buyer.html
  - /docs/scos/user/shop-user-guides/201907.0/quotation-proces-and-rfq/shop-guide-managing-requests-for-quotes-for-a-buyer.html
---

This topic describes the procedure for managing the Request for Quotes (RFQs) from the Buyer perspective:

* How to send an RFQ to a Sales Representative, accept the new prices or negotiate a better price than suggested.
* How to edit the RFQs and their items.
* How to cancel the RFQs.

You can do this all from the Quote Request page. You will be taken to this page when you:

* Initially create an RFQ from the Cart page. See [Creating an RFQ (Buyer)](/docs/scos/user/shop-user-guides/{{page.version}}/quotation-proces-and-rfq/shop-guide-creating-a-request-for-quote.html) for more information.
* Open a Quote Request which is in the *Draft* status in the **Customer Account → Quote Request**.

See [Reference Information](/docs/scos/user/shop-user-guides/{{page.version}}/quotation-proces-and-rfq/shop-guide-request-for-quote-reference-information.html) for details on components the Quote Request page consists of.
***
## Sending an RFQ to a Sales Representative

You can send the newly-created RFQs and the ones that are in *Draft* status to a Sales Representative for a review. To send an RFQ to a Sales Representative:

1. Open the **Quote Request** page.
2. Click **Send to Agent**.

Your Quote Request will be sent to the Sales Representative. You can check the RFQ's status in the **Customer Account -> Quote Request**.

See [Buyer Workflow](/docs/scos/user/shop-user-guides/{{page.version}}/quotation-proces-and-rfq/shop-guide-request-for-quote-reference-information.html) for more information on request statuses and workflow.
***
## Processing a Ready RFQ

Once a Sales Representative has prepared a price suggestion and sent it to you, your RFQ will acquire the Ready status on **Quote Request** page. You can either accept the suggestion by converting the request to cart, or you can request an even better price.

To convert an RFQ to cart, on the **Quote Request** page for the RFQ that is in the status Ready, click **Convert to Cart**.

From now on, you can continue to [Checkout](/docs/scos/user/shop-user-guides/{{page.version}}/shop-guide-checkout/shop-guide-checkout.html).

To request an even better price, you need to revise the RFQ.
***
## Revising an RFQ

You can revise an RFQ with the status *Ready*. To revise the RFQ:

1. On the **Quote Request** page, click **Revise**.
2. On the opened page, perform the necessary actions. See *Editing an RFQ* below for details on the possible actions.

{% info_block warningBox %}

RFQ version number changes upon each revision. Check [RFQ Versioning](/docs/scos/user/features/{{page.version}}/quotation-process-feature-overview.html#rfq-versioning) to learn about the version change process.

{% endinfo_block %}

***
## Editing an RFQ

You can edit the RFQs that are in a *Draft* status. To edit the RFQ:

1. Open the **Quote Request** page.
2. Click **Edit**.
3. Change **Purchase order number, Do not ship later than, Notes** fields, and/or [Edit the Items](/docs/scos/user/features/{{page.version}}/quotation-process-feature-overview.html#quotation-process-and-rfq-on-the-storefront) that are in the RFQ.
4. Click **Save**.

{% info_block warningBox %}

RFQ version number changes upon each revision. Check [RFQ Versioning](/docs/scos/user/features/{{page.version}}/quotation-process-feature-overview.html#rfq-versioning) to learn about the version change process.

{% endinfo_block %}

***
## Editing Items in an RFQ

You can edit the items (products) when you are editing an RFQ. To edit the items:

1. Start editing the existing RFQ.
2. On the **Edit RFQ** page, click **Edit Items**.
![Edit items](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/RFQ/Shop+Guide+-+Managing+Requests+for+Quotes+for+a+Buyer/edit-items.png)

You can change the item quantity, measurement units, remove the existing products from the RFQ or add the products from the catalog.
3. Click **Save and Back to Edit** after you have finished. The changes will be saved to an RFQ.
***
## Canceling an RFQ

An RFQ can be canceled in the statuses: *Draft*, *Waiting*, *Ready*.

To cancel the RFQ:

1. Open the **Quote Request** page.
2. Click **Cancel**.

The canceled RFQ will acquire the *Canceled* status. The canceled RFQ is not deleted, it is kept on the **Quote Request** page in the **Customer Account** with *Canceled* status.
