---
title: Managing CMS blocks
description: The guide provides procedures on how to view, update, activate and deactivate CMS blocks in the editor from the Back Office.
last_updated: Jun 18, 2021
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/managing-cms-blocks
originalArticleId: 797e2d78-86eb-454d-afa1-481ee80ae7af
redirect_from:
  - /2021080/docs/managing-cms-blocks
  - /2021080/docs/en/managing-cms-blocks
  - /docs/managing-cms-blocks
  - /docs/en/managing-cms-blocks
related:
  - title: CMS Block
    link: docs/scos/user/features/page.version/cms-feature-overview/cms-blocks-overview.html
---

This topic describes how to manage CMS blocks.

{% info_block infoBox "Info" %}

If you want to manage a CMS block for [email](/docs/scos/user/features/{{page.version}}/cms-feature-overview/email-as-a-cms-block-overview.html), see [Managing content of emails via CMS blocks](/docs/scos/user/back-office-user-guides/{{page.version}}/content/blocks/managing-content-of-emails-via-cms-blocks.html).

{% endinfo_block %}

## Prerequisites

To start managing CMS blocks, go to **Content Management** > **Blocks**.

Each section contains reference information. Make sure to review it before you start, or look up the necessary information as you go through the process.

## Viewing CMS blocks

To view a block:
1. On the *Overview of CMS Blocks* page, click **View Block** in the _Actions_ column.
2. On the *View CMS Block: [Block ID]* page that opens, the following information is available:
    * General information
    * Placeholders

**Tips and tricks**
<br>On the *View CMS Block: [Block ID]* page, you can do the following:
* Edit a block's general information and layout by clicking **Edit block** in the top right corner of the page.
* Edit a block's content and insert CMS widgets by clicking **Edit placeholders** in the top right corner of the page.
* Make a CMS block invisible on the store website by clicking **Deactivate** in the top right corner of the page.
* Make a CMS block visible on the store website by clicking **Activate** in the top right corner of the page.
* Return to the list of CMS blocks by clicking **Back to list** in the top right corner of the page.

### Reference information: Viewing CMS blocks

The following table describes the attributes you see when viewing a CMS block.

| ATTRIBUTE | DESCRIPTION: REGULAR CMS BLOCK | DESCRIPTION: EMAIL CMS BLOCK |
| --- | --- | --- |
| General information | Section provides details regarding the locales for which the block is available, its current status, block template, and time period during which it is visible on the Storefront. | *Template* defines the layout of the Email CMS Block. The rest is irrelevant.  |
| Placeholders | Section shows the translation of the block title and content per locale. | Displays the content of placeholders for each locale. |
| Category list  | Section contains a list of category pages on which the block appears. | Irrelevant. |
| Product lists | Section contains a list of product detail pages on which the block appears. | Irrelevant. |

## Editing placeholders

To edit a placeholder:
1. On the *Overview of CMS Blocks* page in the _Actions_ column, click *Edit Placeholder* next to the block you want to update.
2. On the *Edit Block Glossary: [Block ID]* page, you can update a title or content of the CMS block, as well as insert a content item widget. For more details, see [Adding content item widgets to a block](/docs/scos/user/back-office-user-guides/{{page.version}}/content/content-items/adding-content-items-to-cms-pages-and-blocks.html#adding-content-item-widgets-to-blocks).
3. To save the updates, click **Save**. The updated block is displayed on the grid of *List of CMS Blocks*.

**Tips and tricks**
<br>On the *Edit Block Glossary: [Block ID]* page, you can do the following:
* Edit a block general information and layout by clicking **Edit block** in the top right corner of the page.
* Make a CMS block invisible on the store website by clicking **Deactivate** in the top right corner of the page.
* Make a CMS block visible on the store website by clicking **Activate** in the top right corner of the page.
* Return to the list of CMS blocks by clicking **Back to list** in the top right corner of the page.

## Editing blocks

To edit a CMS block:
1. On the *Overview of CMS Blocks* page in the _Actions_ column, click **Edit Block** next to the block you want to update.
2. On the *Edit CMS Block: [Block ID]* page that opens, you can perform the following actions on the CMS block:
    * Specify a locale where the store will be available.
    * Select a template of the block.
    * Change the block name.
    * Define the validity period for your block to be visible on the Storefront.


**Tips and tricks**
<br>On the *Edit CMS Block: [Block ID]* page, you can do the following:
* Return to the page where you can edit block title and content. For this, click **Edit placeholders** in the top right corner of the page.
* Make the CMS block invisible on the store website by clicking **Deactivate** in the top right corner of the page.
* Make the CMS block visible on the store website by clicking **Activate** in the top right corner of the page.
* Return to a list of CMS blocks. To do this, click **Back to list**.

### Reference information: Editing blocks

The following table describes the attributes on the *Edit CMS Block: [Block ID]* page.

|ATTRIBUTE  | DESCRIPTION: REGULAR CMS BLOCK | DESCRIPTION: EMAIL CMS BLOCK |
| --- | --- | --- |
| Store relation |  Store locale for which the block is available. | Irrelevant. |
| Template | Defines the layout of the CMS Block. | Defines the layout of the Email CMS Block.
| Name | Name of the block. | Name of the block. Should correspond to the name defined in the email template the block is assigned to. |
| Valid from and Valid to | Dates that specify how long your active block is visible on the Storefront. | Irrelevant. |
| Categories: top | Block or blocks assigned to a category page.  The block is displayed at the top of the page. | Irrelevant. |
| Categories: middle |  Block or blocks assigned to a category page. The block is displayed in the middle of the page. | Irrelevant. |
| Categories: bottom | Block or blocks assigned to a category page. The block is displayed at the bottom of the page. | Irrelevant. |
| Products | Block or blocks assigned to a product details page. | Irrelevant. |


## Activating or deactivating a CMS block

You can make a CMS block either active (visible on the store website) or inactive (invisible on the store website).

To activate a CMS block:
1. On the *Overview of CMS Blocks* page in the _Actions_ column, click **Activate** next to the block you want to update.
2. The status will be changed from _Inactive_ to _Active_. The CMS block with the updated status will appear on the grid of CMS blocks.

To deactivate a CMS block:
1. On the *Overview of CMS Blocks* page in the _Actions_ column, click **Deactivate** next to the block you want to update.
2. The status is changed from _Active_ to _Inactive_ and the block is removed from the store website. The CMS block with the updated status appears on the grid of CMS blocks.
