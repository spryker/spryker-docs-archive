---
title: CMS Page Drafts and Previews
description: With the CMS draft feature, a Back Office user can create drafts of CMS pages without affecting the current live version of the page.
last_updated: Feb 8, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/v4/docs/page-draft-preview
originalArticleId: 21f417cd-dcfd-4923-b266-70c1388637a2
redirect_from:
  - /v4/docs/page-draft-preview
  - /v4/docs/en/page-draft-preview
---

With the CMS draft feature the Back Office user can create drafts of CMS pages without affecting the current live version of the page. It is possible to preview draft version of content before publishing it to see how the page will look like when it is live. This article will tell you how to enable the preview draft page feature.

## Prerequisites
* Upgrade the `spryker/cms` module to at least 6.2 version. Additional information on how to migrate the `spryker/cms` module can be found in [Migration Guide - CMS](https://docs.spryker.com/docs/scos/dev/module-migration-guides/migration-guide-cms.html).
* If you have the `spryker/cms-collector` module installed, upgrade it to at least 2.0 version. Additional information on how to migrate the `spryker/cms-collector` module can be found in [Migration Guide - CMS Collector](https://docs.spryker.com/docs/scos/dev/module-migration-guides/migration-guide-cms-block-collector.html).
* If you do not have the `spryker/cms-collector` module installed, register your CMS page data expander plugins to the `spryker/cms` module in the `CmsDependencyProvider` dependency provider.

<details open>
<summary markdown='span'>Example of CMS page data expander plugin registration:</summary>
    
```php
<?php
namespace Pyz\Zed\Cms;

use Spryker\Zed\Cms\CmsDependencyProvider as SprykerCmsDependencyProvider;
use Spryker\Zed\CmsContentWidget\Communication\Plugin\CmsPageDataExpander\CmsPageParameterMapExpanderPlugin;

class CmsDependencyProvider extends SprykerCmsDependencyProvider
{
    /**
     * @return \Spryker\Zed\Cms\Dependency\Plugin\CmsPageDataExpanderPluginInterface[]
     */
    protected function getCmsPageDataExpanderPlugins()
    {
        return [
            new CmsPageParameterMapExpanderPlugin(),
        ];
    }
}
```
</details>

* Optionally, upgrade the `spryker/cms-gui` module to at least 4.3 version if you want to have access to the Yves [preview pages from the Back Office](/docs/scos/user/back-office-user-guides/{{page.version}}/content/pages/managing-cms-pages.html#previewing-cms-pages).

## Usage in Yves
1. Create a controller action for preview pages in Yves.
2. Use `CmsClientInterface::getFlattenedLocaleCmsPageData` to retrieve the flattened draft data for a specific locale.

<details open>
<summary markdown='span'>Example of data retrieval:</summary>

```php
<?php
    /**
    * @param int $idCmsPage
    *
    * @return array
    */
    protected function getFlattenedLocaleCmsPageData($idCmsPage)
    {
        $localeCmsPageDataRequestTransfer = $this->getClient()->getFlattenedLocaleCmsPageData(
            (new FlattenedLocaleCmsPageDataRequestTransfer())
                ->setIdCmsPage($idCmsPage)
                ->setLocale((new LocaleTransfer())->setLocaleName($this->getLocale()))
        );

        return $localeCmsPageDataRequestTransfer->getFlattenedLocaleCmsPageData();
    }
```
</details>

1. The retrieved CMS data structure should match the Storage's data structure at this point.
2. You can use your original CMS page rendering twig to display the preview version.
3. Check out our [Demoshop](https://github.com/spryker/demoshop) for more detailed examples and ideas regarding the complete Yves integration.

## Configuring Yves Preview Page Access from the Back Office - Optional

1. Define the Yves preview page URI in configuration with a numeric sprintf placeholder which stands for the CMS page id.

<details open>
<summary markdown='span'>Example of preview page URI registration:</summary>

```php
<?php
    config_default.php

    ...
    $config[CmsGuiConstants::CMS_PAGE_PREVIEW_URI] = '/en/cms/preview/%d';
    ...
```
</details>

1. Optionally add the **Preview** button group item to the "List of CMS pages" in the Back Office by registering the `CmsPageTableExpanderPlugin` plugin to access the preview page.

<details open>
<summary markdown='span'>Example of page table expander plugin registration:</summary>

```php
<?php
namespace Pyz\Zed\CmsGui;

use Spryker\Zed\CmsGui\CmsGuiDependencyProvider as SprykerCmsGuiDependencyProvider;
use Spryker\Zed\CmsGui\Communication\Plugin\CmsPageTableExpanderPlugin;

class CmsGuiDependencyProvider extends SprykerCmsGuiDependencyProvider
{
    /**
     * @return \Spryker\Zed\CmsGui\Dependency\Plugin\CmsPageTableExpanderPluginInterface[]
     */
   protected function getCmsPageTableExpanderPlugins()
   {
       return [
         new CmsPageTableExpanderPlugin(),
       ];
    }
}
```
</details>

1. Optionally add the **Preview** action button to the **Edit Placeholders** in the Back Office by registering the `CreateGlossaryExpanderPlugin` plugin to access the preview page.

<details open>
<summary markdown='span'>Example of glossary expander plugin registration:</summary>

```php
<?php
namespace Pyz\Zed\CmsGui;

use Spryker\Zed\CmsGui\CmsGuiDependencyProvider as SprykerCmsGuiDependencyProvider;
use Spryker\Zed\CmsGui\Communication\Plugin\CreateGlossaryExpanderPlugin;

class CmsGuiDependencyProvider extends SprykerCmsGuiDependencyProvider
{
   /**
    * @return \Spryker\Zed\CmsGui\Dependency\Plugin\CreateGlossaryExpanderPluginInterface[]
    */
   protected function getCreateGlossaryExpanderPlugins()
     {
       return [
         new CreateGlossaryExpanderPlugin(),
       ];
     }
}
```
</details>

## Restricting Access to Preview Page
You can restrict customer access to the preview page by installing and configuring `spryker/customer-user-connector` module.

<!-- Last review date: Sep 22, 2017 -->
