---
title: HowTo - Create and Register a Mail Provider
description: Use the guide to create and register a mail provider in the Mail module.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/ht-create-register-provider-plugin
originalArticleId: 423f4609-d088-428a-bbe9-6718a7e235ed
redirect_from:
  - /2021080/docs/ht-create-register-provider-plugin
  - /2021080/docs/en/ht-create-register-provider-plugin
  - /docs/ht-create-register-provider-plugin
  - /docs/en/ht-create-register-provider-plugin
  - /v6/docs/ht-create-register-provider-plugin
  - /v6/docs/en/ht-create-register-provider-plugin
  - /v5/docs/ht-create-register-provider-plugin
  - /v5/docs/en/ht-create-register-provider-plugin
  - /v4/docs/ht-create-register-provider-plugin
  - /v4/docs/en/ht-create-register-provider-plugin
  - /v3/docs/ht-create-register-provider-plugin
  - /v3/docs/en/ht-create-register-provider-plugin
  - /v2/docs/ht-create-register-provider-plugin
  - /v2/docs/en/ht-create-register-provider-plugin
  - /v1/docs/ht-create-register-provider-plugin
  - /v1/docs/en/ht-create-register-provider-plugin
---

{% info_block infoBox %}
This HowTo describes how to create and register a mail provider you want to use.
{% endinfo_block %}

The mail provider is defined in the provider class. As each provider behaves differently, the provider class will also look different as well.

Create a class which implements `MailProviderPluginInterface`. After that, register your provider in the `Mail` module.

To register a provider, add it to `MailProviderCollection` by adding the provider to `MailDependencyProvider`:

```php
<?php
namespace Pyz\Zed\Mail;

...

public function provideBusinessLayerDependencies(Container $container)
{
    ...

    $container->extend(self::MAIL_PROVIDER_COLLECTION, function (MailProviderCollectionAddInterface $mailProviderCollection) {
        $mailProviderCollection->addProvider(new YourProviderPlugin(), MailConfig::MAIL_TYPE_ALL);

        return $mailProviderCollection;
    });

    ...
}
...
```

By using `$container->extend()`, you get the `MailProviderCollectionAddInterface` where you can add your provider. The `MailProviderCollectionAddInterface::addProvider()` takes the provider you want to use as the first argument, and as the second argument, one `MailType` or a list of MailTypes which should be handled by this provider.

As you can see in the example above, the provider is registered to all MailTypes by using `MailConfig::MAIL_TYPE_ALL`. If you want the provider to only handle a specific MailType, use the `MailType` constant from your `MailTypePlugin` e.g. `CustomerRegistrationMailTypePlugin::MAIL_TYPE`. See [HowTo - Creating and Registering a MailTypePlugin](/docs/scos/dev/tutorials-and-howtos/howtos/howto-create-and-register-a-mailtypeplugin.html) for information on how to create and register a MailTypePlugin.

### Using More Than One Provider
To send emails through different providers, register more than one provider to the `Mail` module. You can even create a scenario when all marketing emails go through provider A, and all others - through provider B. In *Register the Mail Provider* you already made use of this technique to register one provider to all types. The following example demonstrates how to wire up more than one provider:

```php
<?php
namespace Pyz\Zed\Mail;

...

public function provideBusinessLayerDependencies(Container $container)
{
    ...

    $container->extend(self::MAIL_PROVIDER_COLLECTION, function (MailProviderCollectionAddInterface $mailProviderCollection) {
        $mailProviderCollection
            ->addProvider(new ProviderAPlugin(), [MailTypeA::MAIL_TYPE, MailTypeB::MAIL_TYPE])
            ->addProvider(new ProviderBPlugin(), MailTypeC::MAIL_TYPE);

        return $mailProviderCollection;
    });

    ...
}
...
```

If a `MailType` can be handled by more than one provider, the email will be sent by both of them.

<!--
See also:

* HowTo - Create and Register a MailTypePlugin
* Tutorial - Sending a Mail
* -->
