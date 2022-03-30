---
title: Custom Order Reference overview
last_updated: Jun 16, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/custom-order-reference-overview
originalArticleId: f2b2d82f-8854-446d-b8e9-63df552a5038
redirect_from:
  - /2021080/docs/custom-order-reference-overview
  - /2021080/docs/en/custom-order-reference-overview
  - /docs/custom-order-reference-overview
  - /docs/en/custom-order-reference-overview
---

*Custom Order Reference* helps you to control purchases and link the internal orders to external systems from your company using your external order reference. With the feature in place, you can add a custom order reference, such as an invoice, to the order on Yves.

{% info_block infoBox "Info" %}

Keep in mind that the custom order references are available only for logged-in users.

{% endinfo_block %}


In the Storefront, you, as a buyer, can add a custom order reference to the order or edit it (if needed) on the *Cart* page and then view it on the *Summary* page. Once the order has been placed, the reference becomes non-editable and is displayed on the *Order Details* page in your customer account.

<details open>
<summary markdown='span'>Cart page</summary>

![add-custom-order-reference](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Order+Management/Custom+Order+Reference/add-custom-order-reference.gif)

</details>

<details open>
<summary markdown='span'>Summary page</summary>

![custom-order-reference-summary-page](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Order+Management/Custom+Order+Reference/custom-order-reference-summary-page.png)

</details>

<details open>

<summary markdown='span'>Order Details page </summary>

![custom-order-reference-order-details-page](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Order+Management/Custom+Order+Reference/custom-order-reference-order-details-page.gif)

</details>

When working with the order in the Back Office, you, as a Back Office user, can view, edit, or remove the custom order reference on the order details page.

![zed-custom-order-ref-new](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Order+Management/Custom+Order+Reference/zed-change-custom-order-reference.gif)

## Custom Order Reference with the RFQ, approval process, and share cart via a link
If you submit a [quote request](/docs/scos/user/features/{{page.version}}/quotation-process-feature-overview.html) and then convert it to the shopping cart, the cart gets locked. However, adding and updating the customer order reference for the locked cart is still possible.

In the [Approval Process](/docs/scos/user/features/{{page.version}}/approval-process-feature-overview.html) scenarios, both an approver and buyer can add or edit the custom order reference during the checkout.

When [sharing a cart via a link with external users](/docs/scos/user/features/{{page.version}}/persistent-cart-sharing-feature-overview.html), they can only view the custom order reference. However, when [sharing a cart via a link with internal users](/docs/scos/user/features/{{page.version}}/persistent-cart-sharing-feature-overview.html), they can update the custom order reference for the shopping cart with the read-only and full-access permissions.


## Current constraints

If you added a custom order reference to the cart, submitted a request for quote, and then converted the RFQ to the cart, the custom order reference will be removed. Thus, you will need to add the reference once the RFQ has been converted to the cart.

## Related Business User articles

|BACK OFFICE USER GUIDES|
|---|
| [Adding and removing custom order references](/docs/scos/user/back-office-user-guides/{{page.version}}/sales/orders/adding-and-removing-custom-order-references.html) |

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Order Management feature walkthrough](/docs/scos/dev/feature-walkthroughs/{{page.version}}/order-management-feature-walkthrough/order-management-feature-wakthrough.html) for developers.

{% endinfo_block %}
