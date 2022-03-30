---
title: HowTo - Create CMS Templates
description: Use the guide to create a template for a CMS page, CMS Block, Content Item Widget.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/ht-create-cms-templates
originalArticleId: 6f52ee42-6c1a-4d0b-865b-3512b7f4b9aa
redirect_from:
  - /2021080/docs/ht-create-cms-templates
  - /2021080/docs/en/ht-create-cms-templates
  - /docs/ht-create-cms-templates
  - /docs/en/ht-create-cms-templates
related:
  - title: CMS Page
    link: docs/scos/user/features/page.version/cms-feature-overview/cms-pages-overview.html
  - title: CMS Block
    link: docs/scos/user/features/page.version/cms-feature-overview/cms-blocks-overview.html
---

This document describes how to create CMS templates for Yves.

{% info_block infoBox %}
CMS templates are usually project specific. To create them, some Storefront design work needs to be done, usually in collaboration between a business person and a frontend project developer.
{% endinfo_block %}

## CMS Page Template

CMS page template is a [Twig](https://twig.symfony.com/) file that, when applied to a Storefront page, defines its design and layout.
To learn how the template is created, check the exemplary procedure below.
***
1. Create the Twig template - `src/Pyz/Shared/Cms/Theme/default/templates/contact_page.twig`:

```html
<h1>CONTACT US </h1>
<div>
<strong>  Get in touch </strong>
<br>
<strong>Phone number : </strong> +1 (000) 000-0000
<br>
<strong>Email : </strong> info@companyname.com
        <br><br>
        <strong> Visit our store </strong><br>
        123 Demo Street<br>
        Demo City<br>
        1234<br>
        <br>
    </div>
```

2. Define placeholders for translation:

```twig
<!-- CMS_PLACEHOLDER : "PlaceholderContactPageHeader" -->
    <!-- CMS_PLACEHOLDER : "PlaceholderContactHeader" -->
    <!-- CMS_PLACEHOLDER : "PlaceholderPhoneNr" -->
    <!-- CMS_PLACEHOLDER : "PlaceholderEmail" -->
    <!-- CMS_PLACEHOLDER : "PlaceholderStoreAddress" -->

 <h1>{% raw %}{{{% endraw %} spyCms('PlaceholderContactPageHeader') {% raw %}}}{% endraw %} </h1>
    <div>
        <strong>{% raw %}{{{% endraw %} spyCms('PlaceholderContactHeader') {% raw %}}}{% endraw %} </strong> <br>
        <strong>{% raw %}{{{% endraw %} spyCms('PlaceholderPhoneNr') {% raw %}}}{% endraw %} </strong> +1 (000) 000-0000 <br>
        <strong>{% raw %}{{{% endraw %} spyCms('PlaceholderEmail') {% raw %}}}{% endraw %}  </strong> info@companyname.com <br>
        <strong>{% raw %}{{{% endraw %} spyCms('PlaceholderStoreAddress') {% raw %}}}{% endraw %}  
        </strong><br>

        123 Demo Street<br>
        Demo City<br>
        1234<br>
    </div>
```

The text in the defined placeholders will be replaced at runtime by the glossary keys assigned to them.

A content manager can apply this template when [creating a CMS page](/docs/scos/user/back-office-user-guides/{{site.version}}/content/pages/creating-cms-pages.html) in the Back Office.

## Template with Slots

[Template with slots](/docs/scos/user/features/{{site.version}}/cms-feature-overview/templates-and-slots-overview.html) is a Twig file that defines the layout of slots across a Storefront page and has at least one slot assigned.

***
**Create a template with slots:**

1. Create a Twig template as described in [CMS Page Template](#cms-page-template).

2. For each slot that you want to have in the template, insert a [slot widget](/docs/scos/user/features/{{site.version}}/cms-feature-overview/templates-and-slots-overview.html#slot-widget).

3. [Import](/docs/scos/dev/data-import/{{site.version}}/data-importers-overview-and-implementation.html) template and slot lists. Learn about the lists in the [Correlation](/docs/scos/user/features/{{site.version}}/cms-feature-overview/templates-and-slots-overview.html#correlation) section of **Templates & Slots Feature Overview**.

Templates with slots are universal. In the Back Office, a content manager can:

* apply this template when [creating a CMS page](/docs/scos/user/back-office-user-guides/{{site.version}}/content/pages/creating-cms-pages.html).
* apply this template when [creating a category](/docs/scos/user/back-office-user-guides/{{site.version}}/catalog/category/creating-categories.html).

{% info_block warningBox %}

You can assign the template with slots to other page types only on a code level.

{% endinfo_block %}

## CMS Block Template

CMS block template is a Twig file that, when applied to a [CMS block](/docs/scos/user/features/{{site.version}}/cms-feature-overview/cms-blocks-overview.html), defines its design and layout.

Create the Twig template - `src/Pyz/Shared/CmsBlock/Theme/default/template//hello.twig`.

```twig
<!-- CMS_BLOCK_PLACEHOLDER : "helloBlockText" -->
<div class="cms-block">
	<h1>Hello World!</h1>
	<p>{% raw %}{{{% endraw %} spyCmsBlockPlaceholder('helloBlockText') | raw {% raw %}}}{% endraw %}</p>
</div>
```

A content manager can apply this template when [creating a CMS block](/docs/scos/user/back-office-user-guides/{{site.version}}/content/blocks/creating-cms-blocks.html) in the Back Office.

## Content Item Widget Template

[Content item widget](/docs/scos/user/features/{{site.version}}/content-items-feature-overview.html) template is a Twig file that defines the layout of the content item it renders on Storefront.

By default, two content item widget templates are shipped per each content item:

* Banner widget
* Abstract Product List widget
* Product Set widget
* File widget

***

**Create a content item widget template:**

{% info_block infoBox %}

Depending on the content item widget you create the template for, make sure to install the respective Content Item Widget module:

* [ContentBannerWidget](https://github.com/spryker-shop/content-banner-widget)
* [ContentProductWidget](https://github.com/spryker-shop/content-product-widget)
* [ContentProductSetWidget](https://github.com/spryker-shop/content-product-set-widget)
* [ContentFileWidget](https://github.com/spryker-shop/content-file-widget)


{% endinfo_block %}

1. Create `src/Pyz/Yves/{ModuleWidget}/Theme/default/views/{template-folder}/{new-template}.twig`, where:

* `{new-template}` - template name.
* `{ModuleWidget}` - name of the respective Content Item Widget module.
* `{template-folder}` - template folder name. Based on the content item widget, choose:
    * banner;
    * cms-product-abstract;
    * content-product-set;
    * content-file.

The default templates located on the core level of each module can be used as examples.

2. Modify the template configuration in `Pyz/Yves/{ModuleWidget}/Twig/{ModuleWidgetTwigFunction}.php`:
* Add the template identifier.
* Based on the template identifier, add a path to the template.
{% info_block infoBox %}

`{ModuleWidgetTwigFunction}.php` should extend from the corresponding file in `SprykerShop/Yves/{ModuleWidget}/Twig/`.

{% endinfo_block %}

Pyz/Yves/{ModuleWidget}/Twig/{ModuleWidgetTwigFunction}.php

```php
namespace \Pyz\Yves\{ModuleWidget}\Twig;

class {ModuleWidgetTwigFunction} extends \SprykerShop\Yves\{ModuleWidget}\Twig\{ModuleWidgetTwigFunction}
{
    protected const WIDGET_TEMPLATE_IDENTIFIER_NEW_TEMPLATE = 'new-template';

    /**
    * @return array
    */
    protected function getAvailableTemplates(): array
    {
        return array_merge(parent::getAvailableTemplates(), [
            static::WIDGET_TEMPLATE_IDENTIFIER_NEW_TEMPLATE => '@{ModuleWidget}/views/{template-folder}/{new-template}.twig',
        ]);
    }
}
```

3. Override the method in the factory that creates the object of `{ModuleWidgetTwigFunction}`:

Pyz/Yves/{ModuleWidget}/{ModuleWidget}Factory.php

```php
namespace \Pyz\Yves\{ModuleWidget};

use \Pyz\Yves\{ModuleWidget}\Twig\{ModuleWidgetTwigFunction};

class {ModuleWidget}Factory extends \SprykerShop\Yves\{ModuleWidget}\{ModuleWidget}Factory
{
    /**
    * @param \Twig\Environment $twig
    * @param string $localeName
    *
    * @return \Pyz\Yves\{ModuleWidget}\Twig\{ModuleWidgetTwigFunction}
    */
    public function createContentBannerTwigFunction(Environment $twig, string $localeName): \SprykerShop\Yves\{ModuleWidget}\Twig\{ModuleWidgetTwigFunction}
    {
        return new {ModuleWidgetTwigFunction}(
            $twig,
            $localeName,
            $this->getContentBannerClient()
        );
    }
}
```
