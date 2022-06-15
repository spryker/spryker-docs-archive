---
title: Asset Management
search: exclude
description: Apart from images, you can also add a great variety of other assets to your shop, like presentations, pdf documents, graphics, banners and many more.
last_updated: Sep 14, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v5/docs/asset-management
originalArticleId: b3ea1db6-ea8c-415b-809a-d7ef603bd91d
redirect_from:
  - /v5/docs/asset-management
  - /v5/docs/en/asset-management
  - /v5/docs/asset-management-feature-overview
  - /v5/docs/en/asset-management-feature-overview
  - /v5/docs/image-hosting
  - /v5/docs/en/image-hosting
  - /v5/docs/video-embedding
  - /v5/docs/en/video-embedding
---

There are 2 types of assets in the Spryker Commerce OS: dynamic and static.

## Dynamic Assets

Dynamic assets are files, added during content and product creation: adding or changing CMS pages, adding product images.

## Static Assets

Static assets are images, fonts, CSS, JS, HTML and PHP files that are available and used by default. All the files are split into folders according to the application they are used for: Zed, Yves or Glue. The PHP and HTML files stored in static asset directories are used for handling errors and showing the platform maintenance messages.

{% info_block infoBox %}

Currently, except for the error handling files, there are no Glue related assets.
 
{% endinfo_block %}

### Location

By default, static assets are stored locally in the following folders:

*     `public/Yves/assets/`
*     `public/Zed/assets/`

For organizational or cost and speed optimization purposes, the location of static assets can be changed to an external source.

The following environment variables are used for that:

*   `SPRYKER_ZED_ASSETS_BASE_URL`
*   `SPRYKER_YVES_ASSETS_URL_PATTERN`

Check [Custom Location for Static Assets](https://docs.spryker.com/docs/scos/dev/technical-enhancement-integration-guides/integrating-custom-location-for-static-assets.html) for more details.
