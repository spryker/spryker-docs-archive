---
title: Adding translations for Yves
description: Textual translations are handled by the Glossary-module. You can use the GlossaryFacade in Zed to add entries to Glossary (or you can use the Zed UI).
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/frontend-translations
originalArticleId: 55a7c265-b42c-4faf-a1d5-2be8e3b3d13f
redirect_from:
  - /2021080/docs/frontend-translations
  - /2021080/docs/en/frontend-translations
  - /docs/frontend-translations
  - /docs/en/frontend-translations
  - /v6/docs/frontend-translations
  - /v6/docs/en/frontend-translations
  - /v5/docs/frontend-translations
  - /v5/docs/en/frontend-translations
  - /v4/docs/frontend-translations
  - /v4/docs/en/frontend-translations
  - /v3/docs/frontend-translations
  - /v3/docs/en/frontend-translations
  - /v2/docs/frontend-translations
  - /v2/docs/en/frontend-translations
  - /v1/docs/frontend-translations
  - /v1/docs/en/frontend-translations
---

Textual translations are handled by the Glossary-module. You can use the GlossaryFacade in Zed to add entries to Glossary (or you can use the Zed UI).

```php
<?php
class GlossaryFacade extends AbstractFacade
{
    public function createTranslation($keyName, LocaleTransfer $locale, $value, $isActive = true){ ... }
 
    // there are several other methods in this facade
}
```

An entry in the glossary has a key and translations per locale, like this:

```php
<?php
['say.hello' => [
    'de_DE => 'Hallo', 
    'en_US' => 'Hello']
]
```

Before it can be used in Yves, this data must be exported to the KV-storage. You can use the [Redis Desktop Manager](http://redisdesktop.com/) to have a look inside and see the values.
![Glossary KV and DB](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Yves/Frontend+Translations/glossary-kv-and-db.png) 

## Usage in Twig templates

The translation function is provided by [Symfony translation component](http://symfony.com/doc/current/book/translation.html).

### Simple translation

You can use the key in a Twig template in Yves:

```php
{% raw %}{{{% endraw %} 'say.hello' | trans {% raw %}}}{% endraw %}
```

Sometimes you need to list all keys which are used in a template. Currently there is no good solution, but this regex will do the job pretty good:

```php
{% raw %}{{{% endraw %}.?"(.*)".?\|.?trans.?{% raw %}}}{% endraw %}
```

### Translation with placeholders

When you have a dynamic part in the translation, you can use placeholders.

**Entry in glossary**:

| Key       | Value               |
| --------- | ------------------- |
| “my.name” | “My name is %name%” |

Now replace it with a value in the Twig template:

```php
{% raw %}{{{% endraw %} "auth.my.name" | trans({'%name%' : 'Fabian'}, "app") {% raw %}}}{% endraw %}
```

This will show “My name is Fabian”

## Translation with ajax requests

To use an AJAX request, you need to send translated content directly from the controller. In Yves you can locate the translator and use it directly:

```php
<?php

public function ajaxAction()
{
    $app = $this->getLocator()->application()->pluginPimple()->getApplication();   
    $text = $app->trans('what.ever');
    return $this->jsonResponse['text' => $text];
}
```
