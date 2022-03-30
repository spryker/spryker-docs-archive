---
title: Installing and configuring Episerver
description: Install and configure Episerver into Spryker Commerce OS
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/v3/docs/episerver-installation-and-configuration
originalArticleId: 7c88b405-9ec5-4553-83fc-515a950b1bb3
redirect_from:
  - /v3/docs/episerver-installation-and-configuration
  - /v3/docs/en/episerver-installation-and-configuration
  - /docs/scos/user/technology-partners/201907.0/marketing-and-conversion/customer-communication/episerver/installing-and-configuring-episerver.html
---

## Installation

To install Episerver, run the command in the console:
```php
composer require spryker-eco/episerver
```

## Configuration

To set up the Episerver initial configuration, use the credentials received from your Episerver admin page.

The `REQUEST_BASE_URL` parameter should be: `https://api.campaign.episerver.net/`

To get `ORDER_LIST_AUTHORIZATION_CODE` or `CUSTOMER_LIST_AUTHORIZATION_CODE`, go to:

<i>Menu → API overview → SOAP API → Recipient lists → (Click one of your lists here) → Manage authorization codes → Authorization code</i>

To get any `...MAILING_ID`, go to:

<b>Menu → Transactional mails → ID</b>

```php
$config[EpiserverConstants::REQUEST_BASE_URL] = 'https://api.campaign.episerver.net/';
$config[EpiserverConstants::REQUEST_TIMEOUT] = 30;

$config[EpiserverConstants::ORDER_LIST_AUTHORIZATION_CODE] = 'QJd9U0M9xssRGhnJrNr5ztt9FQa2x1wA';
$config[EpiserverConstants::CUSTOMER_LIST_AUTHORIZATION_CODE] = 'QJd9U0M9xssRGhnJrNr5ztt9FQa2x1wA';

$config[EpiserverConstants::ORDER_NEW_MAILING_ID] = '237667360304';
$config[EpiserverConstants::ORDER_CANCELLED_MAILING_ID] = '237667360304';
$config[EpiserverConstants::ORDER_SHIPPING_CONFIRMATION_MAILING_ID] = '237667360304';
$config[EpiserverConstants::ORDER_PAYMENT_IS_NOT_RECEIVED_MAILING_ID] = '237667360304';

$config[EpiserverConstants::EPISERVER_CONFIGURATION_MAILING_ID_LIST] = [
 CustomerRegistrationMailTypePlugin::MAIL_TYPE => '243323625271',
 CustomerRestoredPasswordConfirmationMailTypePlugin::MAIL_TYPE => '243646188958',
 CustomerRestorePasswordMailTypePlugin::MAIL_TYPE => '243646188953',
];
```
