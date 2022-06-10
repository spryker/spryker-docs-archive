---
title: REST API reference
search: exclude
description: This page provides an exhaustive reference for the REST API endpoints present in Spryker by default with the corresponding parameters and data formats.
last_updated: Jun 18, 2021
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v6/docs/rest-api-reference
originalArticleId: 9d23934a-df61-4378-bfe1-5e8aaefc0838
redirect_from:
  - /v6/docs/rest-api-reference
  - /v6/docs/en/rest-api-reference
---

This document provides an overview of REST API endpoints provided by Spryker by default. For each endpoint, you will find its URL relative to the server, REST request parameters, as well as the appropriate request and response data formats.

{% info_block warningBox %}

This REST API reference is valid for [Master Suite](https://docs.spryker.com/docs/scos/user/intro-to-spryker/master-suite.html) only. Not all the endpoints are available or are the same for B2B and B2C Demo Shops.

{% endinfo_block %}

<div id="swagger-ui"></div>

{% raw %}
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/3.22.1/swagger-ui.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/3.22.1/swagger-ui-standalone-preset.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/3.22.1/swagger-ui-bundle.js"></script>
<script>
const swaggerContainer = document.getElementById('swagger-ui');
if(swaggerContainer) { 
    console.log('start'); const ui = SwaggerUIBundle({
        url: 'https://spryker.s3.eu-central-1.amazonaws.com/docs/Document+360/json/spryker_rest_api.schema_202090.json',
        dom_id: '#swagger-ui', deepLinking: true, presets: [
            SwaggerUIBundle.presets.apis, SwaggerUIStandalonePreset
        ], 
        enableCORS: false, layout: 'BaseLayout', supportedSubmitMethods: []
    });
    console.log(ui); window.ui = ui 
}
</script>
{% endraw %}
