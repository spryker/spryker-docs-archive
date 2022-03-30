---
title: Personalization- Dynamic Pricing
description: This article describes how to personalize pricing.
last_updated: Jun 16, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/personalization-dymanic-pricing
originalArticleId: 9c018e4a-9a82-49fd-9e46-d6d02332185b
redirect_from:
  - /2021080/docs/personalization-dymanic-pricing
  - /2021080/docs/en/personalization-dymanic-pricing
  - /docs/personalization-dymanic-pricing
  - /docs/en/personalization-dymanic-pricing
  - /v6/docs/personalization-dymanic-pricing
  - /v6/docs/en/personalization-dymanic-pricing  
  - /v5/docs/personalization-dymanic-pricing
  - /v5/docs/en/personalization-dymanic-pricing  
  - /v4/docs/personalization-dymanic-pricing
  - /v4/docs/en/personalization-dymanic-pricing  
  - /v3/docs/personalization-dymanic-pricing
  - /v3/docs/en/personalization-dymanic-pricing  
  - /v2/docs/personalization-dymanic-pricing
  - /v2/docs/en/personalization-dymanic-pricing  
  - /v1/docs/personalization-dymanic-pricing
  - /v1/docs/en/personalization-dymanic-pricing
---

Especially in businesses with a B2B focus, customers expect to get discounts after they have been using the service/website for a longer period of time. The search infrastructure should be able to handle such use cases and customers should be able to see their own discounted prices while browsing the catalog. Luckily, Elasticsearch enables us to extend basic filtering, aggregation and fetching functionalities with scripts that are executed within the document context and can be used instead of fixed document values.

In this example, we have a script with two customer-based parameters: fixed prices (one per product ID) and category discount levels. These parameters are passed to the Elasticsearch query only for logged-in customers with granted discounts.

```php
{
  "query": {
    "script_fields": {
      "final_gross_price_discount": {
        "script": "if (fixed_prices && fixed_prices[doc['sku'].value]) {return fixed_prices[doc['sku'].value]}; if(!discounts) {return}; def discount = 0; for (String i : doc['discount_categories']) {if(discounts[i] && discounts[i].value > discount) {discount = discounts[i].value{% raw %}}}{% endraw %}; if (discount > 0 && doc['prices.discount_gross_price_level_' + discount].value) {return doc['prices.discount_gross_price_level_' + discount].value}",
        "params": {
          "discounts": {
            "47": 5,
            "453": 2,
            "305": 7
          },
          "fixed_prices": {
            "210417044": 9999,
            "128553": 100
          }
        }
      }
    }
  }
}
```

As a result, customers see personalized prices. In a similar way, it’s possible to build filters and price facets based on dynamically calculated prices.
