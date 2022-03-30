---
title: Tutorial - Console Commands
description: Use the guide to create and use a new console command.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/t-console-commands
originalArticleId: f3f329c8-9712-46f1-bed0-a29360c451f6
redirect_from:
  - /2021080/docs/t-console-commands
  - /2021080/docs/en/t-console-commands
  - /docs/t-console-commands
  - /docs/en/t-console-commands
  - /v6/docs/t-console-commands
  - /v6/docs/en/t-console-commands
  - /v5/docs/t-console-commands
  - /v5/docs/en/t-console-commands
  - /v4/docs/t-console-commands
  - /v4/docs/en/t-console-commands
  - /v3/docs/t-console-commands
  - /v3/docs/en/t-console-commands
  - /v2/docs/t-console-commands
  - /v2/docs/en/t-console-commands
  - /v1/docs/t-console-commands
  - /v1/docs/en/t-console-commands  
---

A console command is a PHP class that contains the implementation of a functionality that can get executed from the command line.

Spryker offers a wrapper over Symfony’s Console component that makes the implementation and configuration of a console command easier.

## Implementing a New Console Command
To exemplify how to implement and use a console command, we’ll build a console command that refreshes the application cache and clears folder for generated files. The `UpdateApplicationConsole` will run the following commands in one step:

```bash
vendor/bin/console router:cache:warm-up
vendor/bin/console twig:cache:warmer
vendor/bin/console navigation:build-cache
vendor/bin/console glue:rest:build-request-validation-cache
```

Create the `UpdateApplicationConsole` class.

The console commands must be added in Zed, under the Communication layer of the module, to the Console folder. The console command must extend the `Console` class from Spryker, as you can see below:

```php
<?php
namespace Pyz\Zed\Tutorial\Communication\Console;

use Spryker\Zed\Kernel\Communication\Console\Console;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class UpdateApplicationConsole extends Console
{
//..
}
```

2. Configure the new console command: specify the name and a short description:

```php
<?php
...
    public const COMMAND_NAME = 'tutorial:update';
    public const DESCRIPTION = 'Refresh the application cache and generated files';

    /**
     * @return void
     */
    protected function configure(): void
    {
        $this->setName(self::COMMAND_NAME);
        $this->setDescription(self::DESCRIPTION);

        parent::configure();
    }
...
```

3. Implement the `UpdateApplicationConsole` command.

The code that gets executed when the command is called from the command line must be placed in the `execute` function:

```php
<?php
...

/**
 * @param \Symfony\Component\Console\Input\InputInterface $input
 * @param \Symfony\Component\Console\Output\OutputInterface $output
 *
 * @return int|null|void
 */
protected function execute(InputInterface $input, OutputInterface $output)
{
    $this->runDependingCommand('router:cache:warm-up');
    $this->info('Route cache was successfully updated', false);

    $this->runDependingCommand('twig:cache:warmer');
    $this->info('Twig cache was successfully updated', false);

    $this->runDependingCommand('navigation:build-cache');
    $this->info('Navigation cache was successfully updated', false);

    $this->runDependingCommand('glue:rest:build-request-validation-cache');
    $this->info('Glue request validation cache was successfully updated', false);
}
...
```

4. Register the new console command.

To enable the console command, it must be registered in the `getConsoleCommands()` operation in the `ConsoleDependencyProvider` class:

```php
<?php
...

/**
 * @return \Symfony\Component\Console\Command\Command[]
 */
public function getConsoleCommands()
{
    $commands = [
        ...
        new UpdateApplicationConsole(),

    ];
    return $commands;
}
...
```

5. Test the new console command.

```bash
vendor/bin/console tutorial:update
```
