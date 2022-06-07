---
title: Customer Account Management feature overview
search: exclude
description: Let your customers create an Account to save their contact details, addresses, order history and preferences, such as language and shipping options.
last_updated: Mar 16, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v4/docs/customer-accounts
originalArticleId: 55e5df4c-4a6d-42c4-b684-e109aa65fdfc
redirect_from:
  - /v4/docs/customer-accounts
  - /v4/docs/en/customer-accounts
  - /v4/docs/crm
  - /v4/docs/en/crm
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
| Overview | ✓ | ✓|
| Profile | ✓ | ✓ |
| Addresses | ✓ | ✓ |
| Order History | ✓ | ✓ |
| Newsletter | ✓ | ✓ |
| Shopping Lists | ✓ |  |
| Shopping Carts | ✓ |  |
| Wishlist |  | ✓ |

As a Back Office user, you can view and edit your customer's account details and check their orders and order history. For internal references, each customer account can be enhanced with notes. This will allow an easier customer management
in your organization.

{% info_block infoBox %}
The customer accounts can be managed by customers directly on the Yves side. If updates are done by a customer, the data is synchronized and shop administrator will see the relevant information in the **Back Office > Customers > Customers** section. The exceptions are newsletter subscription and password change, as this information is not stored in Zed.
{% endinfo_block %}
