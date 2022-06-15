---
title: Retrieving Related Products
search: exclude
description: The article demonstrates how to find alternatives for discontinued products with the help of Glue API endpoints.
last_updated: Sep 15, 2020
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v5/docs/retrieving-related-products
originalArticleId: e46eed39-3641-4e35-9014-89c27fe73b4c
redirect_from:
  - /v5/docs/retrieving-related-products
  - /v5/docs/en/retrieving-related-products
related:
  - title: Retrieving Alternative Products
    link: docs/scos/dev/glue-api-guides/page.version/managing-products/retrieving-alternative-products.html
  - title: Retrieving Product Information
    link: docs/scos/dev/glue-api-guides/page.version/managing-products/retrieving-product-information.html
  - title: Product Relations Feature Overview
    link: docs/scos/user/features/page.version/product-relations-feature-overview.html
  - title: Catalog Search
    link: docs/scos/dev/glue-api-guides/page.version/searching-the-product-catalog.html
---

Using the **Product Relations** feature, sellers can define a list of comparable or additional items for each product. You can display such items, also called Related Products, in search and in the cart together with the products selected by customers. This can help boosting the cross- and up-selling performance of the outlet.

{% info_block infoBox %}
Only [abstract](/docs/scos/user/features/{{page.version}}/product-feature-overview/product-feature-overview.html
{% endinfo_block %} products support Product Relations. For more details, see [Product Relations](/docs/scos/user/features/{{page.version}}/product-relations-feature-overview.html).)

The Product Relations API provides REST endpoints to retrieve the related products. Using it, you can:

* Retrieve a list of related items for a specific related product;
* Get a list of related products for all items in a cart (for both guest carts and carts of registered users).

In your development, the endpoints can help you to:

* Provide comparable products on the product details pages and in search results to make it easier for customers to compare;
* Provide additional products items in a customer's cart to offer upscale variations, accessories and other additional items for products in the cart. This will help you in boosting the cart value.

{% info_block infoBox %}
To be able to use **Product Relations API**, first, you need to have the Product Relations feature integrated with your project. For details, see [Product Relation Integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-product-relations-feature-integration.html).
{% endinfo_block %}

{% info_block infoBox %}
Different types of relations, as well as their logic, are defined on the project level and can vary depending on the project-specific implementation. The API does not define any new relations. Its task is only to present related products via REST requests.
{% endinfo_block %}

## Installation
For detailed information on the modules that provide the API functionality and related installation instructions, see [GLUE API: Product Relations Feature Integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-product-relations-feature-integration.html).

## Retrieving Related Items of an Abstract Product
To get related items of an abstract product, send the request:

---
`GET` **/abstract-products/*{% raw %}{{{% endraw %}abstract_product_sku{% raw %}}}{% endraw %}*/related-products**

---

| Path parameter | Description |
| --- | --- |
| ***{% raw %}{{{% endraw %}abstract_product_sku{% raw %}}}{% endraw %}*** | SKU of an abstract product to retrieve related products of. | 

### Request 
| String parameter | Description | Exemplary values |
| --- | --- | --- |
| include | Adds resource relationships to the request. | product-labels |



| Request | Usage |
| --- | --- |
| `GET https://glue.mysprykershop.com/abstract-products/122/related-products` | Retrieve related products of the specified product. |
| `GET https://glue.mysprykershop.com/abstract-products/122/related-products?include=product-labels` | Retrieve related products of the specified product. Product labels assigned to the related products are included. |




### Response

<details open>
<summary markdown='span'>Response sample</summary>

```json
    {
  "data": [
    {
      "type": "abstract-products",
      "id": "128",
      "attributes": {
        "sku": "128",
        "name": "Lenovo ThinkCentre E73",
        "description": "",

        "superAttributesDefinition": [
          "internal_memory"
        ],
        "superAttributes": {
          "processor_frequency": [
            "3.6 GHz",
            "3.2 GHz"
          ]
        },
        "attributeMap": {
          "attribute_variants": {
            "processor_frequency:3.6 GHz": {
              "id_product_concrete": "128_27314278"
            },
            "processor_frequency:3.2 GHz": {
              "id_product_concrete": "128_29955336"
            }
          },
          "super_attributes": {
            "processor_frequency": [
              "3.6 GHz",
              "3.2 GHz"
            ]
          },
          "product_concrete_ids": [
            "128_29955336",
            "128_27314278"
          ]
        },
        "metaTitle": "Lenovo ThinkCentre E73",
        "metaKeywords": "Lenovo,Tax Exempt",
        "metaDescription": "Small Form Factor Small Form Factor desktops provide the ultimate performance with full-featured scalability, yet weigh as little as 13.2 lbs / 6 kgs. Keep",
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
        "self": "http://mysprykershop.com/abstract-products/128"
      }
    },
    {
      "type": "abstract-products",
      "id": "129",
      "attributes": {
        "sku": "129",
        "name": "Lenovo ThinkCenter E73",
        "description": "Eco-friendly and Energy Efficient Lenovo Desktop Power Manager lets you balance power management and performance to save energy and lower costs. The E73 is also ENERGY STAR compliant, EPEAT® Gold and Cisco EnergyWise™ certified—so you can feel good about the planet and your bottom line. With SuperSpeed USB 3.0, transfer data up to 10 times faster than previous USB technologies. You can also connect to audio- and video-related devices with WiFi and Bluetooth® technology. With 10% more processing power, 4th generation Intel® Core™ processors deliver the performance to increase business productivity for your business. They can also guard against identity theft and ensure safe access to your network with built-in security features.",
        "attributes": {
          "processor_threads": "8",
          "processor_cores": "4",
          "processor_codename": "Haswell",
          "pci_express_slots_version": "3",
          "brand": "Lenovo"
        },
        "superAttributesDefinition": [],
        "superAttributes": {
          "processor_frequency": [
            "3 GHz",
            "3.6 GHz",
            "3.2 GHz"
          ]
        },
        "attributeMap": {
          "attribute_variants": {
            "processor_frequency:3 GHz": {
              "id_product_concrete": "129_24325712"
            },
            "processor_frequency:3.6 GHz": {
              "id_product_concrete": "129_27107297"
            },
            "processor_frequency:3.2 GHz": {
              "id_product_concrete": "129_30706500"
            }
          },
          "super_attributes": {
            "processor_frequency": [
              "3 GHz",
              "3.6 GHz",
              "3.2 GHz"
            ]
          },
          "product_concrete_ids": [
            "129_30706500",
            "129_27107297",
            "129_24325712"
          ]
        },
        "metaTitle": "Lenovo ThinkCenter E73",
        "metaKeywords": "Lenovo,Tax Exempt",
        "metaDescription": "Eco-friendly and Energy Efficient Lenovo Desktop Power Manager lets you balance power management and performance to save energy and lower costs. The E73 is",
        "attributeNames": {
          "processor_threads": "Processor Threads",
          "processor_cores": "Processor cores",
          "processor_codename": "Processor codename",
          "pci_express_slots_version": "PCI Express slots version",
          "brand": "Brand",
          "processor_frequency": "Processor frequency"
        }
      },
      "links": {
        "self": "http://mysprykershop.com/abstract-products/129"
      }
    },
    {
      "type": "abstract-products",
      "id": "130",
      "attributes": {
        "sku": "130",
        "name": "Lenovo ThinkStation P300",
        "description": "Optional Flex Module The innovative Flex Module lets you customize I/O ports, so you add only what you need. With the 2 available 5.25\" bays on the P300 Tower, you can mix and match components including an ultraslim ODD, 29-in-1 media card reader, Firewire, and eSATA – up to 8 configurations among an ODD, HDD, and Flex Module. We've redesigned our ThinkStations. No more bulky handles, just a clean-looking, functional design. An extended lip on the top lid that includes a red touch point, combined with a ledge on the back-side, make the P300 exceptionally easy to lift and carry. The P300 workstation features a 15-month life cycle with no planned hardware changes that affect the preloaded software image. Image stability for long-term deployments helps to reduce transition, qualification, and testing costs to ensure savings for your business.",
        "attributes": {
          "processor_cores": "4",
          "processor_threads": "8",
          "bus_type": "DMI",
          "stepping": "C0",
          "brand": "Lenovo"
        },
        "superAttributesDefinition": [],
        "superAttributes": {
          "processor_frequency": [
            "3.5 GHz",
            "3.3 GHz",
            "3.6 GHz"
          ]
        },
        "attributeMap": {
          "attribute_variants": {
            "processor_frequency:3.5 GHz": {
              "id_product_concrete": "130_24725761"
            },
            "processor_frequency:3.3 GHz": {
              "id_product_concrete": "130_24326086"
            },
            "processor_frequency:3.6 GHz": {
              "id_product_concrete": "130_29285281"
            }
          },
          "super_attributes": {
            "processor_frequency": [
              "3.5 GHz",
              "3.3 GHz",
              "3.6 GHz"
            ]
          },
          "product_concrete_ids": [
            "130_29285281",
            "130_24326086",
            "130_24725761"
          ]
        },
        "metaTitle": "Lenovo ThinkStation P300",
        "metaKeywords": "Lenovo,Tax Exempt",
        "metaDescription": "Optional Flex Module The innovative Flex Module lets you customize I/O ports, so you add only what you need. With the 2 available 5.25\" bays on the P300 To",
        "attributeNames": {
          "processor_cores": "Processor cores",
          "processor_threads": "Processor Threads",
          "bus_type": "Bus type",
          "stepping": "Stepping",
          "brand": "Brand",
          "processor_frequency": "Processor frequency"
        }
      },
      "links": {
        "self": "http://mysprykershop.com/abstract-products/130"
      }
    },
    {
      "type": "abstract-products",
      "id": "131",
      "attributes": {
        "sku": "131",
        "name": "Lenovo ThinkStation P900",
        "description": "Thermal Design: Elegant & Efficient. Patented tri-channel cooling with just 3 system fans – as opposed to 10 that other workstations typically rely on — and a direct cooling air baffle directs fresh air into the CPU and memory. ThinkStation P900 delivers new technologies and design to keep your workstation cool and quiet. The innovative Flex Module lets you customize I/O ports, so you add only what you need. Using the 5.25\" bays, you can mix and match components including an ultraslim ODD, 29-in-1 media card reader, Firewire, and eSATA. The Flex Connector is a mezzanine card that fits into the motherboard and allows for expanded storage and I/O, without sacrificing the use of rear PCI. It supports SATA/SAS/PCIe advanced RAID solution. ThinkStation P900 includes two available connectors (enabled with each CPU).",
        "attributes": {
          "processor_frequency": "2.4 GHz",
          "processor_cores": "6",
          "processor_threads": "12",
          "stepping": "R2",
          "brand": "Lenovo",
          "color": "Black"
        },
        "superAttributesDefinition": [
          "processor_frequency",
          "color"
        ],
        "superAttributes": [],
        "attributeMap": {
          "attribute_variants": [],
          "super_attributes": [],
          "product_concrete_ids": [
            "131_24872891"
          ]
        },
        "metaTitle": "Lenovo ThinkStation P900",
        "metaKeywords": "Lenovo,Tax Exempt",
        "metaDescription": "Thermal Design: Elegant & Efficient. Patented tri-channel cooling with just 3 system fans – as opposed to 10 that other workstations typically rely on — an",
        "attributeNames": {
          "processor_frequency": "Processor frequency",
          "processor_cores": "Processor cores",
          "processor_threads": "Processor Threads",
          "stepping": "Stepping",
          "brand": "Brand",
          "color": "Color"
        }
      },
      "links": {
        "self": "http://glue.de.suite-split-released.local/abstract-products/131"
      }
    }
  ],
  "links": {
    "self": "http://mysprykershop.com/abstract-products/122/related-products"
  }
}
```
</details>







<details open>
<summary markdown='span'>Response sample with included product labels</summary>

```json
 {
    "data": [
        {
            "type": "abstract-products",
            "id": "128",
            "attributes": {
                "sku": "128",
                "averageRating": null,
                "reviewCount": 0,
                "name": "Lenovo ThinkCentre E73",
                "description": "Small Form Factor Small Form Factor desktops provide the ultimate performance with full-featured scalability, yet weigh as little as 13.2 lbs / 6 kgs. Keep your business-critical information safe through USB port disablement and the password-protected BIOS and HDD. You can also safeguard your hardware by physically securing your mouse and keyboard, while the Kensington slot enables you to lock down your E73. Lenovo Desktop Power Manager lets you balance power management and performance to save energy and lower costs. The E73 is also ENERGY STAR compliant, EPEAT® Gold and Cisco EnergyWise™ certified—so you can feel good about the planet and your bottom line. With SuperSpeed USB 3.0, transfer data up to 10 times faster than previous USB technologies. You can also connect to audio- and video-related devices with WiFi and Bluetooth® technology.",
                "attributes": {
                    "processor_threads": "8",
                    "pci_express_slots_version": "3",
                    "internal_memory": "8 GB",
                    "stepping": "C0",
                    "brand": "Lenovo"
                },
                "superAttributesDefinition": [
                    "internal_memory"
                ],
                "superAttributes": {
                    "processor_frequency": [
                        "3.6 GHz",
                        "3.2 GHz"
                    ]
                },
                "attributeMap": {
                    "product_concrete_ids": [
                        "128_29955336",
                        "128_27314278"
                    ],
                    "super_attributes": {
                        "processor_frequency": [
                            "3.6 GHz",
                            "3.2 GHz"
                        ]
                    },
                    "attribute_variants": {
                        "processor_frequency:3.6 GHz": {
                            "id_product_concrete": "128_27314278"
                        },
                        "processor_frequency:3.2 GHz": {
                            "id_product_concrete": "128_29955336"
                        }
                    }
                },
                "metaTitle": "Lenovo ThinkCentre E73",
                "metaKeywords": "Lenovo,Tax Exempt",
                "metaDescription": "Small Form Factor Small Form Factor desktops provide the ultimate performance with full-featured scalability, yet weigh as little as 13.2 lbs / 6 kgs. Keep",
                "attributeNames": {
                    "processor_threads": "Processor Threads",
                    "pci_express_slots_version": "PCI Express slots version",
                    "internal_memory": "Max internal memory",
                    "stepping": "Stepping",
                    "brand": "Brand",
                    "processor_frequency": "Processor frequency"
                },
                "url": "/en/lenovo-thinkcentre-e73-128"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/abstract-products/128"
            },
            "relationships": {
                "product-labels": {
                    "data": [
                        {
                            "type": "product-labels",
                            "id": "5"
                        }
                    ]
                }
            }
        },
        {
            "type": "abstract-products",
            "id": "129",
            "attributes": {
                "sku": "129",
                "averageRating": null,
                "reviewCount": 0,
                "name": "Lenovo ThinkCenter E73",
                "description": "Eco-friendly and Energy Efficient Lenovo Desktop Power Manager lets you balance power management and performance to save energy and lower costs. The E73 is also ENERGY STAR compliant, EPEAT® Gold and Cisco EnergyWise™ certified—so you can feel good about the planet and your bottom line. With SuperSpeed USB 3.0, transfer data up to 10 times faster than previous USB technologies. You can also connect to audio- and video-related devices with WiFi and Bluetooth® technology. With 10% more processing power, 4th generation Intel® Core™ processors deliver the performance to increase business productivity for your business. They can also guard against identity theft and ensure safe access to your network with built-in security features.",
                "attributes": {
                    "processor_threads": "8",
                    "processor_cores": "4",
                    "processor_codename": "Haswell",
                    "pci_express_slots_version": "3",
                    "brand": "Lenovo"
                },
                "superAttributesDefinition": [],
                "superAttributes": {
                    "processor_frequency": [
                        "3 GHz",
                        "3.6 GHz",
                        "3.2 GHz"
                    ]
                },
                "attributeMap": {
                    "product_concrete_ids": [
                        "129_30706500",
                        "129_27107297",
                        "129_24325712"
                    ],
                    "super_attributes": {
                        "processor_frequency": [
                            "3 GHz",
                            "3.6 GHz",
                            "3.2 GHz"
                        ]
                    },
                    "attribute_variants": {
                        "processor_frequency:3 GHz": {
                            "id_product_concrete": "129_24325712"
                        },
                        "processor_frequency:3.6 GHz": {
                            "id_product_concrete": "129_27107297"
                        },
                        "processor_frequency:3.2 GHz": {
                            "id_product_concrete": "129_30706500"
                        }
                    }
                },
                "metaTitle": "Lenovo ThinkCenter E73",
                "metaKeywords": "Lenovo,Tax Exempt",
                "metaDescription": "Eco-friendly and Energy Efficient Lenovo Desktop Power Manager lets you balance power management and performance to save energy and lower costs. The E73 is",
                "attributeNames": {
                    "processor_threads": "Processor Threads",
                    "processor_cores": "Processor cores",
                    "processor_codename": "Processor codename",
                    "pci_express_slots_version": "PCI Express slots version",
                    "brand": "Brand",
                    "processor_frequency": "Processor frequency"
                },
                "url": "/en/lenovo-thinkcenter-e73-129"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/abstract-products/129"
            }
        },
        {
            "type": "abstract-products",
            "id": "130",
            "attributes": {
                "sku": "130",
                "averageRating": null,
                "reviewCount": 0,
                "name": "Lenovo ThinkStation P300",
                "description": "Optional Flex Module The innovative Flex Module lets you customize I/O ports, so you add only what you need. With the 2 available 5.25\" bays on the P300 Tower, you can mix and match components including an ultraslim ODD, 29-in-1 media card reader, Firewire, and eSATA – up to 8 configurations among an ODD, HDD, and Flex Module. We've redesigned our ThinkStations. No more bulky handles, just a clean-looking, functional design. An extended lip on the top lid that includes a red touch point, combined with a ledge on the back-side, make the P300 exceptionally easy to lift and carry. The P300 workstation features a 15-month life cycle with no planned hardware changes that affect the preloaded software image. Image stability for long-term deployments helps to reduce transition, qualification, and testing costs to ensure savings for your business.",
                "attributes": {
                    "processor_cores": "4",
                    "processor_threads": "8",
                    "bus_type": "DMI",
                    "stepping": "C0",
                    "brand": "Lenovo"
                },
                "superAttributesDefinition": [],
                "superAttributes": {
                    "processor_frequency": [
                        "3.5 GHz",
                        "3.3 GHz",
                        "3.6 GHz"
                    ]
                },
                "attributeMap": {
                    "product_concrete_ids": [
                        "130_29285281",
                        "130_24326086",
                        "130_24725761"
                    ],
                    "super_attributes": {
                        "processor_frequency": [
                            "3.5 GHz",
                            "3.3 GHz",
                            "3.6 GHz"
                        ]
                    },
                    "attribute_variants": {
                        "processor_frequency:3.5 GHz": {
                            "id_product_concrete": "130_24725761"
                        },
                        "processor_frequency:3.3 GHz": {
                            "id_product_concrete": "130_24326086"
                        },
                        "processor_frequency:3.6 GHz": {
                            "id_product_concrete": "130_29285281"
                        }
                    }
                },
                "metaTitle": "Lenovo ThinkStation P300",
                "metaKeywords": "Lenovo,Tax Exempt",
                "metaDescription": "Optional Flex Module The innovative Flex Module lets you customize I/O ports, so you add only what you need. With the 2 available 5.25\" bays on the P300 To",
                "attributeNames": {
                    "processor_cores": "Processor cores",
                    "processor_threads": "Processor Threads",
                    "bus_type": "Bus type",
                    "stepping": "Stepping",
                    "brand": "Brand",
                    "processor_frequency": "Processor frequency"
                },
                "url": "/en/lenovo-thinkstation-p300-130"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/abstract-products/130"
            }
        },
        {
            "type": "abstract-products",
            "id": "131",
            "attributes": {
                "sku": "131",
                "averageRating": null,
                "reviewCount": 0,
                "name": "Lenovo ThinkStation P900",
                "description": "Thermal Design: Elegant & Efficient. Patented tri-channel cooling with just 3 system fans – as opposed to 10 that other workstations typically rely on — and a direct cooling air baffle directs fresh air into the CPU and memory. ThinkStation P900 delivers new technologies and design to keep your workstation cool and quiet. The innovative Flex Module lets you customize I/O ports, so you add only what you need. Using the 5.25\" bays, you can mix and match components including an ultraslim ODD, 29-in-1 media card reader, Firewire, and eSATA. The Flex Connector is a mezzanine card that fits into the motherboard and allows for expanded storage and I/O, without sacrificing the use of rear PCI. It supports SATA/SAS/PCIe advanced RAID solution. ThinkStation P900 includes two available connectors (enabled with each CPU).",
                "attributes": {
                    "processor_frequency": "2.4 GHz",
                    "processor_cores": "6",
                    "processor_threads": "12",
                    "stepping": "R2",
                    "brand": "Lenovo",
                    "color": "Black"
                },
                "superAttributesDefinition": [
                    "processor_frequency",
                    "color"
                ],
                "superAttributes": {
                    "color": [
                        "Silver"
                    ]
                },
                "attributeMap": {
                    "product_concrete_ids": [
                        "131_24872891"
                    ],
                    "super_attributes": {
                        "color": [
                            "Silver"
                        ]
                    },
                    "attribute_variants": []
                },
                "metaTitle": "Lenovo ThinkStation P900",
                "metaKeywords": "Lenovo,Tax Exempt",
                "metaDescription": "Thermal Design: Elegant & Efficient. Patented tri-channel cooling with just 3 system fans – as opposed to 10 that other workstations typically rely on — an",
                "attributeNames": {
                    "processor_frequency": "Processor frequency",
                    "processor_cores": "Processor cores",
                    "processor_threads": "Processor Threads",
                    "stepping": "Stepping",
                    "brand": "Brand",
                    "color": "Color"
                },
                "url": "/en/lenovo-thinkstation-p900-131"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/abstract-products/131"
            }
        }
    ],
    "links": {
        "self": "https://glue.mysprykershop.com/abstract-products/122/related-products?include=product-labels"
    },
    "included": [
        {
            "type": "product-labels",
            "id": "5",
            "attributes": {
                "name": "SALE %",
                "isExclusive": false,
                "position": 3,
                "frontEndReference": "highlight"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/product-labels/5"
            }
        }
    ]
}
```
</details>






<a name="related-product-attributes"></a>

| Attribute | Type | Description |
| --- | --- | --- |
| sku | String | SKU of the abstract product |
| name | String | Name of the abstract product |
| description | String | Description of the abstract product |
| attributes | Object | Dist of attributes and their values |
| superAttributeDefinition | String[] | Attributes flagged as super attributes, that are however not relevant to distinguish between the product variants |
| attributeMap|Object|Each super attribute / value combination and the corresponding concrete product IDs are listed here|
|attributeMap.super_attributes|Object|Applicable super attribute and its values for the product variants|
|attributeMap.attribute_variants|Object|List of super attributes with the list of values|
|attributeMap.product_concrete_ids|String[]|Product IDs of the product variants|
|metaTitle|String|Meta title of the product|
|metaKeywords|String|Meta keywords of the product.|
|metaDescription|String|Meta description of the product.|
|attributeNames | Object | All non-super attribute / value combinations for the abstract product. |

| Included resource | Attribute | Type | Description |
| --- | --- | --- | --- |
| product labels | name | String | Specifies the label name. |
| product labels | isExclusive | Boolean | Indicates whether the label is `exclusive`.<br>If the attribute is set to true, the current label takes precedence over other labels the product might have. This means that only the current label should be displayed for the product, and all other possible labels should be hidden. |
| product labels | position | Integer | Indicates the label priority.<br>Labels should be indicated on the frontend according to their priority, from the highest (**1**) to the lowest, unless a product has a label with the `isExclusive` attribute set.|
| product labels | frontEndReference | String |Specifies the label custom label type (CSS class).<br>If the attribute is an empty string, the label should be displayed using the default CSS style. |





## Retrieving Upselling Products of a Registered User's Cart
To get upselling items for all products in a cart of a registered customer, send the request:

---
`GET` **/carts/*{% raw %}{{{% endraw %}cart_id{% raw %}}}{% endraw %}*/up-selling-products**

---


| Path parameter | Description |
| --- | --- |
| ***{% raw %}{{{% endraw %}cart_id{% raw %}}}{% endraw %}}*** | ID of a cart to get upselling items of. [Retrieve all carts](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-carts/carts-of-registered-users/managing-carts-of-registered-users.html#retrieve-all-carts) to get it. | 

### Request
Request sample : `GET http://mysprykershop.com/carts/1ce91011-8d60-59ef-9fe0-4493ef3628b2/up-selling-products`


### Response



<details open>
<summary markdown='span'> Sample Response</summary>

```json
{
    "data": [
        {
            "type": "abstract-products",
            "id": "163",
            "attributes": {
                "sku": "163",
                "averageRating": null,
                "reviewCount": 0,
                "name": "Asus ZenPad Z380C-1B",
                "description": "Bigger while smaller ASUS ZenPad 8.0 is an 8-inch tablet with a 76.5% screen-to-body ratio — an incredible engineering achievement made possible by reducing the bezel width to the bare minimum. ASUS VisualMaster is a suite of exclusive visual enhancement technologies that combine hardware and software to optimize all aspects of the display — including contrast, sharpness, color, clarity, and brightness — resulting in an incredibly realistic viewing experience. With ASUS VisualMaster, it’s just like being there. ASUS Audio Cover is an entertainment accessory that brings cinematic, 5.1-channel surround sound to ASUS ZenPad 8.0. DTS-HD Premium Sound and SonicMaster technology provide further enhancement, ensuring the ultimate audio experience on ASUS ZenPad 8.0. Intelligent contrast enhancement analyzes and optimizes each pixel in an image before it is reproduced, rendering more detail in the highlights and shadows to reveal the true beauty in your pictures.",
                "attributes": {
                    "processor_cores": "4",
                    "storage_media": "flash",
                    "display_technology": "IPS",
                    "internal_memory": "2GB",
                    "brand": "Asus",
                    "color": "Black"
                },
                "superAttributesDefinition": [
                    "storage_media",
                    "internal_memory",
                    "color"
                ],
                "superAttributes": {
                    "color": [
                        "Black"
                    ]
                },
                "attributeMap": {
                    "product_concrete_ids": [
                        "163_29728850"
                    ],
                    "super_attributes": {
                        "color": [
                            "Black"
                        ]
                    },
                    "attribute_variants": []
                },
                "metaTitle": "Asus ZenPad Z380C-1B",
                "metaKeywords": "Asus,Communication Electronics",
                "metaDescription": "Bigger while smaller ASUS ZenPad 8.0 is an 8-inch tablet with a 76.5% screen-to-body ratio — an incredible engineering achievement made possible by reducin",
                "attributeNames": {
                    "processor_cores": "Processor cores",
                    "storage_media": "Storage media",
                    "display_technology": "Display technology",
                    "internal_memory": "Max internal memory",
                    "brand": "Brand",
                    "color": "Color"
                },
                "url": "/en/asus-zenpad-z380c-1b-163"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/abstract-products/163"
            }
        },
        {
            "type": "abstract-products",
            "id": "164",
            "attributes": {
                "sku": "164",
                "averageRating": null,
                "reviewCount": 0,
                "name": "Asus ZenPad Z380C-1B",
                "description": "Bigger while smaller ASUS ZenPad 8.0 is an 8-inch tablet with a 76.5% screen-to-body ratio — an incredible engineering achievement made possible by reducing the bezel width to the bare minimum. ASUS VisualMaster is a suite of exclusive visual enhancement technologies that combine hardware and software to optimize all aspects of the display — including contrast, sharpness, color, clarity, and brightness — resulting in an incredibly realistic viewing experience. With ASUS VisualMaster, it’s just like being there. ASUS Audio Cover is an entertainment accessory that brings cinematic, 5.1-channel surround sound to ASUS ZenPad 8.0. DTS-HD Premium Sound and SonicMaster technology provide further enhancement, ensuring the ultimate audio experience on ASUS ZenPad 8.0. Intelligent contrast enhancement analyzes and optimizes each pixel in an image before it is reproduced, rendering more detail in the highlights and shadows to reveal the true beauty in your pictures.",
                "attributes": {
                    "processor_cores": "4",
                    "storage_media": "flash",
                    "display_technology": "IPS",
                    "internal_memory": "2GB",
                    "brand": "Asus",
                    "color": "White"
                },
                "superAttributesDefinition": [
                    "storage_media",
                    "internal_memory",
                    "color"
                ],
                "superAttributes": {
                    "color": [
                        "White"
                    ]
                },
                "attributeMap": {
                    "product_concrete_ids": [
                        "164_29565390"
                    ],
                    "super_attributes": {
                        "color": [
                            "White"
                        ]
                    },
                    "attribute_variants": []
                },
                "metaTitle": "Asus ZenPad Z380C-1B",
                "metaKeywords": "Asus,Communication Electronics",
                "metaDescription": "Bigger while smaller ASUS ZenPad 8.0 is an 8-inch tablet with a 76.5% screen-to-body ratio — an incredible engineering achievement made possible by reducin",
                "attributeNames": {
                    "processor_cores": "Processor cores",
                    "storage_media": "Storage media",
                    "display_technology": "Display technology",
                    "internal_memory": "Max internal memory",
                    "brand": "Brand",
                    "color": "Color"
                },
                "url": "/en/asus-zenpad-z380c-1b-164"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/abstract-products/164"
            }
        },
        {
            "type": "abstract-products",
            "id": "165",
            "attributes": {
                "sku": "165",
                "averageRating": null,
                "reviewCount": 0,
                "name": "Asus ZenPad Z580CA",
                "description": "Fashion-inspired design The design of ASUS ZenPad S 8.0 carries modern influences and a simple, clean look that gives it a universal and stylish appeal. These elements are inspired by our Zen design philosophy of balancing beauty and strength. ASUS ZenPad S 8.0 is an 8-inch tablet that is only 6.6mm thin, weighs just 298g, and has a 74% screen-to-body ratio — an incredible engineering achievement made possible by reducing the bezel width to the bare minimum. Intelligent contrast enhancement analyzes and optimizes each pixel in an image before it is reproduced, rendering more detail in the highlights and shadows to reveal the true beauty in your pictures. ASUS ZenPad S 8.0 is equipped with ASUS Tru2Life+ technology, which improves video with fast action scenes — such as sports — by increasing the screen refresh rate, resulting in reduced blur and smooth, detailed motion.",
                "attributes": {
                    "processor_cores": "4",
                    "display_technology": "IPS",
                    "touch_technology": "Multi-touch",
                    "brand": "Asus",
                    "color": "Black"
                },
                "superAttributesDefinition": [
                    "color"
                ],
                "superAttributes": {
                    "internal_storage_capacity": [
                        "32 GB",
                        "64 GB"
                    ]
                },
                "attributeMap": {
                    "product_concrete_ids": [
                        "165_29879507",
                        "165_29879528"
                    ],
                    "super_attributes": {
                        "internal_storage_capacity": [
                            "32 GB",
                            "64 GB"
                        ]
                    },
                    "attribute_variants": {
                        "internal_storage_capacity:32 GB": {
                            "id_product_concrete": "165_29879528"
                        },
                        "internal_storage_capacity:64 GB": {
                            "id_product_concrete": "165_29879507"
                        }
                    }
                },
                "metaTitle": "Asus ZenPad Z580CA",
                "metaKeywords": "Asus,Communication Electronics",
                "metaDescription": "Fashion-inspired design The design of ASUS ZenPad S 8.0 carries modern influences and a simple, clean look that gives it a universal and stylish appeal. Th",
                "attributeNames": {
                    "processor_cores": "Processor cores",
                    "display_technology": "Display technology",
                    "touch_technology": "Touch Technology",
                    "brand": "Brand",
                    "color": "Color",
                    "internal_storage_capacity": "Internal storage capacity"
                },
                "url": "/en/asus-zenpad-z580ca-165"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/abstract-products/165"
            }
        },
        {
            "type": "abstract-products",
            "id": "166",
            "attributes": {
                "sku": "166",
                "averageRating": null,
                "reviewCount": 0,
                "name": "Asus ZenPad Z580CA-1B",
                "description": "Fashion-inspired design The design of ASUS ZenPad S 8.0 carries modern influences and a simple, clean look that gives it a universal and stylish appeal. These elements are inspired by our Zen design philosophy of balancing beauty and strength. ASUS VisualMaster is a suite of exclusive visual enhancement technologies that combine hardware and software to optimize all aspects of the display — including contrast, sharpness, color, clarity, and brightness — resulting in an incredibly realistic viewing experience. With ASUS VisualMaster, it’s just like being there. ASUS ZenPad S 8.0 is equipped with ASUS Tru2Life+ technology, which improves video with fast action scenes — such as sports — by increasing the screen refresh rate, resulting in reduced blur and smooth, detailed motion.",
                "attributes": {
                    "internal_memory": "4 GB",
                    "display_technology": "IPS",
                    "processor_cache": "2 MB",
                    "brand": "Asus",
                    "color": "White"
                },
                "superAttributesDefinition": [
                    "internal_memory",
                    "processor_cache",
                    "color"
                ],
                "superAttributes": {
                    "internal_storage_capacity": [
                        "32 GB",
                        "64 GB"
                    ]
                },
                "attributeMap": {
                    "product_concrete_ids": [
                        "166_30230575",
                        "166_29565389"
                    ],
                    "super_attributes": {
                        "internal_storage_capacity": [
                            "32 GB",
                            "64 GB"
                        ]
                    },
                    "attribute_variants": {
                        "internal_storage_capacity:32 GB": {
                            "id_product_concrete": "166_29565389"
                        },
                        "internal_storage_capacity:64 GB": {
                            "id_product_concrete": "166_30230575"
                        }
                    }
                },
                "metaTitle": "Asus ZenPad Z580CA-1B",
                "metaKeywords": "Asus,Communication Electronics",
                "metaDescription": "Fashion-inspired design The design of ASUS ZenPad S 8.0 carries modern influences and a simple, clean look that gives it a universal and stylish appeal. Th",
                "attributeNames": {
                    "internal_memory": "Max internal memory",
                    "display_technology": "Display technology",
                    "processor_cache": "Processor cache type",
                    "brand": "Brand",
                    "color": "Color",
                    "internal_storage_capacity": "Internal storage capacity"
                },
                "url": "/en/asus-zenpad-z580ca-1b-166"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/abstract-products/166"
            }
        }
    ],
    "links": {
        "self": "https://glue.mysprykershop.com/carts/61ab15e9-e24a-5dec-a1ef-fc333bd88b0a/up-selling-products"
    }
}
```
<br>
</details>


See [Retrieving Related Items of an Abstract Product](#related-product-attributes) for the list of response attributes.




## Retrieving Up-Selling Products for a Guest Cart
To get up-selling items for products in a guest cart, send the request:
`GET` **/guest-carts/*{% raw %}{{{% endraw %}guest_cart_id{% raw %}}}{% endraw %}*/up-selling-products**

| Path parameter | Description |
| --- | --- |
| ***{% raw %}{{{% endraw %}guest_cart_id{% raw %}}}{% endraw %}}*** | ID of a guest cart to get upselling items of.  | 


### Request
| Header key | Header value example | Required | Description | 
|---|---|---|---|
| X-Anonymous-Customer-Unique-Id | 164b-5708-8530 | ✓ | A hyphenated alphanumeric value that is the user's unique identifier. This value is passed as a header when [creating a guest cart](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-carts/guest-carts/managing-guest-carts.html#creating-a-guest-cart). | 

Request sample : `GET https://glue.mysprykershop.com/guest-carts/1ce91011-8d60-59ef-9fe0-4493ef3628b2/up-selling-products`.


### Response

<details open>
<summary markdown='span'>Sample Response </summary>

```js
{
    "data": [
        {
            "type": "abstract-products",
            "id": "138",
            "attributes": {
                "sku": "138",
                "name": "Acer TravelMate P258-M",
                "description": "Tactile textile The P2 series now comes with a fine linen textile pattern embossed on the outer covers. This lends a professional refined look and feel to the line that adds distinction to functionality. There are also practical benefits, as the pattern makes it a bit easier to keep a firm grip on the go, while also resisting scratches. The TravelMate P2 Series is certified to deliver the high audio and visual standards of Skype for Business1. Optimised hardware ensures that every word will be heard clearly with no gap or lag in speech, minimal background noise and zero echo. That means you can call or video chat with superior audio and visual quality. The TravelMate P2 is packed with features that make it easier to do business. Work faster with smoother gestures on the large Precision Touchpad. Quickly share business contacts with a smartphone via Contact Pickup. Log in to the TravelMate P2 faster thanks to Face Login.\t",
                "attributes": {
                    "form_factor": "clamshell",
                    "processor_cache": "3 MB",
                    "stepping": "D1",
                    "brand": "Acer",
                    "color": "Black"
                },
                "superAttributesDefinition": [
                    "form_factor",
                    "processor_cache",
                    "color"
                ],
                "superAttributes": {
                    "processor_frequency": [
                        "3.1 GHz",
                        "2.8 GHz"
                    ]
                },
                "attributeMap": {
                    "attribute_variants": {
                        "processor_frequency:3.1 GHz": {
                            "id_product_concrete": "138_30657838"
                        },
                        "processor_frequency:2.8 GHz": {
                            "id_product_concrete": "138_30046855"
                        }
                    },
                    "super_attributes": {
                        "processor_frequency": [
                            "3.1 GHz",
                            "2.8 GHz"
                        ]
                    },
                    "product_concrete_ids": [
                        "138_30046855",
                        "138_30657838"
                    ]
                },
                "metaTitle": "Acer TravelMate P258-M",
                "metaKeywords": "Acer,Entertainment Electronics",
                "metaDescription": "Tactile textile The P2 series now comes with a fine linen textile pattern embossed on the outer covers. This lends a professional refined look and feel to",
                "attributeNames": {
                    "form_factor": "Form factor",
                    "processor_cache": "Processor cache type",
                    "stepping": "Stepping",
                    "brand": "Brand",
                    "color": "Color",
                    "processor_frequency": "Processor frequency"
                }
            },
            "links": {
                "self": "http://mysprykershop.com/abstract-products/138"
            }
        },
        {
            "type": "abstract-products",
            "id": "042",
            "attributes": {
                "sku": "042",
                "name": "Samsung Galaxy S7",
                "description": "Smart Design The beauty of what we've engineered is to give you the slimmest feel in your hand without compromising the big screen size. The elegantly curved front and back fit in your palm just right. It's as beautiful to look at as it is to use. We spent a long time perfecting the curves of the Galaxy S7 edge and S7. Using a proprietary process called 3D Thermoforming, we melted 3D glass to curve with such precision that it meets the curved metal alloy to create an exquisitely seamless and strong unibody. The dual-curve backs on the Galaxy S7 edge and S7 are the reason why they feel so comfortable when you hold them. Everything about the design, from the naturally flowing lines to the thin form factor, come together to deliver a grip that's so satisfying, you won't want to let go.",
                "attributes": {
                    "usb_version": "2",
                    "os_version": "6",
                    "max_memory_card_size": "200 GB",
                    "weight": "152 g",
                    "brand": "Samsung",
                    "color": "Gold"
                },
                "superAttributesDefinition": [
                    "color"
                ],
                "superAttributes": [],
                "attributeMap": {
                    "attribute_variants": [],
                    "super_attributes": [],
                    "product_concrete_ids": [
                        "042_31040075"
                    ]
                },
                "metaTitle": "Samsung Galaxy S7",
                "metaKeywords": "Samsung,Communication Electronics",
                "metaDescription": "Smart Design The beauty of what we've engineered is to give you the slimmest feel in your hand without compromising the big screen size. The elegantly curv",
                "attributeNames": {
                    "usb_version": "USB version",
                    "os_version": "OS version",
                    "max_memory_card_size": "Max memory card size",
                    "weight": "Weight",
                    "brand": "Brand",
                    "color": "Color"
                }
            },
            "links": {
                "self": "http://mysprykershop.com/abstract-products/042"
            }
        },
        {
            "type": "abstract-products",
            "id": "043",
            "attributes": {
                "sku": "043",
                "name": "Samsung Galaxy S7",
                "description": "Smart Design The beauty of what we've engineered is to give you the slimmest feel in your hand without compromising the big screen size. The elegantly curved front and back fit in your palm just right. It's as beautiful to look at as it is to use. We spent a long time perfecting the curves of the Galaxy S7 edge and S7. Using a proprietary process called 3D Thermoforming, we melted 3D glass to curve with such precision that it meets the curved metal alloy to create an exquisitely seamless and strong unibody. The dual-curve backs on the Galaxy S7 edge and S7 are the reason why they feel so comfortable when you hold them. Everything about the design, from the naturally flowing lines to the thin form factor, come together to deliver a grip that's so satisfying, you won't want to let go.",
                "attributes": {
                    "usb_version": "2",
                    "os_version": "6",
                    "max_memory_card_size": "200 GB",
                    "weight": "152 g",
                    "brand": "Samsung",
                    "color": "White"
                },
                "superAttributesDefinition": [
                    "color"
                ],
                "superAttributes": [],
                "attributeMap": {
                    "attribute_variants": [],
                    "super_attributes": [],
                    "product_concrete_ids": [
                        "043_31040074"
                    ]
                },
                "metaTitle": "Samsung Galaxy S7",
                "metaKeywords": "Samsung,Communication Electronics",
                "metaDescription": "Smart Design The beauty of what we've engineered is to give you the slimmest feel in your hand without compromising the big screen size. The elegantly curv",
                "attributeNames": {
                    "usb_version": "USB version",
                    "os_version": "OS version",
                    "max_memory_card_size": "Max memory card size",
                    "weight": "Weight",
                    "brand": "Brand",
                    "color": "Color"
                }
            },
            "links": {
                "self": "http://mysprykershop.com/abstract-products/043"
            }
        },
        {
            "type": "abstract-products",
            "id": "044",
            "attributes": {
                "sku": "044",
                "name": "Samsung Galaxy S7",
                "description": "Smart Design The beauty of what we've engineered is to give you the slimmest feel in your hand without compromising the big screen size. The elegantly curved front and back fit in your palm just right. It's as beautiful to look at as it is to use. We spent a long time perfecting the curves of the Galaxy S7 edge and S7. Using a proprietary process called 3D Thermoforming, we melted 3D glass to curve with such precision that it meets the curved metal alloy to create an exquisitely seamless and strong unibody. The dual-curve backs on the Galaxy S7 edge and S7 are the reason why they feel so comfortable when you hold them. Everything about the design, from the naturally flowing lines to the thin form factor, come together to deliver a grip that's so satisfying, you won't want to let go.",
                "attributes": {
                    "usb_version": "2",
                    "os_version": "6",
                    "max_memory_card_size": "200 GB",
                    "weight": "152 g",
                    "brand": "Samsung",
                    "color": "Black"
                },
                "superAttributesDefinition": [
                    "color"
                ],
                "superAttributes": [],
                "attributeMap": {
                    "attribute_variants": [],
                    "super_attributes": [],
                    "product_concrete_ids": [
                        "044_31040076"
                    ]
                },
                "metaTitle": "Samsung Galaxy S7",
                "metaKeywords": "Samsung,Communication Electronics",
                "metaDescription": "Smart Design The beauty of what we've engineered is to give you the slimmest feel in your hand without compromising the big screen size. The elegantly curv",
                "attributeNames": {
                    "usb_version": "USB version",
                    "os_version": "OS version",
                    "max_memory_card_size": "Max memory card size",
                    "weight": "Weight",
                    "brand": "Brand",
                    "color": "Color"
                }
            },
            "links": {
                "self": "http://mysprykershop.com/abstract-products/044"
            }
        }
    ],
    "links": {
        "self": "http://mysprykershop.com/guest-carts/6a721c99-03d1-5c4d-8f1b-2c33ae57762a/up-selling-products"
    }
}
```
<br>
</details>

See [Retrieving Related Items of an Abstract Product](#related-product-attributes) for the list of response attributes.


## Possible Errors
| Code | Reason |
| --- | --- |
| 400 | Cart ID is missing. <br>Abstract product ID not specified. <br>Cart ID is missing. |
| 404 | A cart with the specified ID was not found. <br>Abstract product not found. |


