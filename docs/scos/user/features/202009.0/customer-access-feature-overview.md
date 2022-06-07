---
title: Customer Access feature overview
search: exclude
description: The Customer Access feature allows deciding whether certain information is visible to logged out users or not
last_updated: May 11, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/v6/docs/customer-access-feature-overview
originalArticleId: c97c0a85-afe4-4d47-a64d-fdcf1e9bc5bc
redirect_from:
  - /v6/docs/customer-access-feature-overview
  - /v6/docs/en/customer-access-feature-overview
  - /v6/docs/customer-access
  - /v6/docs/en/customer-access
---

Customer Access allows Store Administrators to decide whether a certain information is visible to logged out users or not.

After enabling the feature in your project, Store Administrator can see a new submenu **Customer Access** under **Customer** menu. Using Customer Access submenu, Store Administrator can hide the following content types:

![content-types.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Hide+Content+from+Logged+out+Users/Hide+Content+from+Logged+out+Users+Overview/content-types.png)

* **price** 
A visitor will not see the price if they are not logged in:


**Settings in Admin UI (on the left)**
**Shop application (on the right)**

![price_not_shown_for_non_logged_in_user.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Hide+Content+from+Logged+out+Users/Hide+Content+from+Logged+out+Users+Overview/price_not_shown_for_non_logged_in_user.png)

* **order-place-submit**
Having clicked on the Checkout button, the visitor is taken to the login page.

* **add-to-cart**
To be able to add the item to the cart, a visitor needs to log in.

* **wishlist**
Add to wishlist button is not available for a logged out user.

* **shopping-list**
Add to shopping list button is not available for a logged out user.

These content types are predetermined, though, you can extend the configuration on a project level. By default, all content types are hidden for a logged out user.

{% info_block errorBox %}
An unauthorized user will not be able to proceed with the checkout even if Add to Cart button is available. The user will see the login page.
{% endinfo_block %}

<!-- _Last review date: Oct 26, 2018_ by Oleh Hladchenko, Oksana Karasyova -->
