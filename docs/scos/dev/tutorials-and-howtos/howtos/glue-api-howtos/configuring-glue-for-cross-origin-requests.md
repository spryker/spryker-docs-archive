---
title: Configuring Glue for cross-origin requests
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/ht-configuring-glue-for-cross-origin-requests-201903
originalArticleId: 340bd1d9-3055-488a-81e0-aad02e5c5220
redirect_from:
  - /2021080/docs/ht-configuring-glue-for-cross-origin-requests-201903
  - /2021080/docs/en/ht-configuring-glue-for-cross-origin-requests-201903
  - /docs/ht-configuring-glue-for-cross-origin-requests-201903
  - /docs/en/ht-configuring-glue-for-cross-origin-requests-201903
  - /v6/docs/ht-configuring-glue-for-cross-origin-requests-201903
  - /v6/docs/en/ht-configuring-glue-for-cross-origin-requests-201903
  - /v5/docs/ht-configuring-glue-for-cross-origin-requests-201903
  - /v5/docs/en/ht-configuring-glue-for-cross-origin-requests-201903
  - /v4/docs/ht-configuring-glue-for-cross-origin-requests-201903
  - /v4/docs/en/ht-configuring-glue-for-cross-origin-requests-201903
  - /v3/docs/ht-configuring-glue-for-cross-origin-requests-201903
  - /v3/docs/en/ht-configuring-glue-for-cross-origin-requests-201903
  - /v2/docs/ht-configuring-glue-for-cross-origin-requests-201903
  - /v2/docs/en/ht-configuring-glue-for-cross-origin-requests-201903
---

By default, Glue REST API is configured to run using the [same-origin policy](https://en.wikipedia.org/wiki/Same-origin_policy), which still remains the recommended default security level for web applications. However, taking into account that requests to Glue REST API can originate from touchpoints located across multiple domains, we made it possible to enable Cross-Origin Resource Sharing (CORS) in Glue. When CORS is enabled, Glue REST API can accept requests from a list of allowed origins or from any origin, depending on configuration.

To enable cross-origin resource sharing in Glue:

## Prerequisites
To enable CORS support in Glue, follow the Installation Guide.

## Configuration
CORS is configured in Spryker Glue via environment variables. There are 2 levels where CORS can be configured: global and per-domain. On the global level, CORS is configured for the whole Glue Application. On the **per-domain** level, you can configure CORS behavior for each domain configured in Glue Application separately. For example, you can configure different lists of allowed origins for the `http://glue.de.mysprykershop.com` and `http://glue.at.mysprykershop.com` domains.

{% info_block warningBox %}

_Per-domain_ configuration always prevails over the global one. For this reason, the recommended practice is to configure CORS behavior for each domain separately.

{% endinfo_block %}

Configuration can be found in the following files:

* **Global**—`config/Shared/config_default.php`;
* **Per-domain**—`config/Shared/config_default_DE.php`, where DE is the respective domain.

To configure CORS behavior:

1. Open the necessary configuration file depending on which CORS configuration you want to set up.
2. Modify the value of the `GlueApplicationConstants::GLUE_APPLICATION_CORS_ALLOW_ORIGIN` variable. You can set its value as follows:
    * `<null>` - CORS is disabled. Example:

    ```php
    $config[GlueApplicationConstants::GLUE_APPLICATION_CORS_ALLOW_ORIGIN] = '';
    ```

    *  `*` - allow CORS requests from any domain. Example:

    ```php
    $config[GlueApplicationConstants::GLUE_APPLICATION_CORS_ALLOW_ORIGIN] = '*';
    ```

    * `http://www.example1.com` - allow CORS requests only from the specified origin. Example:

    ```php
    $config[GlueApplicationConstants::GLUE_APPLICATION_CORS_ALLOW_ORIGIN] = 'http://www.example1.com';
    ```

3. Save the file.

## Verification
To verify that the configuration has been completed successfully, make an _OPTIONS_ pre-flight request to any valid Glue resource with the correct Origin header, for example, `http://glue.example.com/`, and make sure that:

* The **Access-Control-Allow-Origin** header is present and is the same as set in the configuration;
* The **Access-Control-Allow-Methods** header is present and contains all available REST methods.

You can also make one of the available _POST_, _PATCH_, or _DELETE_ request (depending on the resource used) and verify that response headers are the same.

<!-- Last review date: Mar 14, 2019--by Volodymyr Volkov-->
