---
title: Managing wishlist items
description: Retrieve details about wishlist items and learn what else you can do with the resource in the Spryker Marketplace.
template: glue-api-storefront-guide-template
---

This endpoint lets you add and remove items from wishlists.

## Installation

For detailed information on the modules that provide the API functionality and related installation instructions, see [Marketplace Wishlist feature integration](/docs/marketplace/dev/feature-integration-guides/{{page.version}}/marketplace-wishlist-feature-integration.html). 

## Add an item to a wishlist

To add an item to a wishlist, send the request:


***
`POST` {% raw %}**/wishlists/*{{wishlist_id}}*/wishlist-items**{% endraw %}
***

| PATH PARAMETER   | DESCRIPTION     |
| --------------- | ---------------- |
| {% raw %}***{{wishlist_id}}***{% endraw %} | Unique identifier of the wishlist to add the items to. [Create a wishlist](/docs/marketplace/dev/glue-api-guides/{{page.version}}/wishlists/managing-wishlists.html#create-a-wishlist) or [retrieve all wishlists](/docs/marketplace/dev/glue-api-guides/{{page.version}}/wishlists/managing-wishlists.html#retrieve-wishlists) to get it. |

### Request

<details>
<summary markdown='span'>Request sample: add an item to a wishlist</summary>

`POST https://glue.mysprykershop.com/wishlists/09264b7f-1894-58ed-81f4-d52d683e910a/wishlist-items`

```json
{
		"data": {
			"type": "wishlist-items",
			"attributes": {
				"sku": "064_18404924"
			}
		}
	}
```
</details>

<details>
<summary markdown='span'>Request sample: add a product offer to a wishlist</summary>

`POST https://glue.mysprykershop.com/wishlists/57c96d55-8a37-5998-927f-7bb663b69094/wishlist-items`

```json
{
    "data": {
        "type": "wishlist-items",
        "attributes": {
            "sku": "092_24495842",
            "productOfferReference": "offer5"
        }
    }
}
```
</details>

<details>
<summary markdown='span'>Request sample: add a marketplace product to a wishlist</summary>

`POST https://glue.mysprykershop.com/wishlists/57c96d55-8a37-5998-927f-7bb663b69094/wishlist-items`

```json
{
    "data": {
        "type": "wishlist-items",
        "attributes": {
            "sku": "109_19416433"
        }
    }
}
```
</details>

| ATTRIBUTE  | TYPE   | REQUIRED | DESCRIPTION   |
| ------------ | ----- | ---| ---------------- |
| sku  | String | &check; | SKU of a concrete product or a merchant concrete product to add.|
| productOfferReference | String | | Unique identifier of the product offer. You can get it by [retrieving the offers available for the concrete product](/docs/marketplace/dev/glue-api-guides/{{page.version}}/concrete-products/retrieving-product-offers-of-concrete-products.html).|

### Response

<details>
<summary markdown='span'>Response sample: add an item to a wishlist</summary>

```json
{
		"data": {
			"type": "wishlist-items",
			"id": "064_18404924",
			"attributes": {
				"sku": "064_18404924"
			},
			"links": {
				"self": "https://glue.mysprykershop.com/wishlists/c917e65b-e8c3-5c8b-bec6-892529c64b30/wishlist-items/064_18404924"
			}
		}
	}
```
</details>

<details>
<summary markdown='span'>Response sample: add a product offer to a wishlist</summary>

```json
{
    "data": {
        "type": "wishlist-items",
        "id": "092_24495842_offer5",
        "attributes": {
            "productOfferReference": "offer5",
            "merchantReference": "MER000001",
            "id": "092_24495842_offer5",
            "sku": "092_24495842",
            "availability": {
                "isNeverOutOfStock": true,
                "availability": true,
                "quantity": "10.0000000000"
            },
            "prices": [
                {
                    "priceTypeName": "ORIGINAL",
                    "grossAmount": 17459,
                    "netAmount": 15713,
                    "currency": {
                        "code": "EUR",
                        "name": "Euro",
                        "symbol": "€"
                    }
                },
                {
                    "priceTypeName": "DEFAULT",
                    "grossAmount": 7459,
                    "netAmount": 5713,
                    "currency": {
                        "code": "EUR",
                        "name": "Euro",
                        "symbol": "€"
                    }
                },
                {
                    "priceTypeName": "DEFAULT",
                    "grossAmount": 10000,
                    "netAmount": 8070,
                    "currency": {
                        "code": "CHF",
                        "name": "Swiss Franc",
                        "symbol": "CHF"
                    }
                }
            ]
        },
        "links": {
            "self": "https://glue.mysprykershop.com/wishlists/57c96d55-8a37-5998-927f-7bb663b69094/wishlist-items/092_24495842_offer5"
        }
    }
}
```
</details>

<details>
<summary markdown='span'>Response sample: add a marketplace product to a wishlist</summary>

```json
{
    "data": {
        "type": "wishlist-items",
        "id": "109_19416433",
        "attributes": {
            "productOfferReference": null,
            "merchantReference": "MER000001",
            "id": "109_19416433",
            "sku": "109_19416433",
            "availability": {
                "isNeverOutOfStock": false,
                "availability": true,
                "quantity": "10.0000000000"
            },
            "prices": []
        },
        "links": {
            "self": "https://glue.mysprykershop.com/wishlists/bb7dbe75-d892-582f-b438-d7f6cbfd3fc4/wishlist-items/109_19416433"
        }
    }
}
```
</details>



| ATTRIBUTE  | TYPE    | DESCRIPTION  |
| ----------- | ------ | --------------- |
| productOfferReference | String  | Unique identifier of the product offer.|
| merchantReference | String  | Unique identifier of the merchant.  |
| id     | String  | Unique identifier of the product offer in the wishlist. It's based on the `sku` and `productOfferReference`. |
| sku       | String  | SKU of the concrete product in the wishlist.     |
| availability    | Object  | Contains information on the product's availability. |
| availability.isNeverOutOfStock | Boolean | Defines if the product is never out of stock. |
| availability.availability  | Boolean | Defines if the product is available.  |
| availability.quantity  | Integer | Aggregated stock of the item in all [warehouses](/docs/scos/user/features/{{page.version}}/inventory-management-feature-overview.html#warehouse-management).   |
| prices  | Array   | Contains information on prices.    |
| prices.priceTypeName  | String  | Price type. |
| prices.grossAmount  | Integer | Gross price in cents.  |
| prices.netAmount | Integer | Net price in cents.   |
| prices.currency | Object | Currency information of the price |
| prices.currency.code  | String  | Currency code. |
| prices.currency.name   | String  | Currency name. |
| prices.currency.symbol       | String  | Currency symbol.   |

## Delete a wishlist item

To delete wishlist item, send the request:


***
`DELETE` {% raw %}**/wishlists/*{{wishlist_id}}*/wishlist-items/*{{item_sku}}***{% endraw %}
***


| PATH PARAMETER | DESCRIPTION   |
| -------------- | -------------- |
| {% raw %}***{{wishlist_id}}***{% endraw %} | Unique identifier of the wishlist to delete an item from. [Create a wishlist](/docs/marketplace/dev/glue-api-guides/{{page.version}}/wishlists/managing-wishlists.html#create-a-wishlist) or [retrieve all wishlists](/docs/marketplace/dev/glue-api-guides/{{page.version}}/wishlists/managing-wishlists.html#retrieve-wishlists) to get it. |
| {% raw %}***{{item_sku}}***{% endraw %}    | Unique identifier of the product to delete.                  |

### Request

Request sample:

`DELETE https://glue.mysprykershop.com/wishlists/09264b7f-1894-58ed-81f4-d52d683e910a/wishlist-items/064_18404924`

### Response

If the item is removed successfully, the endpoint returns the `204 No Content` status code.

## Possible errors

| CODE | REASON  |
| ------ | --------------- |
| 201  | Cannot find the wishlist.                                    |
| 206  | Cannot add an item to the wishlist.                          |
| 207  | Cannot remove the item.                                      |
| 208  | An item with the provided SKU does not exist in the wishlist. |

To view generic errors that originate from the Glue Application, see [Reference information: GlueApplication errors](/docs/scos/dev/glue-api-guides/{{page.version}}/reference-information-glueapplication-errors.html).
