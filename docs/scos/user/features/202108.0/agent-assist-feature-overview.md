---
title: Agent Assist feature overview
description: An agent helps customers to perform activities in the online store and provides support by carrying out actions on customer's behalf in the web-shop
last_updated: Jul 20, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/agent-assist-overview
originalArticleId: b5a82fe5-ecba-45ef-aa6b-1a7487fdf94c
redirect_from:
  - /2021080/docs/agent-assist-overview
  - /2021080/docs/en/agent-assist-overview
  - /docs/agent-assist-overview
  - /docs/en/agent-assist-overview
---

An *agent* is a person with unrivaled product knowledge who can help customers perform different activities in the Storefront. For example, a customer might call an agent and ask them to help choose the right product or assist with the buying process or even perform some actions in the Storefront on their behalf. Say, a customer wants to add items to a shopping list or create a company but cannot do it for some reason. This is when the agent steps in and provides practical support acting on the customer's behalf.



## Setting up an agent user

Every agent user is a Back Office user. When creating or editing a Back Office user, you can make them an agent assist by selecting this option.

A Back Office user can create an agent user in **Users** > **Users**.

To learn more about managing agent users in Back Office, see [Managing users](/docs/scos/user/back-office-user-guides/{{page.version}}/users/managing-users/creating-users.html)

![zed-agent-assist.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Agent+Assist/Agent+Assist+Feature+Overview/zed-agent-assist.png)

## Agent Assist feature on the Storefront

To act on a customer's behalf, the agent signs in at `https://mysprykershop.com/agent/login` with the agent account details and searches for the desired customer by typing their name or email in the customer search field.

![customer-assitent.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Agent+Assist/Agent+Assist+Feature+Overview/customer-assitent.png)

Once they find the desired customer, they select **Confirm** to impersonate them.

This logs the agent into the selected customer account, so they see the shop the way the customer does and can do anything the customer asks for. If a customer's cart is stored in the database, the agent can see and manage the cart and its items. If the cart is stored only in the customer's session, the agent can't manage it.

After performing all the requested actions, the agent ends the customer assistance session by selecting **End Customer Assistance**.

<!-- ![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Agent+Assist/Agent+Assist+Feature+Overview/customer-session.png) -->

This is how the Agent Assist feature works on the Spryker Demo Shop Storefront:
![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Agent+Assist/Agent+Assist+Feature+Overview/shop-guide-managing-agent-account.gif)


Check out this video tutorial on setting up an Agent user in a B2B company account:
<iframe src="https://spryker.wistia.com/medias/5zraqrascy" title="Agent Assist" allowtransparency="true" frameborder="0" scrolling="no" class="wistia_embed" name="wistia_embed" allowfullscreen="0" mozallowfullscreen="0" webkitallowfullscreen="0" oallowfullscreen="0" msallowfullscreen="0" width="720" height="480"></iframe>

## Related Business User articles

|BACK OFFICE USER GUIDES|
|---|
| [Create an agent user](/docs/scos/user/back-office-user-guides/{{page.version}}/users/managing-users/creating-users.html#creating-users) |

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Agent Assist feature walkthrough](/docs/scos/dev/feature-walkthroughs/{{page.version}}/agent-assist-feature-walkthrough.html) for developers.

{% endinfo_block %}
