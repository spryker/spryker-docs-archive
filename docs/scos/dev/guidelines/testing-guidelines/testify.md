---
title: Testify
description: On top of Codeception, Spryker built the Testify module, which provides many useful helpers
last_updated: Jun 16, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/testify
originalArticleId: e764c9cf-03b9-4766-8ea0-188db29a6b2d
redirect_from:
  - /2021080/docs/testify
  - /2021080/docs/en/testify
  - /docs/testify
  - /docs/en/testify
  - /v6/docs/testify
  - /v6/docs/en/testify
  - /v5/docs/testify
  - /v5/docs/en/testify
  - /v5/docs/testify-1
  - /v5/docs/en/testify-1
  - /docs/scos/dev/guidelines/testing/testify.html
---

On top of [Codeception](https://codeception.com), Spryker offers some classes to make your test life easier. In the Spryker [Testify](https://github.com/spryker/testify) module, you can find many useful  helpers.

The helpers provided within the Testify module let you write your tests way faster and with less mocking required. For the list of the most useful helpers from the Testify module, see [Testify Helpers](/docs/scos/dev/guidelines/testing-guidelines/available-test-helpers.html#testify-helpers).

Spryker follows an [API test](/docs/scos/dev/guidelines/testing-guidelines/testing-best-practices.html) approach to have more coverage with less test code. Testing through the API ensures that the underlying wireup code is working properly. With the helpers of the Testify module, you can avoid ending-up in the so-called "mocking hell". The "mocking hell" means that your test contains more mocks than real test code, which makes the test unreadable and hard to maintain.

Assume you want to test a Facade method. The underlying model which should be tested has dependencies to other models and/or to the module config. Inside the Facade method, you have to create the model through the factory, including its dependencies, and call a method on the created model.

Without the Testify module, you would need to create a test like this one:
```php
// Arrange
$dependencyMock = $this->createDependencyMock();

$factoryMock = $this->createFactoryMock();
$factoryMock->method('createDependency')->willReturn($dependencyMock);

$configMock = $this->createConfigMock(...);
$factoryMock->setConfig($configMock);

$facade = new XyFacade();
$facade->setFactory($factoryMock);

// Act
$result = $facade->doSomething();

// Assert
...
```
That would make your test method unreadable and hard to maintain.
Here is an example with the use of helpers:
```php
// Arrange
$this->tester->mockFactoryMethod('createDependency', $this->createDependencyMock());
$this->tester->mockConfigMethod('getFooBar', 'bazbat');

// Act
$result = $this->tester->getFacade()->doSomething();

// Assert
...

```
As you can see, this test is much smaller, easier to read, and better understandable. All the required injections of the mocks are made behind the scenes, and you can easily test what you want to.

## Next steps
* [Set up an organization of your tests](/docs/scos/dev/guidelines/testing-guidelines/setting-up-tests.html).
* [Create or enable a test helper](/docs/scos/dev/guidelines/testing-guidelines/test-helpers.html).
Learn about the [console commands you can use to execute your tests](/docs/scos/dev/guidelines/testing-guidelines/executing-tests.html).
