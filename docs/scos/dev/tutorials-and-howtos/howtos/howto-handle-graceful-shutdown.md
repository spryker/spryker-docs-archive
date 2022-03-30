---
title: HowTo - Handle graceful shutdown
description: Implement a graceful shutdown for your project to make sure the uncompleted processes are not stopped by signals like SIGTERM
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/howto-handle-graceful-shutdown
originalArticleId: d4a9a278-36a6-490b-8333-c4fdfa5e4e1b
redirect_from:
  - /2021080/docs/howto-handle-graceful-shutdown
  - /2021080/docs/en/howto-handle-graceful-shutdown
  - /docs/howto-handle-graceful-shutdown
  - /docs/en/howto-handle-graceful-shutdown
  - /v6/docs/howto-handle-graceful-shutdown
  - /v6/docs/en/howto-handle-graceful-shutdown
---

When a running process is stopped by, for example, signals like `SIGTERM`, `SIGINT`, etc., the process is stopped right away, no matter if it is completed or not. Sometimes, such behavior is not acceptable, for example, in the case of half imported data set.

Whenever you need to make sure that a process is shut down gracefully, you can use the *GracefulRunner* module and pass `\Generator` to its `GracefulRunnerFacadeInterface::run()` method. `GracefulRunnerFacadeInterface::run()` uses the [signal handler](https://github.com/Seldaek/signal-handler) to register a new handler [with pcntl_signal](https://www.php.net/manual/en/function.pcntl-signal.php), and wraps the passed `\Generator`.  Until a signal was sent, the `\Generator::next()` method is executed to make sure that one step of your process is fully completed before the script shuts down.

Example:

```php
public function import(Collection $collection): void
{
    $this->gracefulRunnerFacade->run(
        $this->createImportGenerator($collection)
    );
}

protected function createImportGenerator(Collection $collection): \Generator
{
    foreach ($collections as $collectionItem) {
        yield; // Turns this method into a `\Generator`

        // Code that needs to completely run before script is shutdown.
        // The GracefulRunner takes care of execution and will stop
        // after an iteration was completed when a signal was received.
    }
}
```
{% info_block infoBox %}

To learn more about the Generators, see the Generators documentation.

{% endinfo_block %}

## Handling exceptions
Sometimes, you need to throw an exception into the Generator code. For such cases, you can use the second argument of the `GracefulRunnerFacadeInterface::run()` method. It’s the class name that should be thrown into the Generator when a signal was handled. The following example explains it in more details:

```php
public function import(Collection $collection): void
{
    $this->gracefulRunnerFacade->run(
        $this->createImportGenerator($collection, YourException::class)
    );
}

protected function createImportGenerator(Collection $collection): \Generator
{
    foreach ($collections as $collectionItem) {
        yield; // Turns this method into a `\Generator`

        try {
            // Code that needs to completely run before script is shutdown.
            // The GracefulRunner takes care of execution and will stop
            // after an iteration was completed when a signal was received.
        } catch (YourException $exception) {
            // When a signal is handled you end up here.
        }
    }
}
```
