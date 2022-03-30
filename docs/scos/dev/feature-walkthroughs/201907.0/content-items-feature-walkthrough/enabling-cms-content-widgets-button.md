---
title: Enabling the CMS content widgets button in the WYSIWYG Editor
description: Use the guide to enable the CMS content widgets button in the WYSIWYG Editor
last_updated: Nov 9, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/ht-enable-cms-content-widgets-button-201907
originalArticleId: ff4905b1-51f0-4d36-bf4c-d0c78c26fb9e
redirect_from:
  - /v3/docs/ht-enable-cms-content-widgets-button-201907
  - /v3/docs/en/ht-enable-cms-content-widgets-button-201907
---

The article describes how to enable the CMS content widgets button in the WYSIWYG editor on the **Edit Placeholders** page.

The content widget drop-down button is used to add CMS content widgets to a block or a page. However, starting with the **201907.0** version, the content widget drop-down button has been disabled in the WYSIWYG editor.

If you want to enable this button on a project level, do the following:

1. Create the `src/Pyz/Zed/CmsContentWidget/CmsContentWidgetConfig.php` file.
2. Insert the following code in that file:

```php
<?php
namespace Pyz\Zed\CmsContentWidget;

use Spryker\Zed\CmsContentWidget\CmsContentWidgetConfig as SprykerCmsContentConfig;

class CmsContentWidgetConfig extends SprykerCmsContentConfig
{
	        /**
	        * @return bool
	        */
	        public function isEditorButtonEnabled(): bool
	        {
		                    return true;
	        }
    }
```

After the updates have been saved, the content widget drop-down button will be enabled and displayed next to the Content Item drop-down button in the WYSIWYG editor:

![Both menus in the WYSIWYG editor](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Feature+HowTos/HowTo+-+Enable+CMS+Content+Widgets+Button/both-widgets-menu.png)

<!-- Last review date: Jul 22, 2019 by Yuliia Boiko-->
