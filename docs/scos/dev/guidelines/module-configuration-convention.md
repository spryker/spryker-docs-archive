---
title: Module Configuration Convention
description: This article contains conventions on the module configuration.
last_updated: Jun 16, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/module-configuration-convention
originalArticleId: 7231d6db-0a25-4468-b991-d7998998604c
redirect_from:
  - /2021080/docs/module-configuration-convention
  - /2021080/docs/en/module-configuration-convention
  - /docs/module-configuration-convention
  - /docs/en/module-configuration-convention
  - /v6/docs/module-configuration-convention
  - /v6/docs/en/module-configuration-convention
  - /v5/docs/module-configuration-convention
  - /v5/docs/en/module-configuration-convention
  - /v4/docs/module-configuration-convention
  - /v4/docs/en/module-configuration-convention
  - /v3/docs/module-configuration-convention
  - /v3/docs/en/module-configuration-convention
  - /v2/docs/module-configuration-convention
  - /v2/docs/en/module-configuration-convention
  - /v1/docs/module-configuration-convention
  - /v1/docs/en/module-configuration-convention
---

## Definitions

| Constants                             | Usage hints          | Value                     | In Dev configuration                                         |
| ------------------------------------- | -------------------- | ------------------------- | ------------------------------------------------------------ |
| Environment configuration (constants) | Used in config_*.php | Different per environment | DE, AT, US have different environment configurations         |
| Module configuration (constants)      |                      | Different per code deploy | DE, AT shares code, they have the same module configuration. |
| Module constants                      |                      | Always the same           | DE, AT, US has the same module constants.                    |

## Implementation

### Environment Configuration

Environment configuration is changeable per environment, but the constant and its value is not changeable.

* It's an interface, so the usage always points to the current repository => binds constant name => binds value.
* Environment configuration is always in Shared layer, so it's accessible in any layer.
* The constant contains the same UPPERCASE value as the key is + properly prefixed with `MODULE_NAME:`.

```php
interface ModuleNameConstants
{
  public const EXAMPLE_KEY = 'MODULE_NAME:EXAMPLE_KEY';
}				
```



### Module Configuration

Module configuration is extendable on project level. For the module configuration, the following applies:

* It's always a class, so it supports extension for methods.
* Required values are defined in protected constants so it can be extended, but outside access is disabled.
* Getter methods are introduced for constant access, so extended values are used on demand.
* static:: used everywhere to support extension.

Module configuration is split into two categories:

* **module layer configuration** - can be used only in the related application layer. It can be found in:

* * `/Zed/ModuleName/ModuleNameConfig.php`
  * `/Yves/ModuleName/ModuleNameConfig.php`
  * `/Client/ModuleName/ModuleNameConfig.php`
  * `/Service/ModuleName/ModuleNameConfig.php`

* **module shared configuration** - can be used across all application layers. It can be found in /Shared/ModuleName/ModuleNameConfig.php.

```php
class ModuleNameConfig extends AbstractBundleConfig
{
  protected const EXAMPLE_MODULE_KEY = 'my example configurable value';

  public function getExampleModuleKey()
  {
     return static::EXAMPLE_KEY;
  }

  public function getExampleKey()
  {
     return $this->get(ModuleNameConstants::EXAMPLE_KEY);
  }
}
}				
```



### Module constants

Module constants are not meant to be extended or changed, neither their value or name. For these constants, note the following:

* They are located next to the module configuration.
* They are public constants.
* They can be accessed directly from layer code.

```php
class ModuleNameConfig extends AbstractBundleConfig
{
  public const UNCHANGEABLE_CONTENT = 'my unchangable value';
}				
```

{% info_block warningBox %}

Storage unchangeable constants (like queue name, error queue name, resource name) should also follow the unchangeable module constant implementation, and not the events.

{% endinfo_block %}
