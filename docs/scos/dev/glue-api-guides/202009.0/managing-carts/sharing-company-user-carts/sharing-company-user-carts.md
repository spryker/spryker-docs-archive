---
title: Sharing company user carts
description: Share company user carts via Glue API.
last_updated: Feb 10, 2021
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v6/docs/sharing-company-user-carts
originalArticleId: 94d4010a-b373-4954-9bb2-728d9d90bd33
redirect_from:
  - /v6/docs/sharing-company-user-carts
  - /v6/docs/en/sharing-company-user-carts
---

Company users can share their carts with other company users, so multiple representatives of a company can work on the same order. When sharing carts, users can choose what type of access they want to grant to different each other.

This endpoint allows sharing carts with company users.

## Installation
For detailed information on the modules that provide the API functionality and related installation instructions, see [Shared Carts feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/shared-carts-feature-integration.html).


## Share a cart
To share a cart, send the request:

***
`POST` **/carts/*{% raw %}{{{% endraw %}cart-uuid{% raw %}}}{% endraw %}*/shared-carts**
***


| Path parameter | Description |
| --- | --- |
| ***{% raw %}{{{% endraw %}cart-uuid{% raw %}}}{% endraw %}*** | Unique identifier of a cart to share. |

### Request

| Header key | Type | Required | Description |
| --- | --- | --- | --- |
| Authorization | string | ✓ | String containing digits, letters, and symbols that authorize the company user. [Authenticate as a company user](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html#authenticate-as-a-company-user) to get the value.  |

Request sample: `POST http://glue.mysprykershop.com/carts/f23f5cfa-7fde-5706-aefb-ac6c6bbadeab/shared-carts`
    
```json
{
    "data": {
        "type": "shared-carts",
        "attributes": {
            "idCompanyUser": "4c677a6b-2f65-5645-9bf8-0ef3532bead1",
            "idCartPermissionGroup": 1
        }
    }
}
```

| Attribute | Type | Required | Description |
| --- | --- | --- | --- |
| idCompanyUser | String | ✓ | Unique identifier of a company user to share the cart with.<br>The user must belong to the same company as the cart owner. |
| idCartPermissionGroup | Integer | ✓ | Unique identifier of a cart permission group that defines the permissions of the company user for the cart. To get the full list of cart permission groups, [retrieve permission groups](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-carts/sharing-company-user-carts/retrieving-cart-permission-groups.html#retrieve-cart-permission-groups). |

### Response



Response sample:
    
```json
{
    "data": {
        "type": "shared-carts",
        "id": "4c677a6b-2f65-5645-9bf8-0ef3532bbbccaa",
        "attributes": {
            "idCompanyUser": "4c677a6b-2f65-5645-9bf8-0ef3532bead1",
            "idCartPermissionGroup": 1
        },
        "links": {
            "self": "http://glue.mysprykershop.com/shared-carts/4c677a6b-2f65-5645-9bf8-0ef3532bbbccaa"
        }
    }
}
```

| Attribute | Type | Description |
| --- | --- | --- |
| id | String | Unique identifier used for sharing the cart. |
| idCompanyUser | String | Unique identifier of the company user the cart is shared with. |
| idCartPermissionGroup | Integer | Unique identifier of the cart permission group that describes the permissions granted to the user the cart is shared with. |


## Possible errors

| Status | Reason |
| --- | --- |
| 401 | The access token is invalid. |
| 403 | The access token is missing. |
| 404 | Cart not found. |
| 422 | Failed to share a cart. |

## Next steps

* [Manage shared company user carts](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-carts/sharing-company-user-carts/managing-shared-company-user-carts.html)

