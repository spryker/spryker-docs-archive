---
title: Agent Assist Feature Overview
description: An agent helps customers to perform activities in the online store and provides support by carrying out actions on customer's behalf in the web-shop
last_updated: Aug 13, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v4/docs/agent-assist-overview
originalArticleId: 5f642705-ceb2-4bea-bae7-b2058d47489d
redirect_from:
  - /v4/docs/agent-assist-overview
  - /v4/docs/en/agent-assist-overview
  - /v4/docs/agent-assist
  - /v4/docs/en/agent-assist
---

An **Agent** is a person with unrivaled product knowledge who can help customers to perform various activities in the Storefront. For example, a customer might call an Agent and ask him/her to help choose the right product or assist with the buying process or even perform some actions in the Storefront for them. Say, a customer wants to add items to a shopping list, or create a company, but cannot do it for some reason. This is when the Agent steps in and provides practical support acting on the customer's behalf in the online store.

## Setting up an Agent User

You can create an Agent user in the Back Office under _Users Control → User_.

In fact, any Administration Interface user can be an Agent. All you need to do for that is select the *This user is an Agent* checkbox on the *User create/edit page*, and the user gets the Agent mark. See [Adding New Users](/docs/scos/user/back-office-user-guides/{{page.version}}/users/managing-users/creating-users.html) to learn more about how to create a new Agent user in the Back Office.

![zed-agent-assist.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Agent+Assist/Agent+Assist+Feature+Overview/zed-agent-assist.png) 

## How Does it Work?
To act on a customer's behalf, the Agent signs in to the webshop via the `http://mysprykershop.com/agent/login` link with the Agent account details and selects the right customer by typing their name or email in the customer search field.

![customer-assitent.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Agent+Assist/Agent+Assist+Feature+Overview/customer-assitent.png) 

Once the necessary customer is found in the customer search field, the Agent clicks **Confirm**.

This virtually logs the Agent in to the webshop under the selected customer, so the assistant sees the webshop just the way the customer does, with all the wishlists, shopping lists, discounts, etc., and can do anything the customer asked for. If a customer's cart is stored in the database and not in the session, the Agent sees the cart and all its items as well.

Having performed the necessary actions requested by the customer, the Agent ends the customer assistance session by clicking **End Customer Assistance**.

<!-- ![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Agent+Assist/Agent+Assist+Feature+Overview/customer-session.png)  -->

<!-- Last review date: Sep 26, 2018-- by Andrii Sokirko -->
