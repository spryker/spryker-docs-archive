---
title: Tutorial - Using Translations
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/t-using-translations
originalArticleId: ff253743-a10f-4866-8047-a6c8357a88a7
redirect_from:
  - /2021080/docs/t-using-translations
  - /2021080/docs/en/t-using-translations
  - /docs/t-using-translations
  - /docs/en/t-using-translations
  - /v6/docs/t-using-translations
  - /v6/docs/en/t-using-translations
  - /v5/docs/t-using-translations
  - /v5/docs/en/t-using-translations
  - /v4/docs/t-using-translations
  - /v4/docs/en/t-using-translations
  - /v3/docs/t-using-translations
  - /v3/docs/en/t-using-translations
  - /v2/docs/t-using-translations
  - /v2/docs/en/t-using-translations
  - /v1/docs/t-using-translations
  - /v1/docs/en/t-using-translations
---

<!--used to be: http://spryker.github.io/tutorials/yves/using-translations/-->
The data stored in the key-value storage can be used for multiple purposes:

* URL mappings
* localized product details
* localized product categories details

## Translations - Using Twig Translator
Twig Translator uses the data that comes from the Redis key-value storage. The glossary keys store static localized text that’s not likely to be subject of a change (for example, caption of a label).

The format of the glossary keys is as follows: `{store}.{locale}.glossary.translation.{glossary_key}`

Example :
* **key** : `demo.de_de.glossary.translation.catalog.next`
* **value** : `weiter`

```php
<div class="catalog__pagination">
    <button class="pagination__button js-pagination-prev">{% raw %}{{{% endraw %} 'catalog.prev' | trans {% raw %}}}{% endraw %}</button>
    <button class="pagination__button js-pagination-next">{% raw %}{{{% endraw %} 'catalog.next' | trans {% raw %}}}{% endraw %}</button>
</div>
```
The example below shows how the Twig Translator can be used:

When the page containing this template is requested, the Twig Translator will replace the text containing the key (for example, `catalog.next`) with the value of the key stored in Redis that corresponds to the current locale (for example, for locale `de_DE`, will replace with the value of the key `demo.de_de.glossary.translation.catalog.next`).
