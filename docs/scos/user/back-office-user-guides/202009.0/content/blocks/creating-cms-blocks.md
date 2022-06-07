---
title: Creating CMS blocks
search: exclude
description: The guide provides instructions on how to create a CMS block in the Back Office.
last_updated: Jun 16, 2021
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v6/docs/creating-cms-block
originalArticleId: 59a590b2-fe13-4a95-b8a7-9783b9fd04c5
redirect_from:
  - /v6/docs/creating-cms-block
  - /v6/docs/en/creating-cms-block
related:
  - title: Managing CMS Blocks
    link: docs/scos/user/back-office-user-guides/page.version/content/blocks/managing-cms-blocks.html
---

This topic describes how to create a CMS block.

{% info_block infoBox "Info" %}

If you want to create a CMS block for [email](/docs/scos/user/features/{{page.version}}/cms-feature-overview/email-as-a-cms-block-overview.html), see [Creating an email CMS block](/docs/scos/user/back-office-user-guides/{{page.version}}/content/blocks/managing-content-of-emails-via-cms-blocks.html#creating-an-email-cms-block).

{% endinfo_block %}

---

## Prerequisites

To start working with CMS blocks, go to **Content** > **Blocks**.

Review the reference information before you start, or look up the necessary information as you go through the process.

## Creating a CMS block

To create a CMS block:

1. On the *Overview of CMS Blocks* page,  click  **Create block** in the top right corner.
2. On the *Create CMS Block* page, enter the block details:

* Store relation
* Template
* Name
* Valid from and Valid to

{% info_block warningBox %}
**Store relation**, **Template**, and **Name** must be filled in. All other fields are optional.
{% endinfo_block %}

{% info_block infoBox %}
Templates are project-specific and are usually created by a developer and a business person. If you are missing a CMS Block template, contact them and refer to the [HowTo - Create CMS block templates](/docs/scos/dev/tutorials-and-howtos/202009.0/howtos/feature-howtos/cms/howto-create-cms-templates.html#cms-block-template).
{% endinfo_block %}

3. To save the changes, click **Save**. This will successfully create a block and take you to the *Edit Block Glossary* page.


### Reference information: Creating a CMS block

The following table describes the attributes on the *Overview of CMS Blocks* page.

| ATTRIBUTE | DESCRIPTION: REGULAR CMS BLOCK | DESCRIPTION:  EMAIL CMS BLOCK |
| --- | --- | --- |
| Block Id | Sequence number. | Sequence number. |
| Name | Name of a CMS block. | Name of a CMS block. <br> This name is used by developers to assign the block to its [.twig email template](/docs/scos/user/features/{{page.version}}/cms-feature-overview/email-as-a-cms-block-overview.html).
| Template | Defines a placeholder structure of the CMS block. | Defines the placeholder structure of the Email CMS block. |
| Status | Block status that can be active (visible in the online store) or inactive (invisible in the online store). | Irrelevant. |
| Stores | Locale(s) for which the block will be visible on the store website. | Irrelevant. |
| Actions | Set of actions that can be performed on a CMS block. | Set of actions that can be performed on an Email CMS block. |

On this page, you can also:

* Switch to the page where you can create a new CMS block.
* Sort blocks by *Block Id*, *Name*, *Template*, and *Status*.
* Filter content items by *Block Id*, *Name*, and *Template*.

The following table describes the attributes on the *Create CMS Block* page.

|ATTRIBUTE  | DESCRIPTION: REGULAR CMS BLOCK | DESCRIPTION: EMAIL CMS BLOCK |
| --- | --- | --- |
| Store relation |  Store locale for which the block will be available. | Irrelevant. |
| Template | Defines the layout of the CMS Block. | Defines the layout of the Email CMS Block.
| Name | Name of the block. | Name of the block. Should correspond to the name defined in the email template the block is assigned to. |
| Valid from and Valid to | Dates that specify how long your active block will be visible in the online store. | Irrelevant. |
| Categories: top | Block or blocks assigned to a category page.  The block will be displayed at the top of the page. | Irrelevant. |
| Categories: middle |  Block or blocks assigned to a category page. The block will be displayed in the middle of the page. | Irrelevant. |
| Categories: bottom | Block or blocks assigned to a category page. The block will appear at the bottom of the page. | Irrelevant. |
| Products | A block or blocks assigned to a product details page. | Irrelevant. |

---

**What's next?**

After a new block has been created, you can add the content if needed.

* To learn more about editing a CMS block, see the [Editing CMS blocks](/docs/scos/user/back-office-user-guides/{{page.version}}/content/blocks/managing-cms-blocks.html#editing-blocks).
