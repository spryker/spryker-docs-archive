---
title: Tutorial - Database Transaction Handling
description: Use the guide to understand how to handle database transactions.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/t-database-transactions
originalArticleId: a9cf7e3b-bf1d-4e27-9614-478a6dcc5204
redirect_from:
  - /2021080/docs/t-database-transactions
  - /2021080/docs/en/t-database-transactions
  - /docs/t-database-transactions
  - /docs/en/t-database-transactions
  - /v6/docs/t-database-transactions
  - /v6/docs/en/t-database-transactions
  - /v5/docs/t-database-transactions
  - /v5/docs/en/t-database-transactions
  - /v4/docs/t-database-transactions
  - /v4/docs/en/t-database-transactions
  - /v3/docs/t-database-transactions
  - /v3/docs/en/t-database-transactions
  - /v2/docs/t-database-transactions
  - /v2/docs/en/t-database-transactions
  - /v1/docs/t-database-transactions
  - /v1/docs/en/t-database-transactions
---

<!--Used to be: http://spryker.github.io/tutorials/zed/database-transaction-handling/-->

{% info_block warningBox %}

To reduce boilerplate code and properly handle database transactions you can use `Spryker\Zed\Kernel\Persistence\EntityManager\TransactionTrait`.

{% endinfo_block %}

## Usage

To use database transactions in the `DatabaseTransactionHandlingExample` class:

**Code sample:**

```php
<?php

use Spryker\Zed\Kernel\Persistence\EntityManager\TransactionTrait;

class DatabaseTransactionHandlingExample
{

    use TransactionTrait;

    /**
     * @param string $fooName
     * @param \Bar[] $barCollection
     *
     * @return \Foo
     */
    public function createFoo($fooName, array $barCollection)
    {
        return $this->getTransactionHandler()->handleTransaction(function () use ($fooName, $barCollection) {
            return $this->executeCreateFooTransaction($fooName, $barCollection);
        });
    }

    /**
     * @param string $fooName
     * @param \Bar[] $barCollection
     *
     * @return \Foo
     */
    protected function executeCreateFooTransaction($fooName, array $barCollection)
    {
        $fooEntity = new Foo();
        $fooEntity->setFooName($fooName);
        $fooEntity->save();

        foreach ($barCollection as $bar) {
            $bar->setFkFoo($fooEntity->getIdFoo());
            $bar->save();
        }

        return $fooEntity;
    }

}
```

## Under the Hood

In case of any error, the transaction will be rolled back and an exception will be re-thrown. The code only has one method. The `$connection` parameter is optional and if not specified `Propel::getConnection()` will be used.

**Code sample:**

```php
<?php

    /**
     * @param \Closure $callback
     *
     * @throws \Exception
     * @throws \Throwable
     *
     * @return mixed
     */
    public function handleTransaction(Closure $callback)
    {
        if (!$this->connection) {
            $this->connection = Propel::getConnection();
        }

        $this->connection->beginTransaction();

        try {
            $result = $callback();

            $this->connection->commit();

            return $result;
        } catch (Exception $exception) {
            $this->connection->rollBack();
            throw $exception;
        } catch (Throwable $exception) {
            $this->connection->rollBack();
            throw $exception;
        }
    }
```
