---
title: Company User Roles and Permissions overview
description: Usually employees within a company have different roles (purchasing, administration, supervision, etc.). These roles are referred to as Company Roles.
last_updated: Nov 22, 2019
template: concept-topic-template
originalLink: https://documentation.spryker.com/v3/docs/company-roles-permissions-overview
originalArticleId: f57cc580-5067-4125-80bf-6db17101c874
redirect_from:
  - /v3/docs/company-roles-permissions-overview
  - /v3/docs/en/company-roles-permissions-overview
  - /v3/docs/company-user-roles-and-permissions-overview
  - /v3/docs/en/company-user-roles-and-permissions-overview
---

Usually employees within a company have different roles (e.g. purchasing, administration, supervision, etc.). These roles are related to Company Users and are referred to as **Company Roles**. A role can be default (“is_default” flag), which means that it is used for all new users automatically.

Upon initial creation of the first Company User, the default role is Admin. After the Admin user has been created, he/she creates the structure of the company and can define the default role to be used further on.

![roles.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Company+User+Permissions/Company+Roles+and+Permissions+Feature+Overview/roles.png) 

## Permissions
Each Company role contains a set of permissions in the form of **Permission** keys attributed to them.

The Permission keys define what the users are allowed to do.

{% info_block infoBox %}
For example, a user can be allowed to add products to cart.
{% endinfo_block %}
Permissions that can be used are not limited in any way - you can create and integrate any permissions. Each of the permissions is represented as a plugin in the code.

Here is another example of the connection between company roles and permissions:

* When a user registers a Company in the system, he/she actually creates a request for Company account registration.
* After the Company account has been approved, this first Company User becomes the Company administrator.
* Therefore, one of the roles within the Company will be Administrator who will have all the permissions with regard to creation and management of company profile, user accounts and user rights.

One and the same user can have several Company Roles assigned to them. It means that the same user can be Junior Sales Manager and Team Leader, which in its turn implies that this user has permissions assigned to both roles: Junior Sales Manager and Team Leader. Here it should be noted that the permissions, entitling the user with more rights, win.

{% info_block infoBox %}
For example, suppose Junior Sales Managers are allowed to place an order for up to 1000 Euro, whereas Team Leaders can place orders for up to 2000 Euro. If a user has both roles assigned to him, he/she will be allowed to place orders for up to 2000 Euro, and not 1000 Euro.<br>Or, for example, if Junior Sales Managers are not allowed to view specific products, but Team Leaders can, the users having both Junior Sales Manager and Team Leader roles will be allowed to view those products.
{% endinfo_block %}

![roles-permissions.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Company+User+Permissions/Company+Roles+and+Permissions+Feature+Overview/roles-permissions.png) 

Company roles and permissions and their relation to the organizational structure can be schematically represented as follows:

![roles_structure.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Company+User+Permissions/Company+Roles+and+Permissions+Feature+Overview/roles_structure.png) 

## Permission Types
Permissions can be simple and complex.
<table>
	<th>Permission Type</th>
	<th>Description</th>
	<th>Example</th>
	<tr>
        <td><b>Simple</b></td>
		<td>	Simple permissions are those that do not have any logic behind them and answer the question “Does the customer have a permission?”. Simple permissions implement only PermissionPluginInterface (Shared).</td>
		<td>
            <p>A Company User is allowed (or not allowed) to access product details page.</p>
            

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Company+User+Permissions/Company+Roles+and+Permissions+Feature+Overview/simple_permissions.png) 


</td>
	</tr>
	<tr>
        <td><b>Complex</b></td>
		<td>Complex permissions have some logic behind them and answer the question “Does the customer have a permission with some parameters and business logic?”. Complex permissions implement ExecutablePermissionPluginInterface (Shared).</td>
		<td>
           <p> A Company User is allowed (or not allowed) to place an order with grand total over 1000 Euro.</p>
       
![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Company+User+Permissions/Company+Roles+and+Permissions+Feature+Overview/complex_permissions.png)
        </td>
	</tr>
    <tr>
        <td><b>Infrastructural</b></td>
		<td>Some permissions should not be managed in the UI, but programatically. Infrastructural permissions implement InfrastructuralPermissionPluginInterface (Shared).</td>
		<td>
           <p> Read shared cart, which is managed by the Shared Carts feature.</p>
       </td>
	</tr>
</table>

{% info_block infoBox %}
Some of the Permissions can be configured for specific roles, for example, “allow adding no more than X items to cart” for junior support engineer.<br>Or for example, some specific products are not allowed to be viewed by anyone, but Admin and Top Managers.<br>These values are referred to as **Company Role Permissions**.
{% endinfo_block %}

Permission can also be **Yves-side** and **Zed-side**.

* **Yves permissions** do not need to get any data from the database. They refer to key-value storage, or to search to check the right for actions.
{% info_block infoBox %}
For example, the permission to view a product, a page, or permission to place an order, permission to place an order with grand total less X, would be Yves-side permissions.
{% endinfo_block %}

* Permissions that require some data from the database or some additional business-logic on top to check the rights for actions, are referred to as **Zed permissions**.

{% info_block infoBox %}
For example, the permission to add to cart up to X [order value] would be the Zed-side permission. In this case the process of permissions check would be as follows:<ul><li>After the user clicked **Add to cart**, the request comes to Zed and the pre-checks are made following the “add to cart” request.</li><li>After that, the calculations are run. The calculations apply discounts per item, and then per cart (total).<br>The logic behind this is simple: a user might have a discount for a specific item, and a discount for order starting from a specific order value. The order value would be calculated taken the discount per items into account, and therefore the discount per cart would be applied after all discounts per items have been calculated.</li><li>After the calculations have been made, the cart is saved.</li></ul>
{% endinfo_block %}

Obviously, the permissions can not be checked at the step when user just clicks **Add to cart**, because actual order value has not been calculated yet (pre-checks have not been made yet, discounts have not been calculated). Also, the permissions check request can not be started after the cart has been updated - that would be too late, as, the cart has already been persisted. The request for rights check is made somewhere in between - specifically, right after the discounts have been calculated. That is why the so-called “termination hooks” have been implemented deep in logic, where the permissions checks are made.

The termination hooks (plugin stack) do not allow the permissions sneak into the business logic foundation so it will remain clean from the permissions and not overwhelmed with “can” “if not; then…” etc.

![termination_hooks.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Company+Account+Management/Company+User+Permissions/Company+Roles+and+Permissions+Feature+Overview/termination_hooks.png) 

The termination hooks are performed one by one, and process termination can happen for any reason, and one of them would be the permissions.

<!-- Last review date: Feb 8, 2019- by Denis Turkov, Helen Kravchenko -->
