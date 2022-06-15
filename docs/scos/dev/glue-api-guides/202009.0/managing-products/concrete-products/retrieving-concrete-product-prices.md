---
title: Retrieving concrete product prices
search: exclude
description: Retrieve prices of concrete products.
last_updated: Feb 2, 2021
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v6/docs/retrieving-concrete-product-prices
originalArticleId: 1ce17649-6f18-4188-8841-6d56d20fae2e
redirect_from:
  - /v6/docs/retrieving-concrete-product-prices
  - /v6/docs/en/retrieving-concrete-product-prices
---

This endpoint allows to retrieve prices of concrete products.

## Installation
For detailed information on the modules that provide the API functionality and related installation instructions, see:
* [Glue API: Products Feature Integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-product-feature-integration.html).



## Retrieve prices of a concrete product

To retrieve prices of a concrete product, send the request:

---
`GET` **/concrete-products/*{% raw %}{{{% endraw %}concrete_product_sku{% raw %}}}{% endraw %}*/concrete-product-prices**

---


| Path parameter | Description |
| --- | --- |
| ***{% raw %}{{{% endraw %}concrete_product_sku{% raw %}}}{% endraw %}*** | SKU of a concrete product to get the price of. |



### Request


| Request  | Usage |
| --- | --- |
| `GET https://glue.mysprykershop.com/concrete-products/001_25904006/concrete-product-prices` | Retrieve the price of the `001_25904006` product.  |
| `GET  https://glue.mysprykershop.com/concrete-products/001_25904006/concrete-product-prices?currency=CHF&priceMode=GROSS_MODE` | Retrieve the gross price of the `001_25904006` product in Swiss Franc. |

| String parameter | Description | Exemplary values |
| --- | --- | --- |
| currency | Defines the currency to retrieve the price in. | USD, EUR, CHF |
| priceMode | 	Defines the price mode to retrieve the price in.  | GROSS_MODE, NET_MODE |



### Response


<details open>
    <summary markdown='span'>Response sample</summary>
    
```json
{
    "data": [
        {
            "type": "concrete-product-prices",
            "id": "001_25904006",
            "attributes": {
                "price": 9999,
                "prices": [
                    {
                        "priceTypeName": "DEFAULT",
                        "netAmount": null,
                        "grossAmount": 9999,
                        "currency": {
                            "code": "EUR",
                            "name": "Euro",
                            "symbol": "€"
                        }
                    },
                    {
                        "priceTypeName": "ORIGINAL",
                        "netAmount": null,
                        "grossAmount": 12564,
                        "currency": {
                            "code": "EUR",
                            "name": "Euro",
                            "symbol": "€"
                        }
                    }
                ]
            },
            "links": {
                "self": "https://glue.mysprykershop.com/concrete-products/001_25904006/concrete-product-prices"
            }
        }
    ],
    "links": {
        "self": "https://glue.mysprykershop.com/concrete-products/001_25904006/concrete-product-prices"
    }
}
```

</details>

<details open>
    <summary markdown='span'>Response sample with a gross price in Swiss Franc</summary>

```
{
    "data": [
        {
            "type": "concrete-product-prices",
            "id": "001_25904006",
            "attributes": {
                "price": 11499,
                "prices": [
                    {
                        "priceTypeName": "DEFAULT",
                        "netAmount": null,
                        "grossAmount": 11499,
                        "currency": {
                            "code": "CHF",
                            "name": "Swiss Franc",
                            "symbol": "CHF"
                        }
                    },
                    {
                        "priceTypeName": "ORIGINAL",
                        "netAmount": null,
                        "grossAmount": 14449,
                        "currency": {
                            "code": "CHF",
                            "name": "Swiss Franc",
                            "symbol": "CHF"
                        }
                    }
                ]
            },
            "links": {
                "self": "https://glue.mysprykershop.com/concrete-products/001_25904006/concrete-product-prices"
            }
        }
    ],
    "links": {
        "self": "https://glue.mysprykershop.com/concrete-products/001_25904006/items?currency=CHF&priceMode=GROSS_MODE"
    }
}
```

</details>


<a name="concrete-product-prices-response-attributes"></a>
| Attribute | Type | Description |
| --- | --- | --- |
| price | Integer | Price to pay for that product in cents. |
| priceTypeName|String|Price type. |
| netAmount|Integer|Net price in cents.|
|grossAmount|Integer|Gross price in cents.|
|currency.code|String|Currency code.|
|currency.name|String|Currency name.|
|currency.symbol | String | Currency symbol.|


## Possible errors

| Code | Meaning |
| --- | --- |
| 308 | Can't find concrete product prices. |

To view generic errors that originate from the Glue Application, see [Reference information: GlueApplication errors](/docs/scos/dev/glue-api-guides/{{page.version}}/reference-information-glueapplication-errors.html).
