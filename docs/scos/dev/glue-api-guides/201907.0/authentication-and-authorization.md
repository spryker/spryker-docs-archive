---
title: Authentication and Authorization
search: exclude
last_updated: Nov 22, 2019
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v3/docs/authentication-and-authorization
originalArticleId: 427e5fc4-15ae-4802-aa3c-0daf75c47881
redirect_from:
  - /v3/docs/authentication-and-authorization
  - /v3/docs/en/authentication-and-authorization
---

Some resources (see the List of the private resources below) in Spryker REST API require user authentication. This process is essential to protect sensitive data and resources from unauthorized access. For this purpose, Spryker implements the OAuth 2.0 mechanism for user authentication. On the REST API level, it is represented by the **Login API**.

To get access to a protected resource, first, you need to obtain an **Access Token**. We use JWT tokens required for Spryker Glue to identify a user during API calls. Then you need to pass the token in the request header to get access to the resources that require authentication.

![auth-scheme.png](https://cdn.document360.io/9fafa0d5-d76f-40c5-8b02-ab9515d3e879/Images/Documentation/auth-scheme%281%29.png)

For increased security, access tokens have a limited lifetime. When receiving an access token, the response body contains not only the access token itself, but also its lifetime, in seconds, and a **Refresh Token**. When the lifetime expires, the Refresh Token can be exchanged for a new Access Token. The new token will also have a limited lifetime and have a corresponding Refresh Token for future authentication. The default lifetime of the tokens is 8 hours (28800 seconds) for an access token and 1 month (2628000 seconds) for a refresh token, although the settings can be changed in the module configuration.

## List of private resources

| Action | Method | Endpoints |
| --- | --- | --- |
| Customer - Get a Customer | GET | http://mysprykershop.com/customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %} |
| Customer - Update info | PATCH | http://mysprykershop.com/customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %} |
| Customer - Change password | PATCH | http://mysprykershop.com/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %} |
| Customer - Delete | DELETE | http://mysprykershop.com/customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %} |
| Customer - Create a new address | POST | http://mysprykershop.com/customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %}/addresses |
| Customer - Update existing address | PATCH | http://mysprykershop.com/customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %}/addresses/{% raw %}{{{% endraw %}customer_address_uuid{% raw %}}}{% endraw %} |
| Customer - Delete the address | DELETE | http://mysprykershop.com/customers/{% raw %}{{{% endraw %}customer_reference{% raw %}}}{% endraw %}/addresses/{% raw %}{{{% endraw %}customer_address_uuid{% raw %}}}{% endraw %} |
| Customer - Get List of Order | GET | http://mysprykershop.com/orders |
| Customer - Ger Order details | GET | http://mysprykershop.com/orders/{% raw %}{{{% endraw %}order_id{% raw %}}}{% endraw %} |
| Cart - Create the new cart | POST | http://mysprykershop.com/carts |
| Cart - Retrieve the cart | GET | http://mysprykershop.com/carts<br>http://mysprykershop.com/carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %}<br>Cart - Add an item to the cart | POST | http://mysprykershop.com/carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %}/items |
| Cart - Update item quantity | PATCH | http://mysprykershop.com/carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %}/items/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %} |
| Cart - Remove the cart | DELETE | http://mysprykershop.com/carts/{% raw %}{{{% endraw %}url{% raw %}}}{% endraw %}/carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %} |
| Cart - Remove items from a cart | DELETE | http://mysprykershop.com/carts/{% raw %}{{{% endraw %}cart_uuid{% raw %}}}{% endraw %}/items/{% raw %}{{{% endraw %}concrete_id{% raw %}}}{% endraw %} |
| Wishlist - Add an item to wishlist | POST | http://mysprykershop.com/wishlists/{% raw %}{{{% endraw %}wishlist_uuid{% raw %}}}{% endraw %}/wishlist-items |
| Wishlist - Create the wishlist | POST | http://mysprykershop.com/wishlists |
| Wishlist - Delete a wishlist | DELETE | http://mysprykershop.com/wishlists/{% raw %}{{{% endraw %}wishlist_uuid{% raw %}}}{% endraw %} |
| Wishlist - Delete an item into a wishlist | DELETE | http://mysprykershop.com/wishlists/{% raw %}{{{% endraw %}wishlist_id{% raw %}}}{% endraw %}/wishlist-items/{% raw %}{{{% endraw %}concrete_sku{% raw %}}}{% endraw %} |
| Wishlist - Get list of wishlist | GET | http://mysprykershop.com/wishlists |
| Wishlist - Get wishlist by ID | GET | http://mysprykershop.com/wishlists/{% raw %}{{{% endraw %}wishlist_uuid{% raw %}}}{% endraw %} |
| Wishlist - Rename a wishlist | PATCH | http://mysprykershop.com/wishlists/{% raw %}{{{% endraw %}wishlist_uuid{% raw %}}}{% endraw %} |

## Installation
For instructions on how to install the necessary modules and enable OAuth authentication, see [Login API]().

## User Authentication
To authenticate a user and receive an access token, send a POST request to the following endpoint:
`/access-tokens`
Request sample: `POST http://mysprykershop.com/access-tokens`

**Attributes:**

* username - specifies the username of the user to authenticate;
* password - specifies the user's password.

{% info_block errorBox "Security Considerations " %}
As passwords are sent to this endpoint unencrypted, it is strongly recommended to provide access to it only via the HTTPS protocol.
{% endinfo_block %}

**Sample Request:**
```js
{
  "data": {
    "type": "access-tokens",
    "attributes": {
      "username": "john.doe@example.com",
      "password": "qwerty"
    }
  }
}
```

**Sample Response:**
```js
{
    "data": {
        "type": "access-tokens",
        "id": null,
        "attributes": {
            "tokenType": "Bearer",
            "expiresIn": 3600,
            "accessToken": "eyJ0...",
            "refreshToken": "def5..."
            "idCompanyUser": null
        },
        "links": {
            "self": "http://mysprykershop.com/access-tokens"
        }
    }
}
```

In the above example, the _access_ token contained in the **accessToken** attribute will expire in **3600** seconds. After it expires, a new access token can be received using the data contained in the **refreshToken** attribute.

## Accessing Resources
To access protected resources, you need to pass the access token in the **Authorization** header of your request. Example:

```
GET /carts HTTP/1.1
Host: mysprykershop.com:10001
Content-Type: application/json
Authorization: Bearer eyJ0...
Cache-Control: no-cache
```

If authorization is successful, the API will perform the requested operation. If authorization fails, a **401 Unathorized** error will be returned. The response will contain an error code explaining the cause of the error. It is, therefore, your responsibility to handle 401 errors when accessing protected resources. Sample error response:

```js
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

All protected resources can return the following generic errors:
| Code | Reason |
| --- | --- |
| 001 | Invalid access token |
| 002 | Access token missing or forbidden resource for the given user scope |
| 003 | Failed to log in the user |
| 004 | Failed to refresh a token |

## Refreshing Tokens
To refresh an access token, send a request to the following endpoint and pass the corresponding refresh token:
`/refresh-tokens`
Request sample: `POST http://mysprykershop.com/refresh-tokens`

Attributes:

* refreshToken - specifies the Refresh Token received during initial authentication.

Sample Request:
```js
{
  "data": {
    "type": "refresh-tokens",
    "attributes": {
      "refreshToken": "def5..."
    }
  }
}
```

**Sample Response:**
```js
{
    "data": {
        "type": "refresh-tokens",
        "id": null,
        "attributes": {
            "tokenType": "Bearer",
            "expiresIn": 28800,
            "accessToken": "eyJ0...",
            "refreshToken": "def5..."
        },
        "links": {
            "self": "http://mysprykershop.com/refresh-tokens"
        }
    }
}
```

**See Also:**
* B2B Authentication and Authorization

_Last review date: Jan 17, 2019_ <!-- by Dmitry Beirak -->
