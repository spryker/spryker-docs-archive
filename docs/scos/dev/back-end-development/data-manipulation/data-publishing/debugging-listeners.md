---
title: Debugging Listeners
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/ht-debug-listeners
originalArticleId: 283a1100-8a5f-4c6d-8cdd-a8a093aea5a6
redirect_from:
  - /2021080/docs/ht-debug-listeners
  - /2021080/docs/en/ht-debug-listeners
  - /docs/ht-debug-listeners
  - /docs/en/ht-debug-listeners
  - /v6/docs/ht-debug-listeners
  - /v6/docs/en/ht-debug-listeners
  - /v5/docs/ht-debug-listeners
  - /v5/docs/en/ht-debug-listeners
  - /v4/docs/ht-debug-listeners
  - /v4/docs/en/ht-debug-listeners
  - /v2/docs/cronjob-scheduling-guide
  - /v2/docs/en/cronjob-scheduling-guide
---

{% info_block infoBox %}

The article provides information on the `event:trigger:listener` command.

{% endinfo_block %}

## What does the command do?
The command debugs an event message with a specific listener mapped to it.

## Where is the command used?
Upon triggering the publish process, an event or events are posted to the event queue. Each event message posted to the queue contains the following information about the event that triggered it: event name, ID, names of the corresponding listeners and transfer classes, list of modified columns, as well as foreign keys necessary to backtrack the updated Propel entities. However, it does not contain the actual data that has changed which makes it hard to debug the issue when the transformed data is not stored in the specific storage table. In this case, you need to debug the event message with a specific event listener mapped to it using the `event:trigger:listener` command.

## How to use the command
To debug an event message with a specific listener mapped to it, use the `vendor/bin/console event:trigger:listener` command with the following parameters:

| PARAMETER NAME | TRANSCRIPTION |
| --- | --- |
| `Event listener name` | Defines the listener name. |
| `Data` | Data for filling up the event and entity transfer. E.g. `id=1` |
| `Input format` |Defines the input format. The default format is `querystring`.   |
| `Event name` | Defines the event name to be triggered. |

### Usage examples

```bash
// Triggers ProductAbstractStoragePublishListener for the product abstract with ID equal to 1.
vendor/bin/console event:trigger:listener 'Spryker\\Zed\\ProductStorage\\Communication\\Plugin\\Event\\Listener\\ProductAbstractStoragePublishListener' id=1

// Triggers ProductAbstractStoragePublishListener for the product abstract with {additional data} and ID equal to 1 .
vendor/bin/console event:trigger:listener 'Spryker\\Zed\\ProductStorage\\Communication\\Plugin\\Event\\Listener\\ProductAbstractStoragePublishListener' id=1{additional data}

// Triggers ProductAbstractStoragePublishListener for the product abstract with ID equal to 1. The output is in json format.
vendor/bin/console event:trigger:listener 'Spryker\\Zed\\ProductStorage\\Communication\\Plugin\\Event\\Listener\\ProductAbstractStoragePublishListener' {\"id\":1} -f json

// Triggers ProductAbstractStoragePublishListener for the product abstract with the  PRODUCT_ABSTRACT_PUBLISH event name and ID equal to 1. The output is in json format.
vendor/bin/console event:trigger:listener 'Spryker\\Zed\\ProductStorage\\Communication\\Plugin\\Event\\Listener\\ProductAbstractStoragePublishListener' {\"id\":1} -f json -e PRODUCT_ABSTRACT_PUBLISH
```

<!-- Last review date: Mar 9, 2019 -by Oleksandr Myrnyi, Andrii Tserkovnyi-->
