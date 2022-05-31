---
title: Managing shopping list items
description: Learn how to manage shopping list items via Glue API.
last_updated: Jun 16, 2021
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/managing-shopping-list-items
originalArticleId: 9800fd79-ab57-4778-a68e-50b23236a3cc
redirect_from:
  - /2021080/docs/managing-shopping-list-items
  - /2021080/docs/en/managing-shopping-list-items
  - /docs/managing-shopping-list-items
  - /docs/en/managing-shopping-list-items
  - /docs/scos/dev/glue-api-guides/201811.0/managing-shopping-lists/managing-shopping-list-items.html
  - /docs/scos/dev/glue-api-guides/202005.0/managing-shopping-lists/managing-shopping-list-items.html
  - /docs/scos/dev/glue-api-guides/201903.0/managing-shopping-lists/managing-shopping-list-items.html
  - /docs/scos/dev/glue-api-guides/201907.0/managing-shopping-lists/managing-shopping-list-items.html
related:
  - title: Managing shopping lists
    link: docs/scos/dev/glue-api-guides/page.version/managing-shopping-lists/managing-shopping-lists.html
---

This endpoint allows managing shopping list items

## Installation

For detailed information on the modules that provide the API functionality and related installation instructions, see:
* [Glue API: Shopping Lists feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-shopping-lists-feature-integration.html)
* [Glue API: Products feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-product-feature-integration.html)

## Add items to a shopping list

To add items to a shopping list, send the request:

***
`POST` **/shopping-lists/*{% raw %}{{{% endraw %}shopping_list_id{% raw %}}}{% endraw %}*/shopping-list-items**
***

| PATH PARAMETER | DESCRIPTION |
| --- | --- |
| ***{% raw %}{{{% endraw %}shopping_list_id{% raw %}}}{% endraw %}*** | Unique identifier of a shopping list to add items to. |

### Request

| HEADER KEY | TYPE | REQUIRED | DESCRIPTION |
| --- | --- | --- | --- |
| Authorization | string | ✓ | String containing digits, letters, and symbols that authorize the company user. [Authenticate as a company user](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html#authenticate-as-a-company-user) to get the value.  |

| QUERY PARAMETER | DESCRIPTION | POSSIBLE VALUES |
| --- | --- | --- |
| include | Adds resource relationships to the request. | concrete-products |

| REQUEST SAMPLE | USAGE |
| --- | --- |
| `POST http://glue.mysprykershop.com/shopping-lists/ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a/shopping-list-items` | Add items to the shopping list with the `ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a` unique identifier. |
| `POST http://glue.mysprykershop.com/shopping-lists/ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a/shopping-list-items?include=concrete-products` | Add items to the shopping list with the `ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a` unique identifier. Include information about the concrete products in the shopping list into the response. |

```json
{
    "data": {
        "type": "shopping-list-items",
        "attributes": {
            "quantity": 4,
            "sku": "005_30663301"
       }
    }
}
```

| ATTRIBUTE | TYPE | REQUIRED | DESCRIPTION |
| --- | --- | --- | --- |
| quantity | Integer | ✓ | Quantity of the product to add. |
| sku | String | ✓ | SKU of the product to add. Only [concrete products](/docs/scos/user/features/{{page.version}}/product-feature-overview/product-feature-overview.html) are allowed. |

### Response

<details>
<summary markdown='span'>Response sample: add items to a shopping list</summary>

```json
  {
    "data": {
        "type": "shopping-list-items",
        "id": "00fed212-3dc9-569f-885f-3ddca41dea08",
        "attributes": {
            "quantity": 4,
            "sku": "005_30663301"
        },
        "links": {
            "self": "http://glue.mysprykershop.com/shopping-lists/ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a/shopping-list-items/00fed212-3dc9-569f-885f-3ddca41dea08"
        }
    }
}  
```
</details>

<details>
<summary markdown='span'>Response sample: add items to a shopping list with the details on concrete products</summary>

```json
    {
    "data": {
        "type": "shopping-list-items",
        "id": "6283f155-6b8a-5d8c-96b7-3af4091eea3e",
        "attributes": {
            "quantity": 4,
            "sku": "128_27314278"
        },
        "links": {
            "self": "https://glue.mysprykershop.com/shopping-lists/ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a/shopping-list-items/6283f155-6b8a-5d8c-96b7-3af4091eea3e"
        },
        "relationships": {
            "concrete-products": {
                "data": [
                    {
                        "type": "concrete-products",
                        "id": "128_27314278"
                    }
                ]
            }
        }
    },
    "included": [
        {
            "type": "concrete-products",
            "id": "128_27314278",
            "attributes": {
                "sku": "128_27314278",
                "isDiscontinued": false,
                "discontinuedNote": null,
                "averageRating": null,
                "reviewCount": 0,
                "name": "Lenovo ThinkCentre E73",
                "description": "Small Form Factor Small Form Factor desktops provide the ultimate performance with full-featured scalability, yet weigh as little as 13.2 lbs / 6 kgs. Keep your business-critical information safe through USB port disablement and the password-protected BIOS and HDD. You can also safeguard your hardware by physically securing your mouse and keyboard, while the Kensington slot enables you to lock down your E73. Lenovo Desktop Power Manager lets you balance power management and performance to save energy and lower costs. The E73 is also ENERGY STAR compliant, EPEAT® Gold and Cisco EnergyWise™ certified—so you can feel good about the planet and your bottom line. With SuperSpeed USB 3.0, transfer data up to 10 times faster than previous USB technologies. You can also connect to audio- and video-related devices with WiFi and Bluetooth® technology.",
                "attributes": {
                    "processor_threads": "8",
                    "pci_express_slots_version": "3",
                    "internal_memory": "8 GB",
                    "stepping": "C0",
                    "brand": "Lenovo",
                    "processor_frequency": "3.6 GHz"
                },
                "superAttributesDefinition": [
                    "internal_memory",
                    "processor_frequency"
                ],
                "metaTitle": "Lenovo ThinkCentre E73",
                "metaKeywords": "Lenovo,Tax Exempt",
                "metaDESCRIPTION": "Small Form Factor Small Form Factor desktops provide the ultimate performance with full-featured scalability, yet weigh as little as 13.2 lbs / 6 kgs. Keep",
                "attributeNames": {
                    "processor_threads": "Processor Threads",
                    "pci_express_slots_version": "PCI Express slots version",
                    "internal_memory": "Max internal memory",
                    "stepping": "Stepping",
                    "brand": "Brand",
                    "processor_frequency": "Processor frequency"
                }
            },
            "links": {
                "self": "https://glue.mysprykershop.com/concrete-products/128_27314278"
            }
        }
    ]
}
```
</details>

<a name="shopping-list-items-response-attributes"></a>

| ATTRIBUTE | TYPE | DESCRIPTION |
| --- | --- | --- |
| cell | cell | cell |
| quantity | Integer | Quantity of the product. |
| sku | String | Product SKU. |

For the attributes of included resources, see [Retrieve a concrete product](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-products/concrete-products/retrieving-concrete-products.html#concrete-products-response-attributes).

## Change item quantity in a shopping list

To change item quantity in a shopping list, send the request:

***
`PATCH` **/shopping-lists/*{% raw %}{{{% endraw %}shopping_list_id{% raw %}}}{% endraw %}*/shopping-list-items/*{% raw %}{{{% endraw %}shopping_list_item_id{% raw %}}}{% endraw %}***
***

| PATH PARAMETER | DESCRIPTION |
| --- | --- |
| ***{% raw %}{{{% endraw %}shopping_list_id{% raw %}}}{% endraw %}*** | Unique identifier of a shopping list to update item quantity in. |
| ***{% raw %}{{{% endraw %}shopping_list_item_id{% raw %}}}{% endraw %}*** | Unique identifier of a shopping list item to change the quantity of. To get it, [Retrieve shopping lists](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-shopping-lists/managing-shopping-lists.html#retrieve-shopping-lists), or [Retrieve a shopping list](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-shopping-lists/managing-shopping-lists.html#retrieve-a-shopping-list) with the `shopping-list-items` included. |

### Request

| HEADER KEY | TYPE | REQUIRED | DESCRIPTION |
| --- | --- | --- | --- |
| Authorization | string | ✓ | String containing digits, letters, and symbols that authorize the company user. [Authenticate as a company user](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html#authenticate-as-a-company-user) to get the value.  |

| QUERY PARAMETER | DESCRIPTION | EXEMPLARY VALUES |
| --- | --- | --- |
| include | Adds resource relationships to the request. | concrete-products|

| REQUEST SAMPLE | USAGE |
| --- | --- |
| `PATCH http://glue.mysprykershop.com/shopping-lists/ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a/shopping-list-items/00fed212-3dc9-569f-885f-3ddca41dea08` | In the shopping list with the id `ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a`, change quantity of the item with the id `00fed212-3dc9-569f-885f-3ddca41dea08`. |
| `PATCH http://glue.mysprykershop.com/shopping-lists/ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a/shopping-list-items/00fed212-3dc9-569f-885f-3ddca41dea08?include=concrete-products` | In the shopping list with the id `ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a`, change quantity of the item with the id `00fed212-3dc9-569f-885f-3ddca41dea08`. Include information about the respective concrete product into the response. |

```json
{
    "data": {
        "type": "shopping-list-items",
        "attributes": {
            "quantity": 12,
            "sku": "005_30663301"
       }
    }
}
```

| ATTRIBUTE | TYPE | REQUIRED | DESCRIPTION |
| --- | --- | --- |--- |
| sku | String | ✓ | SKU of the product you want to change the quantity of. Only [concrete products](/docs/scos/user/features/{{page.version}}/product-feature-overview/product-feature-overview.html) are allowed. |
| quantity | Integer | ✓ | New quantity of the product. |

### Response

<details>
<summary markdown='span'>Response sample: change item quantity in a shopping list</summary>

```json
    {
    "data": {
        "type": "shopping-list-items",
        "id": "00fed212-3dc9-569f-885f-3ddca41dea08",
        "attributes": {
            "quantity": 12,
            "sku": "005_30663301"
        },
        "links": {
            "self": "http://glue.mysprykershop.com/shopping-lists/ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a/shopping-list-items/00fed212-3dc9-569f-885f-3ddca41dea08"
        }
    }
}
```
</details>     

<details>
<summary markdown='span'>Response sample: change item quantity in a shopping list with the details on concrete products</summary>

```json
{
    "data": {
        "type": "shopping-list-items",
        "id": "6283f155-6b8a-5d8c-96b7-3af4091eea3e",
        "attributes": {...},
        "links": {... },
        "relationships": {
            "concrete-products": {
                "data": [
                    {
                        "type": "concrete-products",
                        "id": "128_27314278"
                    }
                ]
            }
        }
    },
    "included": [
        {
            "type": "concrete-products",
            "id": "128_27314278",
            "attributes": {
                "sku": "128_27314278",
                "isDiscontinued": false,
                "discontinuedNote": null,
                "averageRating": null,
                "reviewCount": 0,
                "name": "Lenovo ThinkCentre E73",
                "description": "Small Form Factor Small Form Factor desktops provide the ultimate performance with full-featured scalability, yet weigh as little as 13.2 lbs / 6 kgs. Keep your business-critical information safe through USB port disablement and the password-protected BIOS and HDD. You can also safeguard your hardware by physically securing your mouse and keyboard, while the Kensington slot enables you to lock down your E73. Lenovo Desktop Power Manager lets you balance power management and performance to save energy and lower costs. The E73 is also ENERGY STAR compliant, EPEAT® Gold and Cisco EnergyWise™ certified—so you can feel good about the planet and your bottom line. With SuperSpeed USB 3.0, transfer data up to 10 times faster than previous USB technologies. You can also connect to audio- and video-related devices with WiFi and Bluetooth® technology.",
                "attributes": {
                    "processor_threads": "8",
                    "pci_express_slots_version": "3",
                    "internal_memory": "8 GB",
                    "stepping": "C0",
                    "brand": "Lenovo",
                    "processor_frequency": "3.6 GHz"
                },
                "superAttributesDefinition": [
                    "internal_memory",
                    "processor_frequency"
                ],
                "metaTitle": "Lenovo ThinkCentre E73",
                "metaKeywords": "Lenovo,Tax Exempt",
                "metaDESCRIPTION": "Small Form Factor Small Form Factor desktops provide the ultimate performance with full-featured scalability, yet weigh as little as 13.2 lbs / 6 kgs. Keep",
                "attributeNames": {
                    "processor_threads": "Processor Threads",
                    "pci_express_slots_version": "PCI Express slots version",
                    "internal_memory": "Max internal memory",
                    "stepping": "Stepping",
                    "brand": "Brand",
                    "processor_frequency": "Processor frequency"
                }
            },
            "links": {
                "self": "http://glue.mysprykershop.com/concrete-products/128_27314278"
            }
        }
    ]
}

```
</details>   

For response attributes, see [Add items to a shopping list](#shopping-list-items-response-attributes).
For the attributes of included resources, see [Retrieve a concrete product](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-products/concrete-products/retrieving-concrete-products.html#concrete-products-response-attributes).

## Remove an item from a shopping list

To remove an item from a shopping list, send the request:

***
`DELETE` **/shopping-lists/*{% raw %}{{{% endraw %}shopping_list_id{% raw %}}}{% endraw %}*/shopping-list-items/*{% raw %}{{{% endraw %}shopping_list_item_id{% raw %}}}{% endraw %}***
***

| PATH PARAMETER | DESCRIPTION |
| --- | --- |
| ***{% raw %}{{{% endraw %}shopping_list_id{% raw %}}}{% endraw %}*** | Unique identifier of a shopping list to delete an item from. |
| ***{% raw %}{{{% endraw %}shopping_list_item_id{% raw %}}}{% endraw %}*** | Unique identifier of a shopping list item to remove. To get it, [Retrieve shopping lists](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-shopping-lists/managing-shopping-lists.html#retrieve-shopping-lists), or [Retrieve a shopping list](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-shopping-lists/managing-shopping-lists.html#retrieve-a-shopping-list) with the `shopping-list-items` included. |

### Request

| HEADER KEY | TYPE | REQUIRED | DESCRIPTION |
| --- | --- | --- | --- |
| Authorization | string | ✓ | String containing digits, letters, and symbols that authorize the company user. [Authenticate as a company user](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html#authenticate-as-a-company-user) to get the value.  |

Request sample: remove an item from a shopping list

`DELETE http://glue.mysprykershop.com/shopping-lists/ecdb5c3b-8bba-5a97-8e7b-c0a5a8f8a74a/shopping-list-items/00fed212-3dc9-569f-885f-3ddca41dea08`

### Response

If the item is removed successfully, the endpoint returns the `204 No Content` status code.

## Possible errors

| CODE | REASON |
| --- | --- |
| 001 | Access token is incorrect. |
| 002 | Access token is missing. |
| 400 | Provided access token is not an [access token of a company user](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html). |
| 901 | Shop list name or item name is not specified or too long.<br>**OR** <br> Item quantity is not specified or too large.|
| 1501 | Shopping list ID or item is not specified. |
| 1503 |  Specified shopping list is not found. |
| 1504 |  Specified shopping list item is not found. |
| 1508 | Concrete product is not found. |

To view generic errors that originate from the Glue Application, see [Reference information: GlueApplication errors](/docs/scos/dev/glue-api-guides/{{page.version}}/reference-information-glueapplication-errors.html).
