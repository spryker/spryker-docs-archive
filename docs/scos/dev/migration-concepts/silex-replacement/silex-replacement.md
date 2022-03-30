---
title: Silex replacement
description: The article contains information on the Silex replacement, backward compatibility, steps to be taken, changes in the old procedure and the new procedure.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/silex-replacement
originalArticleId: 4ec167a5-a956-4a57-b940-d679b1a210aa
redirect_from:
  - /2021080/docs/silex-replacement
  - /2021080/docs/en/silex-replacement
  - /docs/silex-replacement
  - /docs/en/silex-replacement
  - /v6/docs/silex-replacement
  - /v6/docs/en/silex-replacement
  - /v5/docs/silex-replacement
  - /v5/docs/en/silex-replacement
  - /v4/docs/silex-replacement
  - /v4/docs/en/silex-replacement
  - /v3/docs/silex-replacement
  - /v3/docs/en/silex-replacement
  - /v2/docs/silex-replacement-201903
  - /v2/docs/en/silex-replacement-201903
---

Originally, *Silex* was used to integrate Symfony Components with Spryker using _Service Providers_. Also, there were other Service Providers added by Spryker and customer projects to bootstrap the application. Such providers implemented Symfony components and other entities by adding them to the *Pimple container*. Since Silex project is abandoned and the Pimple version is outdated, we replace them with a Spryker solution.

## What did we replace?
We replaced `silex/silex` and `pimple/pimple`.

To be able to replace Silex, we removed all the dependencies in Spryker version `1.3.6`.

We added a new Spryker application to replace Silex and a container to repalce Pimple.

## Is Silex replacement backward compatible?
To avoid forcing an immediate update of the majority of modules, we introduced several small changes, which are backward compatible.

As Silex was an instance of Pimple with all services attached to, we introduced our own _Container_ that implemented the `ContainerInterface` from [PSR-11](https://www.php-fig.org/psr/psr-11/). Additionally, we added a mock class for Pimple that further extended the Container. The mock class allows us to keep using the `\Pimple;` `USE` statement without the `pimple/pimple` package. In this case, we don't have to refactor the code that has Pimple dependencies and all the changes are backward compatible.

{% info_block warningBox %}

We moved the dependency to `spryker/silex` to `require-dev` in all Spryker modules.
When you update a module partially, you might have to add `spryker/silex` to your root `composer.json`.

{% endinfo_block %}

## What changed?

This section describes the changes caused by the Silex replacement.


### Application plugins

Since `ServiceProviderInterface` is not provided anymore, any code that implements it has to be migrated to the new model.

To provide a proper replacement for each Service Provider, we introduced *Application plugins*. An Application plugin is a plugin that integrates a service like Twig, Form, Security, or Routing into the application. Each plugin is added to the corresponding `ApplicationDependencyProvider`.

{% info_block warningBox %}

If you use `ServiceProviderInterface`, make sure to include `spryker/silex` as a `require` dependecy on the project level.

{% endinfo_block %}

### Extending services

Each service added as an Application plugin has an extension interface. To extend a service, use the extension interface of the respective service. For example, The `Twig` module contains `TwigApplicationPlugin`. The `TwigExtension` module brings at least one interface that can be used to extend Twig. To extend it, add `TwigApplicationPlugin` to `ApplicationDependencyProvider`. To extend Twig further, add a plugin to `TwigDependencyProvider`.

You can still extend services via Service providers.

### Existing service providers

Existing Service Providers remain unchanged. New services are added as Application plugins.


## Migrating away from Silex
Since the migration was implemented in two steps, the migration instructions for each project depend on when it was created. If the services in your project are implemented via Service Providers, start the migration from [Replacing Silex](#replacing-silex). If one or more services are implemented as Application Plugins, start from [Removing Silex](#removing-silex).



### Replacing Silex

To replace Silex, follow the instructions below,

#### Update modules using Composer

Update the following modules using Composer:
*   `spryker/application` >= `3.13.2`
*   `spryker/container` >= `1.1.0`
*   `spryker/silex` >= `2.1.0`
*   `spryker/symfony` >= `3.2.2`
*   `spryker-shop/shop-application` >= `1.4.1`

The versions above are the minimum requirements. We recommend updating all the modules to the latest versions.

In older Spryker Commerce OS or Spryker Demoshop versions, there can be dependencies in the `composer.json`. If your project is based on such a version, make sure that the mentioned modules do not appear as project dependencies, and that there are no constraint points to `silex/silex`, `spryker/pimple`, or `pimple/pimple`.

An update might not contain the latest versions of the required modules. To find out why they are not installed, use the `why` and `why-not` Composer commands. They will help you to update the dependencies.

#### Update modules manually
We refactored the modules below to use Application plugins, and the update requires additional steps.  

Update the following modules using the provided migration guides:

| MODULE | MIGRATION GUIDE |
| --- | --- |
| ErrorHandler | [Migration guide - ErrorHandler](/docs/scos/dev/module-migration-guides/migration-guide-errorhandler.html) |
| EventDispatcher | [Migration guide - EventDispatcher](/docs/scos/dev/module-migration-guides/migration-guide-eventdispatcher.html) |
| Form | [Migration guide - Form](/docs/scos/dev/module-migration-guides/migration-guide-form.html) |
| Http | [Migration guide - Http](/docs/scos/dev/module-migration-guides/migration-guide-http.html) |
| Locale | [Migration guide - Locale](/docs/scos/dev/module-migration-guides/migration-guide-locale.html) |
|Propel | [Migration guide - Propel](/docs/scos/dev/module-migration-guides/migration-guide-propel.html) |
| Messenger | [Migration guide - Messenger](/docs/scos/dev/module-migration-guides/migration-guide-messenger.html) |
|Router | [Migration guide - Router](/docs/scos/dev/module-migration-guides/migration-guide-router.html) |
| Security| [Migration guide -Security](/docs/scos/dev/module-migration-guides/migration-guide-security.html) |
|Session | [Migration guide - Session](/docs/scos/dev/module-migration-guides/migration-guide-session.html) |
| Store | [Migration guide - Store](/docs/scos/dev/module-migration-guides/migration-guide-store.html) |
| Translator | [Migration guide - Translator](/docs/scos/dev/module-migration-guides/migration-guide-translator.html) |
| Twig | [Migration guide -Twig](/docs/scos/dev/module-migration-guides/migration-guide-twig.html) |
| Validator | [Migration guide - Validator](/docs/scos/dev/module-migration-guides/migration-guide-validator.html) |
| WebProfiler | [Migration guide - WebProfiler](/docs/scos/dev/module-migration-guides/migration-guide-webprofiler.html) |

You've replaced silex.

### Removing Silex

To remove Silex:

1. Update the modules from [Make Silex optional](https://api.release.spryker.com/release-group/2589).
2. In `public/Glue/index.php` replace `Pyz\Glue\GlueApplication\Bootstrap\GlueBootstrap` with `Spryker\Glue\GlueApplication\Bootstrap\GlueBootstrap`.
3. Add `Spryker\Shared\Http\Plugin\EventDispatcher\ResponseListenerEventDispatcherPlugin` to `\Pyz\Glue\EventDispatcher\EventDispatcherDependencyProvider::getEventDispatcherPlugins()`.
4. Add `Spryker\Glue\Http\Plugin\Application\HttpApplicationPlugin` to `\Pyz\Glue\GlueApplication\GlueApplicationDependencyProvider::getApplicationPlugins()`.
5. Remove the `Pimple` plugin everywhere. To access an [Application](/docs/scos/dev/migration-concepts/silex-replacement/application.html) service, use `$container->getApplicationService('service id');` in the `DependencyProvider`. Then, you can retrieve it within the modules Factory with `$this->getProvidedDependency()`.

6. Add `Spryker\Shared\Http\Plugin\EventDispatcher\ResponseListenerEventDispatcherPlugin` to `\Pyz\Yves\EventDispatcher\EventDispatcherDependencyProvider::getEventDispatcherPlugins()`.

7. Replace each `ServiceProvider` with the annotated replacement of the `ApplicationPlugins` defined in `\Pyz\Yves\Console\ConsoleDependencyProvider::getServiceProviders()` and add the `ApplicationPlugins` to `\Pyz\Yves\Console\ConsoleDependencyProvider::getApplicationPlugins()`.

8. Replace each `ServiceProvider` with the annotated replacement of the `ApplicationPlugins` defined in `\Pyz\Yves\ShopApplication\YvesBootstrap::getServiceProviders()` and add the `ApplicationPlugins` to `\Pyz\Yves\ShopApplication\ShopApplicationDependencyProvider::getApplicationPlugins()`.

You've removed Silex.
