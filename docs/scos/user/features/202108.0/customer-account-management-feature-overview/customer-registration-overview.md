---
title: Customer Registration overview
last_updated: Jul 15, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/customer-registration-overview
originalArticleId: b13eea5d-0524-4858-a94a-c993b12606ea
redirect_from:
  - /2021080/docs/customer-registration-overview
  - /2021080/docs/en/customer-registration-overview
  - /docs/customer-registration-overview
  - /docs/en/customer-registration-overview
---

In Spryker, customers registration are done via double opt-in. A double opt-in occurs when a user signs up, and an email with a registration confirmation link is sent to them. After they click the verification link, their account is activated and they can start using the online store as a registered customers.

{% info_block infoBox "Email verification" %}

There are multiple ways to register a customer. Regardless of a how a customer is registered, they always must verify their email address.

{% endinfo_block %}

## Registration flows
There are four customer registration options:

* Regular registration
* Checkout registration
* Registration by creating an account in the Back Office
* Registration via Glue API
* Registration via import

### Regular registration

The *regular registration*  is the registration triggered from the registration page of *My Account* page on the Storefront. It is a two-step process:

1. A customer fills out the registration form and selects **Sign Up**. A message about the email verification is displayed.  

2. The customer selects the verification link in the email and gets redirected to the login page where the message about successful account activation is diplayed.

### Checkout registration

*Checkout registration* is the registration triggered from the login checkout step. A customer puts products to cart as a guest user and proceeds to checkout. At the login checkout step, they choose to sign up. Then, they follow the [regular registration](#regular-registration).


After checkout registration, the cart created by a customer as a guest user is converted into a registered user's cart and appears in the customer's list of carts.

### Registration by creating an account in the Back Office


A Back Office user can register a customer by entering customer account details. The verification email is sent to the email address specified by the Back Office user. Until the customer verifies their account via the link in the email, in the Back Office, the status of their account is *Unverified*. Once they click the link, the status changes to *Verified*.

To learn how a Back Office user creates customer accounts, see [Creating customers](/docs/scos/user/back-office-user-guides/{{page.version}}/customer/customer-customer-access-customer-groups/managing-customers.html#creating-customers).

### Registration via Glue API

A developer can register a customer by passing their customer account details via Glue API. The verification email is sent to the email address passed in the registration request. The customer activates the account by verifying their email address. Alternatively, a developer can verify the customer's email address via Glue API.

{% info_block infoBox "Verifying a customer's email address via Glue API" %}

A developer can verify a customer's email address via Glue API regardless of the way the account was created.

{% endinfo_block %}

To learn how a developer creates customer accounts via Glue API, see [Create a customer](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-customers/managing-customers.html#create-a-customer).

To learn how a developer confirms a customer's email address, see [Confirming customer registration](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-customers/confirming-customer-registration.html).

### Registration via import

A developer can register a customer by importing their customer account details. The verification email is snet to the email address specified in the import file. The customer activates the account by verifying their email address.

## Related Business User articles

|BACK OFFICE USER GUIDES|
|---|
| [Create customers](/docs/scos/user/back-office-user-guides/{{page.version}}/customer/customer-customer-access-customer-groups/managing-customers.html#creating-customers)  |

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Customer Account Management feature walkthrough](/docs/scos/dev/feature-walkthroughs/{{page.version}}/customer-account-management-feature-walkthrough/customer-account-management-feature-walkthrough.html) for developers.

{% endinfo_block %}
