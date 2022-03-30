---
title: PHP `xdebug` extension is not active when accessing the website via a browser or curl
description: Learn how to fix an issue when PHP `xdebug` extension is not active when accessing the website via a browser or curl
last_updated: Jun 16, 2021
template: troubleshooting-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/php-xdebug-extension-is-not-active-when-accessing-the-website-via-a-browser-or-curl
originalArticleId: eb4a91fe-ab09-4e6f-a591-f942dea005f5
redirect_from:
  - /2021080/docs/php-xdebug-extension-is-not-active-when-accessing-the-website-via-a-browser-or-curl
  - /2021080/docs/en/php-xdebug-extension-is-not-active-when-accessing-the-website-via-a-browser-or-curl
  - /docs/php-xdebug-extension-is-not-active-when-accessing-the-website-via-a-browser-or-curl
  - /docs/en/php-xdebug-extension-is-not-active-when-accessing-the-website-via-a-browser-or-curl
  - /v6/docs/php-xdebug-extension-is-not-active-when-accessing-the-website-via-a-browser-or-curl
  - /v6/docs/en/php-xdebug-extension-is-not-active-when-accessing-the-website-via-a-browser-or-curl
---

## Description
PHP `xdebug` extension is not active when accessing the website via a browser or curl.

## Solution
Try the following:
* Set the `XDEBUG_SESSION=spryker` cookie for the request. You can use a browser extension like [Xdebug helper](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc).
* Run the following command to switch all applications to debug mode:
    ```bash
    docker/sdk run -x
    ```
