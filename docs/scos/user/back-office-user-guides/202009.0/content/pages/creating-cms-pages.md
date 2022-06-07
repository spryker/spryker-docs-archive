---
title: Creating CMS pages
search: exclude
description: The guide provides a procedure to create a CMS page, make it searchable per store in the Back Office.
last_updated: Jun 15, 2021
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v6/docs/creating-a-cms-page
originalArticleId: 56546895-bcc4-4a22-aca8-72ae36012ae1
redirect_from:
  - /v6/docs/creating-a-cms-page
  - /v6/docs/en/creating-a-cms-page
related:
  - title: CMS Page
    link: docs/scos/user/features/page.version/cms-feature-overview/cms-pages-overview.html
  - title: Editing CMS Pages
    link: docs/scos/user/back-office-user-guides/page.version/content/pages/editing-cms-pages.html
  - title: Managing CMS Page Versions
    link: docs/scos/user/back-office-user-guides/page.version/content/pages/managing-cms-page-versions.html
---

This topic describes how to create a CMS page in the Back Office.
To start working with CMS pages, got to **Content Management** > **Pages**.

CMS page is an additional page of your online shop, such as Terms and Conditions, About Us, Contact Us, etc. Here you can create, publish, edit, and manage CMS pages, as well as add content item widgets coupled with the template and multiple CMS blocks.
***
## Creating a CMS Page

To create a page:
1. In the top right corner, click **Create page**.
2. On the **Create CMS Page** page that opens, you can see two tabs: General and SEO.
3. In the **General** tab, do the following:
    * Use the **store relation** to set a store for which your page will be visible on the website. If you want your CMS page not to be displayed per specific locale, clear a respective checkbox.
    * **Optional**: Select **Is searchable** if you want your page to be searched for on the web.
    * Select a page template that will determine a page layout. This is a **mandatory** step.

{% info_block infoBox %}

Templates are project-specific and are usually created by a developer and a business person. If you are missing a CMS Page template, contact them and refer to the [HowTo - Create a CMS Page template](/docs/scos/dev/tutorials-and-howtos/howtos/feature-howtos/cms/howto-create-cms-templates.html#cms-page-template).

{% endinfo_block %}

    * **Optional**: Enter **Valid from** and **Valid to** if you want to define the validity period during which your page will be available in the shop.
    * Enter **Name** and **URL** of the page per locale. This is a **mandatory** step.

1. In the **SEO** tab, enter meta information: title, keywords, and description. The meta details are important for SEO purposes, such as optimizing webpage ranking by search engines and improving website usability.
2. To keep the changes, click **Save**.

**Tips and tricks**

* Keep in mind that by default, store relation is enabled for all stores. To hide your page per specific locale(s), clear checkboxes per that(those) locale(s).
<br>
* Please consider the following cases:
    * If **Is searchable** is selected, but **store relation** is turned off for all stores, the CMS page will not be displayed and will not be searchable.
    * If **Is searchable** is not selected, but **store relation** is turned on, the CMS page will be shown but will not be searchable.
 <br>
 * If you want to create **different** versions of the page per locale, add the general information to the section in the corresponding language.

***
**What's next?**
Until now, you have created a page draft. The page itself will be available in the online store after you publish it.

To learn how to view or publish the page, see [Managing CMS Pages](/docs/scos/user/back-office-user-guides/{{page.version}}/content/pages/managing-cms-pages.html).
