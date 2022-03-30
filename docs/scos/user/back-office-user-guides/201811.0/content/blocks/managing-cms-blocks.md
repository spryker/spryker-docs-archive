---
title: Managing CMS Blocks
description: The guide provides procedures on how to view, update, activate and deactivate CMS blocks in the editor from the Back Office.
last_updated: May 19, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v1/docs/managing-cms-blocks
originalArticleId: 25d10977-c448-4fe3-8d75-22e813443e9d
redirect_from:
  - /v1/docs/managing-cms-blocks
  - /v1/docs/en/managing-cms-blocks
related:
  - title: CMS Block
    link: docs/scos/user/features/page.version/cms-feature-overview/cms-blocks-overview.html
  - title: Creating CMS Blocks
    link: docs/scos/user/back-office-user-guides/page.version/content/blocks/creating-cms-blocks.html
  - title: Assigning Blocks to Category and Product Pages
    link: docs/scos/user/back-office-user-guides/page.version/content/pages/assigning-blocks-to-category-and-product-pages.html
---

This topic describes the procedures of managing CMS blocks.
***

To start managing CMS blocks, navigate to the **Content Management** > **Blocks** section.
***

You can view, edit, and activate or deactivate (depending on the current status) blocks by clicking respective buttons in the _Actions_ column in the list of CMS blocks.
***

## Viewing CMS Blocks

To view a block:

1. On the **Overview of CMS Blocks** page, click **View Block** in the _Actions_ column. 
2. On the **View CMS Block: Block ID** page that opens, the following information is available:

   * General information
   * Placeholders
   * Category and Product lists 

See [CMS Block: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/content-management/blocks/references/cms-block-reference-information.html)  to learn more about attributes on this page.

{% info_block warningBox "Note" %}

When the lists are empty, this block is not assigned to any category or product page.

{% endinfo_block %}

***

**Tips and tricks**

On the **View CMS Block: Block ID** page, you can do the following:

* Edit a block general information and layout by clicking **Edit block** in the top right corner of the page.
* Edit block content and insert CMS widgets by clicking **Edit placeholders** in the top right corner of the page.
* Make a CMS block invisible on the store website by clicking **Deactivate** in the top right corner of the page.
* Make a CMS block visible on the store website by clicking **Activate** in the top right corner of the page. 
* Return to the list of CMS blocks by clicking **Back to list** in the top right corner of the page.
***

## Editing Placeholders

To edit a placeholder:
1. On the **Overview of CMS Blocks** page in the _Actions_ column, click **Edit Placeholder** next to the block you want to update. 
2. On the **Edit Block Glossary: Block ID** page that opens, you can update a title or content of the CMS block.
3. To save the updates, click **Save**. The updated block will be displayed on the grid of List of CMS Blocks.
***

**Tips and tricks**

On the **Edit Block Glossary: Block ID** page, you can do the following:

* Edit a block general information and layout by clicking **Edit block** in the top right corner of the page.
* Make a CMS block invisible on the store website by clicking **Deactivate** in the top right corner of the page.
* Make a CMS block visible on the store website by clicking **Activate** in the top right corner of the page. 
* Return to the list of CMS blocks by clicking **Back to list** in the top right corner of the page.

***

## Editing Blocks

To edit a CMS block:
1. On the **Overview of CMS Blocks** page in the _Actions_ column, click **Edit Block** next to the block you want to update. 
2. On the **Edit CMS Block: Block ID** page that opens, you can perform the following actions on the CMS block:

   * Specify a locale where the store will be available.
   * Select a template of the block.
   * Change the block name.
   * Define the validity range for your block to be visible in the online store.
   * Assign a block to a category or a product detail page.

{% info_block infoBox %}

See  [CMS Blocks: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/content-management/blocks/references/cms-block-reference-information.html) for more details.

{% endinfo_block %} 

***

**Tips and tricks**

On the **Edit CMS Block: Block ID** page, you can do the following:

* Return to the page where you can edit block title and content. For this, click **Edit placeholders** in the top right corner of the page.
* Make the CMS block invisible on the store website by clicking **Deactivate** in the top right corner of the page.
* Make the CMS block visible on the store website by clicking **Activate** in the top right corner of the page. 
* Return to a list of CMS blocks. To do this, click **Back to list**.

***

## Activating or Deactivating a CMS Block

You can make a CMS block either active (visible on the store website) or inactive (invisible on the store website).

To activate a CMS block:
1. On the **Overview of CMS Blocks** page in the _Actions_ column, click **Activate** next to the block you want to update. 
2. The status will be changed from _Inactive_ to _Active_. The CMS block with the updated status will appear on the grid of CMS blocks.

To deactivate a CMS block:
1. On the **Overview of CMS Blocks** page in the _Actions_ column, click **Deactivate** next to the block you want to update. 
2. The status will be changed from _Active_ to _Inactive_ and the block will be removed from the store website. The CMS block with the updated status will appear on the grid of CMS blocks.

***

**What's next?**

* To learn how to set the time period during which CMS blocks will be visible on the store website, see [Defining Validity Period for CMS Blocks](/docs/scos/user/back-office-user-guides/{{page.version}}/content/blocks/defining-validity-period-for-cms-blocks.html).

* To know what attributes you enter and select while editing the CMS block, see [CMS Block: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/content-management/blocks/references/cms-block-reference-information.html).
