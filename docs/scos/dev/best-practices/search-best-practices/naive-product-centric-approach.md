---
title: Naive Product Centric Approach
description: Finding products on e-commerce website can be tricky, even when you know exactly what you are looking for.
last_updated: Jun 16, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/naive-product-centric-approach
originalArticleId: 6deab3d9-ab71-44b4-a5cb-04759206e12b
redirect_from:
  - /2021080/docs/naive-product-centric-approach
  - /2021080/docs/en/naive-product-centric-approach
  - /docs/naive-product-centric-approach
  - /docs/en/naive-product-centric-approach
  - /v6/docs/naive-product-centric-approach
  - /v6/docs/en/naive-product-centric-approach  
  - /v5/docs/naive-product-centric-approach
  - /v5/docs/en/naive-product-centric-approach  
  - /v4/docs/naive-product-centric-approach
  - /v4/docs/en/naive-product-centric-approach  
  - /v3/docs/naive-product-centric-approach
  - /v3/docs/en/naive-product-centric-approach  
  - /v2/docs/naive-product-centric-approach
  - /v2/docs/en/naive-product-centric-approach  
  - /v1/docs/naive-product-centric-approach
  - /v1/docs/en/naive-product-centric-approach
---

Finding products on e-commerce website can be tricky, even when you know exactly what you are looking for. Throughout this document, we will assume a customer wants to buy a hammer that weighs 2kg. A product that would meet his needs might be this “Fäustel” by Fortis:
![Product-centric approach](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Search+Engine/Naive+Product+Centric+Approach/product-detail.png) 

This is (most of) the search-relevant information that is known in the backend of Contorion about the product above:

```php
{
  "name": "Fäustel DIN6475 2000g Eschenstiel FORTIS",
  "staple-name": "Fortis Fäustel, mit Eschen-Stiel",
  "description": "Fäustel DIN 6475<br><br>Stahlgeschmiedet, Kopf schwarz lackiert, Bahnen poliert, doppelt geschweifter Eschenstiel mit ozeanblau lackiertem Handende. SP11968 SP11968",
  "preview_image": "faeustel-din6475-2000g-eschenstiel-fortis-21049292-0-JlHR5nOi-l.jpg",
  "categories": [
    "Fäustel",
    "Handwerkzeug",
    "Hammer",
    "Fäustel"
  ],
  "final_gross_price": 1149,
  "final_net_price": 1003,
  "url": "/handwerkzeug/fortis-faeustel-mit-eschen-stiel-SP11968",
  "manufacturer": "Fortis",
  "hammer_weight": 2000
}
```

Many tutorials recommend storing such documents “as is” into Elasticsearch, and the ease of doing so is indeed one of the core strengths of the platform. However, this approach has at least three quite serious drawbacks:

1. Elasticsearch queries need to “know” and explicitly list all the attributes that they want to use. For example a full-text search query would need to list all relevant text fields, a faceted search would need to list all possible filters.
2. Different usages of the same attribute require different handling, e.g. the category name “Hammer” needs to be indexed unaltered for filtering and completion, but fully analyzed for full-text search purpose.
3. The existence of “semantic” fields such as hammer_weight makes it hard to extend the product catalog: Whenever new product attributes are created, the Elasticsearch mapping needs to be extended.

The result is a huge complexity in query generation and schema management and this typically leads to situations where the full potential of available data is not used: full text search will operate only on some fields, and faceted navigation on others etc.
