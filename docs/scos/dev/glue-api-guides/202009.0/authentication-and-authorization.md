---
title: Authentication and authorization
search: exclude
description: Information about Glue API authentication and authorization.
last_updated: Mar 18, 2021
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v6/docs/authentication-and-authorization
originalArticleId: c9e1faf1-8666-4607-93e4-2badbe3ed59e
redirect_from:
  - /v6/docs/authentication-and-authorization
  - /v6/docs/en/authentication-and-authorization
related:
  - title: Company Account and General Organizational Structure
    link: docs/scos/user/features/page.version/company-account-feature-overview/company-accounts-overview.html
  - title: Glue API - Customer Account Management feature integration
    link: docs/scos/dev/feature-integration-guides/page.version/glue-api/glue-api-customer-account-management-feature-integration.html
  - title: Searching by company users
    link: docs/scos/dev/glue-api-guides/page.version/managing-b2b-account/searching-by-company-users.html
---

[Protected resources](#protected-resources) in Spryker Glue API require user authentication. For the authentication, Spryker implements the [OAuth 2.0 mechanism](https://tools.ietf.org/html/rfc6749). On the REST API level, it is represented by the Login API.

To get access to a protected resource, a user obtains an *access token*. An access token is a JSON Web Token used to identify a user during API calls. Then, they pass the token in the request header.

![auth-scheme.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Glue+API/Glue+API+Storefront+Guides/Authentication+and+Authorization/auth-scheme+%281%29.png)

For security purposes, access tokens have a limited lifetime. When retrieiving an access token, the response body also contains the token's lifetime, in seconds. When the lifetime expires, the token can no longer be used for authentication.

There is also a *refresh token* in the response. When your access token expires, you can exchange the refresh token for a new access token.  The new access token also has a limited lifetime and a new refresh token.

The default lifetime of the access tokens is 8 hours (28800 seconds) and 1 month (2628000 seconds) of the refresh tokens.

For security purposes, when you finish sending requests as a user, or if a token gets compromised, we recommend revoking the refresh token. Revoked tokens are marked as expired on the date and time of the request and can no longer be exchanged for access tokens. 

Expired tokens are stored in the database, and you can configure them to be deleted. For details, see [Deleting expired refresh tokens](/docs/scos/dev/glue-api-guides/{{page.version}}/deleting-expired-refresh-tokens.html). 

## Protected resources

Below, you can find a list of the default protected resources. As Glue API is highly customizable, a shop is likely to have its own list of protected resources. To avoid extra calls, we recommend [retrieving protected resources](/docs/scos/dev/glue-api-guides/{{page.version}}/retrieving-protected-resources.html) of the shop before you start working with the API or setting up a flow. 

| Action | Method | Endpoints |
| --- | --- | --- |
| Customer - Retrieve a customer | GET | /customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %} |
| Customer - Update information | PATCH | /customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %} |
| Customer - Change password | PATCH | /customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %} |
| Customer - Delete | DELETE | /customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %} |
| Customer - Create a new address | POST | /customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %}/addresses |
| Customer - Update an existing address | PATCH | /customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %}/addresses/{% raw %}{{{% endraw %}customer_address_uuid{% raw %}}}{% endraw %} |
| Customer - Delete an address | DELETE | /customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %}/addresses/{% raw %}{{{% endraw %}customer_address_uuid{% raw %}}}{% endraw %} |
| Customer - Retrieve orders | GET | /orders |
| Customer - Retrieve an order | GET | /orders/{% raw %}{{{% endraw %}order_id{% raw %}}}{% endraw %} |
| Cart - Create a new cart | POST | /carts |
| Cart - Retrieve carts | GET | /carts
| Cart - Retrieve a cart | GET | /carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %}|
| Cart - Add an item to a cart | POST | /carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %}/items |
| Cart - Update item quantity | PATCH | /carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %}/items/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %} |
| Cart - Remove a cart | DELETE | /carts/{% raw %}{{{% endraw %}url{% raw %}}}{% endraw %}/carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %} |
| Cart - Remove items from a cart | DELETE | /carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %}/items/{% raw %}{{{% endraw %}concrete_id{% raw %}}}{% endraw %} |
| Wishlist - Add an item to a wishlist | POST | /wishlists/{% raw %}{{{% endraw %}wishlist_uuid{% raw %}}}{% endraw %}/wishlist-items |
| Wishlist - Create a wishlist | POST | /wishlists |
| Wishlist - Delete a wishlist | DELETE | /wishlists/{% raw %}{{{% endraw %}wishlist_uuid{% raw %}}}{% endraw %} |
| Wishlist - Delete an item from a wishlist | DELETE | /wishlists/{% raw %}{{{% endraw %}wishlist_id{% raw %}}}{% endraw %}/wishlist-items/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %} |
| Wishlist - Retrieve wishlists | GET | /wishlists |
| Wishlist - Retrieve a wishlist | GET | /wishlists/{% raw %}{{{% endraw %}wishlist_uuid{% raw %}}}{% endraw %} |
| Wishlist - Rename a wishlist | PATCH | /wishlists/{% raw %}{{{% endraw %}wishlist_uuid{% raw %}}}{% endraw %} |
| Agent - search by customers | GET | agent-customer-search |
| Agent - impersonate a customer | POST | /agent-customer-impersonation-access-tokens |




## Accessing protected resources

To access a protected resource, pass the access token in the `Authorization` header of your request. Example:

```
GET /carts HTTP/1.1
Host: mysprykershop.com:10001
Content-Type: application/json
Authorization: Bearer eyJ0...
Cache-Control: no-cache
```

If authorization is successful, the API performs the requested operation. If authorization fails, the `401 Unathorized` error is returned. The response contains an error code explaining the cause of the error. 

Response sample with an error:

```json
{
    "errors": [
        {
            "detail": "Invalid access token.",
            "status": 401,
            "code": "001"
        }
    ]
}
```


## User types

Different endpoints require the client to be authenticated as different users. By default, you can:
* [Authenticate as a customer](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-customers/authenticating-as-a-customer.html)
* [Authenticate as a company user](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html)
* [Authenticate as an agent assist](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-agent-assists/authenticating-as-an-agent-assist.html)


## Next steps

* [Retrieve protected resources](/docs/scos/dev/glue-api-guides/{{page.version}}/retrieving-protected-resources.html)






