---
title: CrefoPay notifications
search: exclude
description: Merchant Notification System (MNS) is a push notification service for merchants that CrefoPay module uses.
last_updated: Nov 22, 2019
template: concept-topic-template
originalLink: https://documentation.spryker.com/v2/docs/crefopay-notifications
originalArticleId: d0d819e3-3148-47d6-adbc-d502dbfe5b63
redirect_from:
  - /v2/docs/crefopay-notifications
  - /v2/docs/en/crefopay-notifications
---

Merchant Notification System (MNS) is a push notification service for merchants. The MNS allows merchants to receive a multitude of notifications asynchronously in order to decouple the merchant system from CrefoPay’s payment systems. Also, with the MNS, merchants can react to any kind of change in the payment status of processed transactions.

Notification calls will be targeted at the notification-URL that is configured for the shop. Multiple notification-URLs may be configured for a single shop. This allows merchants to inform more than one system, for example shop system and ERP system.

The Notification-URL can be configured in merchant back end and must have the following format: `http://de.mysprykershop.com/crefo-pay/notification`.
