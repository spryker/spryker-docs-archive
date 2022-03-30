---
title: Retrieving category nodes
description: Retrieve information about category nodes.
last_updated: Jun 16, 2021
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/retrieving-category-nodes
originalArticleId: 1e544fa3-90d1-449f-8d32-54a18f9b2631
redirect_from:
  - /2021080/docs/retrieving-category-nodes
  - /2021080/docs/en/retrieving-category-nodes
  - /docs/retrieving-category-nodes
  - /docs/en/retrieving-category-nodes
related:
  - title: Category Management feature overview
    link: docs/scos/user/features/page.version/category-management-feature-overview.html
---

This endpoint allows retrieving category nodes.

## Installation

For detailed information on the modules that provide the API functionality and related installation instructions, see [Category API Feature Integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/category-management-feature-integration.html).

## Retrieve a category node

To retrieve a category node, send the request:

---
`GET` **/category-nodes/*{% raw %}{{{% endraw %}node_id{% raw %}}}{% endraw %}***

---

|PATH PARAMETER | DESCRIPTION |
|---|---|
| ***node_id*** | ID of a node to get information for. [Retrieve a category tree](/docs/scos/dev/glue-api-guides/{{page.version}}/retrieving-categories/retrieving-category-trees.html#retrieve-a-category-tree) to get a full list of node IDs. |

### Request

Request sample : `GET http://glue.mysprykershop.com/category-nodes/5`

### Response

<details>
<summary markdown='span'>Response sample</summary>

```js
{
    "data": {
        "type": "category-nodes",
        "id": "5",
        "attributes": {
            "nodeId": 5,
            "name": "Computer",
            "metaTitle": "Computer",
            "metaKeywords": "Computer",
            "metaDescription": "Computer",
            "isActive": true,
            "order": 100,
            "url": "/en/computer",
            "children": [
                {
                    "nodeId": 6,
                    "name": "Notebooks",
                    "metaTitle": "Notebooks",
                    "metaKeywords": "Notebooks",
                    "metaDescription": "Notebooks",
                    "isActive": true,
                    "order": 100,
                    "url": "/en/computer/notebooks",
                    "children": [],
                    "parents": []
                },
                {
                    "nodeId": 7,
                    "name": "Pc's/Workstations",
                    "metaTitle": "Pc's/Workstations",
                    "metaKeywords": "Pc's/Workstations",
                    "metaDescription": "Pc's/Workstations",
                    "isActive": true,
                    "order": 90,
                    "url": "/en/computer/pc's/workstations",
                    "children": [],
                    "parents": []
                },
                {
                    "nodeId": 8,
                    "name": "Tablets",
                    "metaTitle": "Tablets",
                    "metaKeywords": "Tablets",
                    "metaDescription": "Tablets",
                    "isActive": true,
                    "order": 80,
                    "url": "/en/computer/tablets",
                    "children": [],
                    "parents": []
                }
            ],
            "parents": [
                {
                    "nodeId": 1,
                    "name": "Demoshop",
                    "metaTitle": "Demoshop",
                    "metaKeywords": "English version of Demoshop",
                    "metaDescription": "English version of Demoshop",
                    "isActive": true,
                    "order": null,
                    "url": "/en",
                    "children": [],
                    "parents": []
                }
            ]
        },
        "links": {
            "self": "http://glue.mysprykershop.com/category-nodes/5"
        }
    }
}
```
</details>

<a name="category-nodes-response-attributes"></a>

| ATTRIBUTE | TYPE | DESCRIPTION |
| --- | --- | --- |
| nodeId | String | Category node ID. |
| name | String | Name of category associated with the node. |
| metaTitle | String | Meta title of the category. |
| metaKeywords | String | Meta keywords of the category. |
| metaDescription | String | Meta description of the category. |
| isActive | Boolean | Boolean to see, if the category is active. |
| order | Integer | Digits between 1 and 100, with 100 ranking the highest (on one level under the parent node). |

## Possible errors

| CODE | REASON |
| --- | --- |
| 701 | Node ID not specified or invalid. |
| 703 | Node with the specified ID was not found. |

To view generic errors that originate from the Glue Application, see [Reference information: GlueApplication errors](/docs/scos/dev/glue-api-guides/{{page.version}}/reference-information-glueapplication-errors.html).
