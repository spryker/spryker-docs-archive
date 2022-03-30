---
title: Customer Login by Token overview
description: With the feature in place, B2B customers can log in to Spryker shop using a token.  In the article, you can find a description of the token structure.
last_updated: Aug 2, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/customer-login-by-token-overview
originalArticleId: 0bcb6d05-e12f-4cee-8daf-553edff0a43d
redirect_from:
  - /2021080/docs/customer-login-by-token-overview
  - /2021080/docs/en/customer-login-by-token-overview
  - /docs/customer-login-by-token-overview
  - /docs/en/customer-login-by-token-overview
---

*Customer Login* by Token feature allows B2B users to log in to Spryker Shop using a token.

Most modern e-commerce applications allow customers to log in by token or, in other words, they support token-based authentication. They do so for several good reasons:

* Tokens are stateless: They are stored on the client side and already contain all the information they need for authentication. No session information on the server is great for scaling your application.

* Tokens are secure: Tokens (not cookies) are sent on every request, which helps to prevent attacks. Since the session is not stored, there is no session-based information that could be manipulated.

* Extensibility and access control: In the token payload, you can specify user roles, permissions as well as resources that the user can access. Besides, you can share some permissions with other applications.

For technical details see [Customer Login by Token reference information](/docs/scos/dev/feature-walkthroughs/{{page.version}}/company-account-feature-walkthrough/customer-login-by-token-reference-information.html)

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Company Account feature walkthrough](/docs/scos/dev/feature-walkthroughs/{{page.version}}/company-account-feature-walkthrough/company-account-feature-walkthrough.html) for developers.

{% endinfo_block %}
