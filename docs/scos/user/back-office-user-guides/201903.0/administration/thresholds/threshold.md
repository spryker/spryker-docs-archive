---
title: Threshold
description: The section can be used to set up merchant relationships and global thresholds in the Back Office.
last_updated: Jul 31, 2020
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/v2/docs/threshold
originalArticleId: ea7d9449-aae5-4225-8e67-262e0554e859
redirect_from:
  - /v2/docs/threshold
  - /v2/docs/en/threshold
---

The **Threshold** section in the Back Office is mostly used by Spryker Admins.
When doing business online, there comes a time when you need to set a minimum order amount to ensure that the cost of shipping the order is worthwhile for the business. This minimum order amount is configured in the **Back Office > Threshold** section.

**Standardized flow of actions for a Spryker Admin**
![Thresholds - Spryker Admin](https://spryker.s3.eu-central-1.amazonaws.com/docs/User+Guides/Back+Office+User+Guides/Threshold/threshold-section.png)

{% info_block infoBox %}
The minimum order value can be used for both B2B and B2C businesses. The difference is that the thresholds in the B2B environment can be set up for a specific merchant relation, while in the B2C world this option is not used.
{% endinfo_block %}

Thresholds can be hard and soft, based on merchant relationships, applied globally. In case the hard threshold is configured, a buyer cannot proceed to the checkout if the buyer's cart value is below the minimum order value specified in that threshold. With a soft threshold, a customer still can proceed to the checkout, but a warning message or an additional fee can be added to the order sum as a penalty.
***
**What's next?**
To know what thresholds you can set up and how you do that, see the following articles:
* [Merchant Relationships](/docs/scos/user/back-office-user-guides/{{page.version}}/administration/thresholds/managing-merchant-order-thresholds.html)
* [Global Threshold](/docs/scos/user/back-office-user-guides/{{page.version}}/administration/thresholds/managing-global-thresholds.html)
* [Threshold Settings](/docs/scos/user/back-office-user-guides/{{page.version}}/administration/thresholds/managing-threshold-settings.html)

To know more about the attributes you use to manage the thresholds, see the following article:
* [Threshold: Reference Information](/docs/scos/user/back-office-user-guides/{{page.version}}/administration/thresholds/references/threshold-reference-information.html)
