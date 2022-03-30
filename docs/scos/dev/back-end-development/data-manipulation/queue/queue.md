---
title: Queue
description: The article explains the Spryker Queue System- its work, benefits and configuration
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/queue
originalArticleId: c9916ed4-acec-43d0-8a68-0e9805ce8c15
redirect_from:
  - /2021080/docs/queue
  - /2021080/docs/en/queue
  - /docs/queue
  - /docs/en/queue
  - /v6/docs/queue
  - /v6/docs/en/queue
  - /v5/docs/queue
  - /v5/docs/en/queue
  - /v4/docs/queue
  - /v4/docs/en/queue
  - /v3/docs/queue
  - /v3/docs/en/queue
  - /v2/docs/queue
  - /v2/docs/en/queue
  - /v1/docs/queue
  - /v1/docs/en/queue
related:
  - title: Migration Guide - RabbitMQ
    link: docs/scos/dev/module-migration-guides/migration-guide-rabbitmq.html
---

## Concepts

* Sender	- a program that sends messages.
* Receiver	- a program that waits to receive messages.
* Message - a string or binary data passed from Sender to Receiver.
* Queue	- similar to Mailbox; here you can store, send, and receive messages.

## Introduction
The Queue System provides a protocol for managing asynchronous processing, meaning that the sender and the receiver do not have access to the same message at the same time. The sender produces a message and sends it to the message box, later, when the receiver connects to the message box, the message is received.

## Queue Benefits
Here is the list of the Queue System’s benefits:

1. **Asynchronousness**. Message processing can be offloaded to different times to prevent bottlenecks and run when necessary.
2. **Decoupling**. The queue provides separate layers for data and processing.
3. **Scalability**. Adding more processes for receiving and processing allows for scaling up your applications.
4. **Routing**. Send messages to different routes for specific receivers.
5. **Process Ordering**. The Queue processes messages in the right order.
6. **Error Handling**. Plan for error handling during message processing such as routing to another queue, re-queuing, etc.
7. **Confirmation**. By approving or rejecting the message we can control the life-cycle of the message in a queue.

## Spryker Queue Module
The Spryker Queue module provides a set of high-level standard APIs for communicating with queues. Moreover, the Queue module is also a gateway for other modules to interact with queues and messages. The Queue module is an abstract adapter implementation which provides a standard API for other modules. This API internally calls their queue engine’s API and translates to their own communication language. There are multiple 3rd-party queue engines to choose from such as RabbitMQ, AmazonSQS, etc.

To start working with the Queue module, you need at least one Queue Engine and one Queue Adapter. This module also comes with a set of simple commands for listening to the queues and processing messages by the stack of the corresponding plugins.

## Default Queue Engine
The Spryker virtual machine is shipped with the ready-to-use RabbitMQ engine inside.

To access the management UI

1. Go to `http://zed.de.*.local:15672/` (Replace the asterisk (\*) with `demoshop`, `suite`, `b2b`, or `b2c`)
2. Enter the default credentials: user: `admin` , password: `mate20mg`
3. Click Login

For information on how to work with RabbitMQ, see [Rabbit MQ tutorial](https://www.rabbitmq.com/tutorials/tutorial-one-php.html) or run:

`1man rabbitmq-server`

## Set up RabbitMQ connection

You can override the default connection settings by specifying this config:
```php
$config[RabbitMqEnv::RABBITMQ_CONNECTIONS] = [
    'DE' => [
        RabbitMqEnv::RABBITMQ_CONNECTION_NAME => 'DE-connection',
        RabbitMqEnv::RABBITMQ_HOST => getenv('RABBITMQ_HOST'),
        RabbitMqEnv::RABBITMQ_PORT => getenv('RABBITMQ_PORT'),
        RabbitMqEnv::RABBITMQ_PASSWORD => getenv('RABBITMQ_DEFAULT_PASS'),
        RabbitMqEnv::RABBITMQ_USERNAME => getenv('RABBITMQ_DEFAULT_USER'),
        RabbitMqEnv::RABBITMQ_VIRTUAL_HOST => getenv('RABBITMQ_DEFAULT_VHOST'),
        RabbitMqEnv::RABBITMQ_STORE_NAMES => ['DE'],
    ],
    ...
]
```
To setup secured connection with RabbitMQ, use RABBITMQ_STREAM_CONTEXT_OPTIONS constant:

```php
use Spryker\Shared\RabbitMq\RabbitMqEnv;

$config[RabbitMqEnv::RABBITMQ_CONNECTIONS] = [
    'DE' => [
        ...
        RabbitMqEnv::RABBITMQ_STREAM_CONTEXT_OPTIONS => [
            'ssl' => [
                'verify_peer' => true,
            ],
        ]
    ],
    ...
]
```
For more information about available options see [SSL context options](https://www.php.net/manual/en/context.ssl.php) in PHP manual.

For more information about RabbitMQ SSL connection see [TLS Support](https://www.rabbitmq.com/ssl.html)  in RabbitMQ documentaiton.

## Default Queue Adapter
Spryker includes a RabbitMQ adapter package in [spryker/rabbit-mq](https://github.com/spryker/rabbit-mq). If you have already installed the Spryker Demoshop on your machine, this package will be automatically downloaded for you.

## Queue Message Processor Plugin
Plugins are used to make it possible for developers to have more focus on message processing. This is achieved by handling the queue implementation as a background process, allowing developers to focus on messages and their processing logic.

**Example:**

```php
<?php
namespace Pyz\Zed\Application\Communication\Plugin;

use Spryker\Zed\Queue\Dependency\Plugin\QueueMessageProcessorPluginInterface;

class SampleQueueMessageProcessorPlugin implements QueueMessageProcessorPluginInterface
{

    public function processMessages(array $queueMessageTransfers)
    {
        /* Do something*/
    }

    public function getChunkSize()
    {
        return 100;
    }
}
?>
```

Register the plugin in `QueueDependencyProvider::getProcessorMessagePlugins()`:

```php
<?php
namespace Pyz\Zed\Queue;

use Pyz\Zed\Application\Communication\Plugin\SampleQueueMessageProcessorPlugin;
use Spryker\Zed\Kernel\Container;
use Spryker\Zed\Queue\QueueDependencyProvider as SprykerQueueDependencyProvider;

class QueueDependencyProvider extends SprykerQueueDependencyProvider
{

    protected function getProcessorMessagePlugins(Container $container)
    {
        return [
            'hello' => new SampleQueueMessageProcessorPlugin()
        ];
    }
}

?>
```

## Queue Task
The Queue module provides a specific command for listening to the queues, fetching messages and triggering registered processors. By running this command, you will see the messages to be consumed and passed to the plugins.

The command syntax is as follows:
```bash
./vendor/bin/console queue:task:start <queue-name>
```

## Queue Workers
Queue `Worker` is another useful command that sends the `Task`  to a background process and provides parallel processing. By adjusting the `Worker` config, we can run tasks within a different time slot and with a different amount of processes.

![rabbitmq_worker.png](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Development/Queue/Queue/rabbitmq_worker.png)

**Command syntax:**

```bash
./vendor/bin/console queue:worker:start -vvv
```

## Queue Job Configuration
You can also find the Worker configuration in jobs.php and adjust the worker command to run every minute:

```php
<?php

$jobs[] = [
    'name' => 'queue-worker-start',
    'command' => '$PHP_BIN vendor/bin/console queue:worker:start -vvv',
    'schedule' => '* * * * *',
    'enable' => true,
    'run_on_non_production' => true,
    'stores' => $allStores,
];

?>
```

{% info_block infoBox %}

For more information and examples of how to get started with the Queue module, see [Tutorial - Set Up a "Hello World" Queue](/docs/scos/dev/legacy-demoshop/201811.0/set-up-a-hello-world-queue-legacy-demoshop.html).

{% endinfo_block %}

<!-- Last review date: Apr 9, 2019 by Ehsan Zanjani and Dmitry Beirak -->
