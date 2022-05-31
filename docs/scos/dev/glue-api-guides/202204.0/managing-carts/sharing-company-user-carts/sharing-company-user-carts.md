---
title: Sharing company user carts
description: Share company user carts via Glue API.
last_updated: Jun 16, 2021
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/sharing-company-user-carts
originalArticleId: a200e568-906d-4ae4-b50a-8ad5433d4399
redirect_from:
  - /2021080/docs/sharing-company-user-carts
  - /2021080/docs/en/sharing-company-user-carts
  - /docs/sharing-company-user-carts
  - /docs/en/sharing-company-user-carts
  - /docs/scos/dev/glue-api-guides/201811.0/managing-carts/sharing-company-user-carts/sharing-company-user-carts.html
  - /docs/scos/dev/glue-api-guides/201903.0/managing-carts/sharing-company-user-carts/sharing-company-user-carts.html
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


| PATH PARAMETER | DESCRIPTION |
| --- | --- |
| ***{% raw %}{{{% endraw %}cart-uuid{% raw %}}}{% endraw %}*** | Unique identifier of a cart to share. |

### Request

| HEADER KEY | TYPE | REQUIRED | DESCRIPTION |
| --- | --- | --- | --- |
| Authorization | string | ✓ | String containing digits, letters, and symbols that authorize the company user. [Authenticate as a company user](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html#authenticate-as-a-company-user) to get the value.  |

Request sample: `POST https://glue.mysprykershop.com/carts/f23f5cfa-7fde-5706-aefb-ac6c6bbadeab/shared-carts`

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

| ATTRIBUTE | TYPE | REQUIRED | DESCRIPTION |
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
            "self": "https://glue.mysprykershop.com/shared-carts/4c677a6b-2f65-5645-9bf8-0ef3532bbbccaa"
        }
    }
}
```

| ATTRIBUTE | TYPE | DESCRIPTION |
| --- | --- | --- |
| id | String | Unique identifier used for sharing the cart. |
| idCompanyUser | String | Unique identifier of the company user the cart is shared with. |
| idCartPermissionGroup | Integer | Unique identifier of the cart permission group that describes the permissions granted to the user the cart is shared with. |

## Possible errors

| CODE | REASON |
| --- | --- |
| 001 | The access token is invalid. |
| 002 | The access token is missing. |
| 101 | Cart is not found. |
| 104 | Cart uuid is missing. |
| 422 | Failed to share a cart. |
| 901 | `idCompanyUser` field is not specified or empty. |
| 2501 | Cart permission group is not found. |
| 2701 | Action is forbidden. |
| 2702 | Failed to share a cart. |
| 2703 | Shared cart not found. |
| 2704 | Shared cart ID is missing. |
| 2705 | Shared cart is not found. |
| 2706 | Failed to save the shared cart. |

## Next steps

* [Manage shared company user carts](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-carts/sharing-company-user-carts/managing-shared-company-user-carts.html)
