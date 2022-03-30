---
title: Reference information - content items
description: The guide provides reference information you work with when creating, updating and viewing content items in the Back Office.
last_updated: Jun 16, 2021
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/content-items-reference-information
originalArticleId: 08d45bf8-d0af-496a-a5d8-bfe5da95bbe5
redirect_from:
  - /2021080/docs/content-items-reference-information
  - /2021080/docs/en/content-items-reference-information
  - /docs/content-items-reference-information
  - /docs/en/content-items-reference-information
related:
  - title: Creating Content Items
    link: docs/scos/user/back-office-user-guides/page.version/content/content-items/creating-content-items.html
  - title: Editing Content Items
    link: docs/scos/user/back-office-user-guides/page.version/content/content-items/editing-content-items.html
---

This topic contains the reference information for working with content items in **Content Management** > **Content Items** section.

## Content items page

In the *Content Items* section, you see the following:

| ATTRIBUTE | DESCRIPTION |
| --- | --- |
| **Content Item Key** | A fixed value of the content item indicated in the database. |
|**Name**  | The name of a content item. |
| **Description** |Descriptive information on what a content item is used for.  |
| **Content Type** | The type of a content item. |
| **Created** | The date when a content item was created. |
| **Updated** | The date when a content item was last updated.|
| **Actions** | A set of actions that can be performed on a content item. |

By default, the latest created content item is displayed and sorted by the _Name_ column on the grid of content items.

On this page, you can:
* Create a new content item.
* Sort content items by **Content Item Key**, **Name**, **Content type**, **Created**, and **Updated** dates.
* Filter content items using the search by **Content Item Key**, **Name**, **Description**, **Content type**, **Created**, and **Updated** dates.
* Edit a content item.

## Create and edit banner content item page

The following table describes the attributes on the pages:
* *Create Content Item: Banner*
* *Edit Content Item: Banner*

| ATTRIBUTE | DESCRIPTION |
| --- | --- |
| **Name** | The name of a Banner content item. |
|**Description**  |Descriptive information on what a banner is used for.  |
| **Title** |  The heading of the banner.|
|  **Subtitle**| The text of the banner. |
|**Image URL** |An address where the image element of the Banner content item is stored.  |
| **Click URL** | A URL of the target page to which your shop visitors are redirected. |
| **Alt-text** | Some additional text that describes the image. |

## Create and edit abstract product list content item page

The following table describes the attributes on the pages:
 * *CreateContent Item: Abstract Product List*
 * *Edit Content Item: Abstract Product List*

| ATTRIBUTE | DESCRIPTION |
| --- | --- |
| **Name** | The name for an Abstract Product List content item. |
| **Description** | Descriptive information on what an Abstract Product List is used for. |
| **Top table** |  A table that displays products included in an Abstract Product List content item.|
| **Actions** | A set of actions that can be performed on an Abstract Product List content item:<ul><li>**Move Down** or **Move Up** allows you to change the order of products in the list.</li><li>**Delete** allows removing the product from the list.</li></ul>|
| **Add more products (bottom table)**  | A table that contains all available products stored in the database. |
| **ID** | A sequence number. |
| **SKU** | A unique identifier of the product. |
| **Image** | A product image. |
| **Name** |  A product name.|
| **Stores** | Shows what stores the product can be used in. |
| **Status** |  Shows the status of the product: active or inactive. |
|**Selected** | A column that contains **+ Add to list** you can click to add a product to the top table so that it can be added to the Abstract Product List content item.|

## Create and edit product set content item page

The following table describes the attributes on the pages:
 * *CreateContent Item: Product Set*
 * *Edit Content Item: Product Set*

| ATTRIBUTE | DESCRIPTION |
| --- | --- |
| **Name** | The name for a Product Set content item. |
|  **Description**|Descriptive information on what a Product Set is used for.  |
| **Top table** |A table that displays the selected product set.  |
| **Actions (top table)**| A column that contains **Delete** you can click to remove the product set from the list. |
| **Available Product Sets** |  A bottom table that displays product sets available in the database.|
|**ID**  | A sequence number. |
|  **Name** <br>(in the top table) |A name of the product set. |
| **# of Products** | Displays the number of products available in the product set. |
|**Status**  | Shows the status of the product set: active or inactive. |
|**Actions (bottom table)**  |A column that contains **+ Add** you can click to add a product set to the top table so that it can be added to the Product Set content item. |

## Create and edit file list content item page

The following table describes the attributes on the pages:
 * *CreateContent Item: File List*
 * *Edit Content Item: File List*

| ATTRIBUTE | DESCRIPTION |
| --- | --- |
| **Name** | The name for a File List content item. |
| **Description** | Descriptive information on what a File List content item is used for. |
| **Selected Files** | A top table that displays the selected files. |
| **Actions** | A set of actions you can perform on a File List content item:<ul><li>**Move Down** or **Move Up** allows you to change the order of files in the list. </li><li>**Delete** allows removing the selected file.</li></ul> |
| **Available Files** | A bottom table that displays a list of files uploaded to the File Manager. |
| **ID** | A sequence number. |
| **File Name** |A file name.  |
| **Selected** | A column that contains **+ Add to list** you can click to add a file to the top table so that it can be added to the File List content item. |

## Create and edit navigation content item page

The following table describes the attributes on the *Create Content Item: Navigation* and *Edit Content Item: Navigation* pages:

| ATTRIBUTE | DESCRIPTION |
| --- | --- |
| Name | Name of the content item. |
| Description | Description of the content item. |
| Navigation | Field to select an existing navigation element. See [Creating a Navigation Element](/docs/scos/user/back-office-user-guides/{{page.version}}/content/content-items/creating-content-items.html#create-a-navigation-content-item) to learn how to create it. |
