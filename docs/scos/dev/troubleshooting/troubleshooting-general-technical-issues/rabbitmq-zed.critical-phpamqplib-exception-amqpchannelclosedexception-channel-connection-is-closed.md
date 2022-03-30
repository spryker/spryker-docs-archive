---
title: RabbitMQ- Zed.CRITICAL- PhpAmqpLib\Exception\AMQPChannelClosedException - Channel connection is closed
description: Learn how to fix the issue when events are not consumed or are consumed slowly.
last_updated: Jun 16, 2021
template: troubleshooting-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/rabbitmq-zedcritical-phpamqplibexceptionamqpchannelclosedexception-channel-connection-is-closed
originalArticleId: 39daf8b8-9e73-4c76-a6ee-372d3e5bbca6
redirect_from:
  - /2021080/docs/rabbitmq-zedcritical-phpamqplibexceptionamqpchannelclosedexception-channel-connection-is-closed
  - /2021080/docs/en/rabbitmq-zedcritical-phpamqplibexceptionamqpchannelclosedexception-channel-connection-is-closed
  - /docs/rabbitmq-zedcritical-phpamqplibexceptionamqpchannelclosedexception-channel-connection-is-closed
  - /docs/en/rabbitmq-zedcritical-phpamqplibexceptionamqpchannelclosedexception-channel-connection-is-closed
  - /v6/docs/rabbitmq-zedcritical-phpamqplibexceptionamqpchannelclosedexception-channel-connection-is-closed
  - /v6/docs/en/rabbitmq-zedcritical-phpamqplibexceptionamqpchannelclosedexception-channel-connection-is-closed
---

## Description
Events are not consumed or are consumed slowly. In RabbitMQ exception.log, the following exception can be found:

```
Zed.CRITICAL: PhpAmqpLib\Exception\AMQPChannelClosedException - Channel connection is closed.
```

## Cause
The exact reason for the error is unknown, but we've noticed that it occurs predominantly in large Spryker environments with many product updates.  We continue to explore the root cause.

## Solution
We have discovered two options that helped to resolve the error:

**1. Implementing RabbitMQ lazy queues**
One possible solution can be implementing RabbitMQ lazy queues to reduce RAM usage.
Configuring RabbitMQ to put messages on disk and load them into memory only when they are needed (lazy queuing) can help. For instructions on how to do this, see the CloudAMQ article [Stopping the stampeding herd problem with lazy queues](https://www.cloudamqp.com/blog/2017-07-05-solving-the-thundering-herd-problem-with-lazy-queues.html).

**2.  Adjusting CHUNK_SIZE**
Using smaller chunk sizes for export and storage sync in RabbitMQ might also help to alleviate the issue. Include the following values in the config file used:
```
$config[SynchronizationConstants::EXPORT_MESSAGE_CHUNK_SIZE] = 20000;
$config[SynchronizationConstants::DEFAULT_SYNC_STORAGE_MESSAGE_CHUNK_SIZE] = 20000;
$config[SynchronizationConstants::DEFAULT_SYNC_SEARCH_QUEUE_MESSAGE_CHUNK_SIZE] = 20000;
```
