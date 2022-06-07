---
title: Reference information - Navigation
search: exclude
description: Reference information for managing navigation elements in the Back Office.
last_updated: Sep 14, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v5/docs/navigation-reference-information
originalArticleId: 6f2ccc34-b591-4a73-a081-110fd5530ad6
redirect_from:
  - /v5/docs/navigation-reference-information
  - /v5/docs/en/navigation-reference-information
  - /docs/scos/user/back-office-user-guides/202005.0/content/navigation/references/navigation-reference-information.html
related:
  - title: Managing Navigation Elements
    link: docs/scos/user/back-office-user-guides/page.version/content/navigation/managing-navigation-elements.html
---

This topic contains the reference information for working with [navigation elements](/docs/scos/user/features/{{page.version}}/navigation-feature-overview.html#navigation-element) in **Content** > **Navigation**.

## Overview of Navigation Elements Page

On the *Overview of Navigation Elements* page, you see the following:

*     Navigation element number, name, key, and status
*     Actions that you can do to a navigation element
*     Navigation tree displaying all the navigation nodes of a selected navigation element


| Attribute | Description |
| --- | --- |
| **Type** | Type of the navigation node. See [Navigation Node Types](#navigation-node-types) for all the types. |
| **Title** | Name of the navigation node. It is displayed on the Storefront. |
| **Custom CSS class** | CSS class defining the design of the navigation node. Usually, a front-end developer creates them. |
| **Valid from** and **Valid to** | The navigation node is displayed on the Storefront between the dates defined in these fields, inclusively. |
| **Active** | Checkbox to define if the navigation node is active. Inactive navigation nodes and its sub-nodes are not displayed on the Storefront.  |


### Create, Edit, and Duplicate Navigation Element Pages

The following table describes the attributes on the following pages:

*     *Activate Navigation Element*
*     *Edit Navigation Element*
*     *Duplicate Navigation Element*


| Attribute | Description |
| --- | --- |
| Name | Name of the navigation element. It is displayed on the Storefront. |
| Key | Unique identifier of the navigation element used to reference it on the Storefront. |
| Active | Check box to define if the navigation element is active. Inactive navigation elements and its child nodes are not displayed on Storefront.  |


## Navigation Node Types

You can create the following node types:

| Node Type | Node Description |
| --- | --- |
|Label<br>![Label](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Back+Office+User+Guides/Navigation/Navigation+Node+Types/label.png)   | Labels do not link to any specific URL; they are used for grouping other items accessed from the menu.|
| Category<br>![Category](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Back+Office+User+Guides/Navigation/Navigation+Node+Types/category.png)  | Category is used to link an existing category you have to the navigation node. A category must exist in the Category section. |
|CMS Page<br>![CMS page](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Back+Office+User+Guides/Navigation/Navigation+Node+Types/cms-page.png) | CMS page can be assigned to a node. A CMS page must exist in the **Content Management > Pages** section.|
| External URL<br>![External URL](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Back+Office+User+Guides/Navigation/Navigation+Node+Types/external-url.png)  |External URL is a link that is typically opened in a new tab. |
|Link<br>![Link](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Back+Office+User+Guides/Navigation/Navigation+Node+Types/link.png)   | Link to internal pages, i.e. login, registration, etc. |
Depending on the type of the node there is various node related information that can be managed:
* Localized title (**all types of nodes**): This is the name of the node exactly how it will be displayed in the store (for example if you link a category to your node, the node name can be even different from the name of the category).
* Localized custom CSS class (**all types of nodes**): If the class is defined in the shop, then a correct class reference will define the look and feel of the node. This is also localized, which means that for different locales you can have different appearances for the same node.
* Active/not active (**all types of nodes**): If necessary, you can also completely deactivate a node. This will also make the node and the nodes below it invisible in your shop for as long as it’s inactive.
* Localized category URL (**only for “Category” type**): When you are assigning a category, to the node you can search by the category name to select the correct category URL you want to assign. Keep in mind that this also is localized information, so for multiple locales, you will need to make sure that you select the same category for all locales. If your category has multiple parents in the category tree, the same category can have different URLs. In this case, you will need to pick one of those URLs.
* Localized CMS page URL (**only for “CMS” type**): When you are assigning a CMS page to the node, you can search by the CMS page name to select the correct CMS page URL you want to assign. Keep in mind that this is also localized information, so for multiple locales you will need to make sure that you select the same CMS page for all locales.
* Link (**only for “Link” type**): This is the relative path of your internal link. For example, if you would like to link a login page that is under “/login”, then this is exactly what you will use as an input for the Link field.
* External URL (**only for “External URL” type**): If you would like to link an external URL to your nodes, you will use this field to define the absolute URL. This could be used, for example, to link your corporate websites page in your shop. Unlike internal links, the URL of the external link should be absolute which means it needs to include the protocol as well as domain, e.g. https://mydomain.com/page
