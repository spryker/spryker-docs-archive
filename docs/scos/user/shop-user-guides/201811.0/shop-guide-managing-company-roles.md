---
title: Shop Guide - Managing Company Roles
description: The guide provides procedures to create, edit or view company roles in the storefront.
last_updated: May 19, 2020
template: howto-guide-template
originalLink: https://documentation.spryker.com/v1/docs/company-roles-shop-guide
originalArticleId: 525f5d80-a843-425f-a8de-90950d9217ec
redirect_from:
  - /v1/docs/company-roles-shop-guide
  - /v1/docs/en/company-roles-shop-guide
  - /docs/scos/user/shop-user-guides/page.version/shop-guide-company-roles.html
---

Roles page allows your shop owner to manage the roles for your company.

To open the Company Roles page, go to the header of the shop application → Name of your company → Roles.

![Roles header](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Company+Roles/roles-header.png)

## Graphic User Interface

![Roles GUI](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Company+Roles/roles-gui.png)

The *Company Roles* page consists of the following elements:

| # | Element | Description |
|---|---|---|
|  **1** |  **Company Account menu** | Use this menu to manage your Company: Overview, Users, Business Units, Roles. |
|  **2** |  **Name** | Name of the role. |
|  **3** |  **Is Default** | Check mark that specifies whether the role is set the default for the newly created users. |
|  **4** |  **Actions** | Click a respective button to either **Edit**![Edit icon](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Company+Roles/edit-icon.png) or **Delete**![Delete icon](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Company+Roles/delete-icon.png) a company role. |
|  **5** |  **+ Add New Role** | This button creates a new company role. See *Creating a New Role* for more details. |

## Creating a New Company Role

**To create a new company role**, do the following:

1. On the **Company Roles** page, click **+Create New Role**.
2. Enter the name of the role.
![Create a role](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Company+Roles/create-role.png)

{% info_block infoBox %}
Selecting the **Is Default** check-box means that the new users will be created with this role assigned by default.
{% endinfo_block %}

3.Click **Submit**.

## Editing an Existing Company Role

You can edit the existing role settings by completing the steps below:

1. On the **Company Roles** page, click![Edit icon](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Company+Roles/edit-icon.png) next to the company user you would like to edit.
2. Update the necessary settings.

![Edit a role](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Company+Roles/edit-role.png)

A role includes a set of permissions that can be enabled/disabled according to your needs by switching the toggle in Enable column.
  - **Add company users** - allows adding company users. With this permission enabled, a user will have Create User button on the Company Users page.
  - **Invite users** - allows inviting company users. With this permission enabled, a user will have Invite Users button on the Company Users page.
  - **Enable / Disable company users** - allows enabling and disabling company users. With this permission enabled, a user will be able to switch a toggle in the Enable column on the Company Users page.
  - **See Company Menu** - allows access to the company menu. With this permission enabled, a user will be able to navigate to a company menu from the header of the shop interface.
  - **Add item to cart** - allows adding products to cart. Without this permission, the user will get This action is forbidden error when trying to add the product in the cart.
  - **Change item in cart** - allows changing products in the cart (changing the quantity, adding notes etc).
  - **Remove item from cart** - allows deleting the products from the cart.
  - **Place Order** - allows placing the order. With this permission enabled, a user will have  error when trying to submit the order.
  - **Alter Cart Up to Amount** - allows changing the content of the cart (adding new products, changing the quantity of the existing products etc.) until it hits the limit specified in this permission. When the limit is reached, the buyer will not be able to change the contents of the cart and will get *This action is forbidden* error.
  - **Buy up to grand total (Requires "Send cart for approval")** - sets a limit for the grand total of the cart. If the amount in the cart is bigger than the limit set in this permission, the user will not be able to proceed to checkout. Works with Send cart for approval permission. This permission is available after enabling the [Approval Process](/docs/scos/user/features/{{page.version}}/approval-process-feature-overview.html) feature.
  - **Approve up to grand total** - with this permission enabled, a user can approve the the cart. See [Approval Feature ](/docs/scos/user/features/{{page.version}}/approval-process-feature-overview.html) for more details.
  - **Send cart for approval (Requires "Buy up to grand total")** - allows a user to send the cart for approval. Works together with Buy up to grand total permission. See [Approval Feature Overview](/docs/scos/user/features/{{page.version}}/company-account-feature-overview/company-user-roles-and-permissions-overview.html) for more details.
3. Click **Submit**.

## Deleting a Company Role

You can delete a company user by clicking ![Delete icon](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Company+Roles/delete-icon.png) icon next to the company user you are going to delete. Confirm the removal by clicking **Delete**.

![Delete a role](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Shop+User+Guides/Company+Roles/delete-role.png)

Don't forget to check out the video tutorial on setting up the [Company Roles](/docs/scos/user/features/{{page.version}}/company-account-feature-overview/company-user-roles-and-permissions-overview.html) in Spryker [B2B Demo Shop](/docs/scos/user/intro-to-spryker/b2b-suite.html):

{% wistia 72qy3slwjo 960 720 %}
