---
title: Creating scheduled prices
search: exclude
description: This user guide is about scheduling price changes by creating product price schedules. This functionality is shipped with the Scheduled prices feature.
last_updated: Aug 27, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v6/docs/creating-scheduled-prices
originalArticleId: cc4d1e83-dc09-4723-a5dc-7ac6fbfe3eed
redirect_from:
  - /v6/docs/creating-scheduled-prices
  - /v6/docs/en/creating-scheduled-prices
related:
  - title: Managing Scheduled Prices
    link: docs/scos/user/back-office-user-guides/page.version/catalog/scheduled-prices/managing-scheduled-prices.html
  - title: Scheduled Prices Feature Overview
    link: docs/scos/user/features/page.version/scheduled-prices-feature-overview.html
---

This topic describes how to create scheduled prices.
To start working with scheduled prices, go to **Prices** > **Scheduled Prices**.

For example, you want to set up a promotion for Valentine's Day beforehand so that:

* you do not have to switch prices manually on the day of the promotion
* prices switch to the specified ones automatically on the starting date of the promotion
* prices switch back automatically on the last day of the promotion

Instead of changing prices manually on the starting day of the promotion, you can create a price schedule called,  e.g. **Valentine's day prices**. To do that you need to import a file with predefined dates and prices.
***

**To create a price schedule:**

1. Create a CSV file with predefined product price schedules. See [Scheduled Prices: Reference information](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/scheduled-prices/references/reference-information-scheduled-prices.html#import-new-scheduled-prices-page).
2. Enter and select the attributes for your price schedule. See [Scheduled Prices: Reference information](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/scheduled-prices/creating-scheduled-prices.html).
3. Click **Browse** and select the file you've prepared in step 1.
4. Click **Import your CSV file**.
5. Once redirected to the _Import dry run_ page, check whether there are incorrect entries in your file in the **Errors found inside your file** section.

{% info_block infoBox %}

If needed, you can [edit the imported scheduled prices](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/scheduled-prices/managing-scheduled-prices.html).

{% endinfo_block %}
    
6. Check if the successfully imported price schedules are correct in the **Row processed with success** section.

7. If you are satisfied with the results, in the **Publish the scheduled prices** section, click **Publish** to apply the price schedules.

**Tips and tricks**
* If you leave the _Import dry run_ page without publishing the imported price schedules, they do not get deleted. However, you won't be able to return to that page unless you import the file once again.
* You can check current price schedules of each product in **Products** section >**Edit Product** page > **Scheduled Prices** tab.
