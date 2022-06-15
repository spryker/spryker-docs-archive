---
title: Customer Account Management feature overview
search: exclude
description: Let your customers create an Account to save their contact details, addresses, order history and preferences, such as language and shipping options.
last_updated: Oct 28, 2019
template: concept-topic-template
originalLink: https://documentation.spryker.com/v1/docs/customer-accounts
originalArticleId: aa31b439-134a-4f99-87c7-3b225249aac0
redirect_from:
  - /v1/docs/customer-accounts
  - /v1/docs/en/customer-accounts
  - /v1/docs/crm
  - /v1/docs/en/crm
---

Let your customers create an Account to save their personal details.

Customer accounts can have the following set of details:

* contact details
* addresses
* order history
*  preferences, such as language and shipping options.

There are slight differences in customer accounts' information for the B2B and B2C shops. The following table describes such differences and similarities:

| Customer Account Sections | B2B Shop | B2C Shop |
| --- | --- | --- |
| Overview | v | v|
| Profile | v | v |
| Addresses | v | v |
| Order History | v | v |
| Newsletter | v | v |
| Shopping Lists | v |  |
| Shopping Carts | v |  |
| Wishlist |  | v |

As a Back Office user, you can view and edit your customer's account details and check their orders and order history.

{% info_block infoBox %}
The customer accounts can be managed by customers directly on the Yves side. If updates are done by a customer, the data is synchronized and shop administrator will see the relevant information in the **Back Office > Customers > Customers** section. The exceptions are newsletter subscription and password change, as this information is not stored in Zed.
{% endinfo_block %}
