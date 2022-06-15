---
title: Reference information - Search Preferences
search: exclude
description: This guide provides an additional procedure to synchronize search preferences in the Back Office.
last_updated: Nov 22, 2019
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v2/docs/reference-search-preferences
originalArticleId: eed48607-88a2-4ede-a3e2-fcc065da1f7e
redirect_from:
  - /v2/docs/reference-search-preferences
  - /v2/docs/en/reference-search-preferences
  - /docs/scos/user/back-office-user-guides/201903.0/merchandising/search-and-filters/references/reference-search-preferences.html
---

## Synchronize Search Preferences
After adding/updating all necessary attributes, you need to apply the changes by clicking **Synchronize search preferences**. This triggers an action that searches for all products that have those attributes and were modified since the last synchronization and touches them. This means that next time, the search collector execution will update the necessary products, so they can be found by performing a full text search.

 {% info_block infoBox "Synchronization" %}
Depending on the size of your database, the synchronization can be slow sometimes. Make sure that you don't trigger it often if it's not necessary.
{% endinfo_block %}

To have your search collector collect all the dynamic product attributes, make sure you also followed the steps described in the Dynamic product attribute mapping section.

## Current Constraints
Currently, the feature has the following functional constraints which are going to be resolved in the future.

* search preference attributes are shared across all the stores in a project
* you cannot define a search preference for a single store
