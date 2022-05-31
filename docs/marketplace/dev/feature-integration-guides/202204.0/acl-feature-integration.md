---
title: ACL feature integration
last_updated: Sep 7, 2021
description: This integration guide provides steps on how to integrate the ACL feature into a Spryker project.
template: feature-integration-guide-template
redirect_from:
  - /docs/marketplace/dev/feature-integration-guides/202200.0/acl-feature-integration.html
---

This integration guide provides steps on how to integrate the ACL feature into a Spryker project.

## Install feature core

Follow the steps below to install the ACL feature core.

### Prerequisites

To start feature integration, integrate the required features:

| NAME | VERSION | INTEGRATION GUIDE        |
| --------------- | -------- | ------------------ |
| Spryker Core         | {{page.version}}      | [Spryker Core feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/spryker-core-feature-integration.html) |
| Spryker Core Back Office | {{page.version}}      | [Spryker Core feature integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/spryker-core-back-office-feature-integration.html) |

### 1) Install the required modules using Composer

Install the required modules:

```bash
composer require spryker-feature/acl: "{{page.version}}" --update-with-dependencies
```
{% info_block warningBox "Verification" %}

Make sure that the following modules have been installed:

| MODULE              | EXPECTED DIRECTORY                   |
| ------------------- | ------------------------------------ |
| Acl           | vendor/spryker/acl             |
| AclDataImport | vendor/spryker/acl-data-import |
| AclEntity        | vendor/spryker/acl-entity         |
| AclEntityDataImport     | vendor/spryker/acl-entity-data-import      |
| AclEntityExtension  (optional)  | vendor/spryker/acl-entity-extension     |
| AclExtension  (optional)  | vendor/spryker/acl-extension    |

{% endinfo_block %}

### 2) Set up the database schema

Apply database changes and to generate entity and transfer changes:

```bash
console transfer:generate
console propel:install
console transfer:generate
```

{% info_block warningBox "Verification" %}

Verify that the following changes have been applied by checking your database:

| DATABASE ENTITY               | TYPE  | EVENT   |
| ----------------------------- | ----- | ------- |
| spy_acl_role | table | created |
| spy_acl_rule | table | created |
| spy_acl_group | table | created |
| spy_acl_user_has_group | table | created |
| spy_acl_groups_has_roles | table | created |
| spy_acl_entity_segment | table | created |
| spy_acl_entity_rule | table | created |

{% endinfo_block %}

{% info_block warningBox "Verification" %}

Make sure that the following changes have been applied in transfer objects:

| TRANSFER  | TYPE | EVENT | PATH  |
| ----------------- | ----- | ------ | -------------------------- |
|   Group  | object | Created | src/Generated/Shared/Transfer/GroupTransfer |
|   AclEntityRule | object | Created | src/Generated/Shared/Transfer/AclEntityRuleTransfer |
|   AclEntitySegment | object | Created | src/Generated/Shared/Transfer/AclEntitySegmentTransfer |
|   AclEntitySegmentRequest | object | Created | src/Generated/Shared/Transfer/AclEntitySegmentRequestTransfer |
|   AclEntityRuleRequest | object | Created | src/Generated/Shared/Transfer/AclEntityRuleRequestTransfer |
|   AclEntityRule | object | Created | src/Generated/Shared/Transfer/AclEntityRuleTransfer |
|   AclEntityRuleCollection | object | Created | src/Generated/Shared/Transfer/AclEntityRuleCollectionTransfer |
|   AclEntitySegmentResponse | object | Created | src/Generated/Shared/Transfer/AclEntitySegmentResponseTransfer |
|   AclEntitySegmentCriteria | object | Created | src/Generated/Shared/Transfer/AclEntitySegmentCriteriaTransfer |
|   AclEntityRuleCriteria | object | Created | src/Generated/Shared/Transfer/AclEntityRuleCriteriaTransfer |
|   AclEntityRuleResponse | object | Created | src/Generated/Shared/Transfer/AclEntityRuleResponseTransfer |
|   AclEntityMetadata | object | Created | src/Generated/Shared/Transfer/AclEntityMetadataTransfer |
|   AclEntityParentMetadata | object | Created | src/Generated/Shared/Transfer/AclEntityParentMetadataTransfer |
|   AclEntityParentConnectionMetadata | object | Created | src/Generated/Shared/Transfer/AclEntityParentConnectionMetadataTransfer |
|   AclEntityMetadataCollection | object | Created | src/Generated/Shared/Transfer/AclEntityMetadataCollectionTransfer |
|   AclEntityMetadataConfig | object | Created | src/Generated/Shared/Transfer/AclEntityMetadataConfigTransfer |
|   AclRoleCriteria | object | Created | src/Generated/Shared/Transfer/AclRoleCriteriaTransfer |
|   GroupCriteria | object | Created | src/Generated/Shared/Transfer/GroupCriteriaTransfer |
|   Groups | object | Created | src/Generated/Shared/Transfer/GroupsTransfer |
|   Role | object | Created | src/Generated/Shared/Transfer/RoleTransfer |
|   Roles | object | Created | src/Generated/Shared/Transfer/RolesTransfer |
|   Rule | object | Created | src/Generated/Shared/Transfer/RuleTransfer |
|   Rules | object | Created | src/Generated/Shared/Transfer/Transfer |
|   User | object | Created | src/Generated/Shared/Transfer/UserTransfer |
|   NavigationItem | object | Created | src/Generated/Shared/Transfer/NavigationItemTransfer |
|   NavigationItemCollection | object | Created | src/Generated/Shared/Transfer/Transfer |

{% endinfo_block %}

### 4) Set up behavior

Enable the following behaviors by registering the plugins:

| PLUGIN | DESCRIPTION | PREREQUISITES | NAMESPACE |
|-|-|-|-|
| AccessControlEventDispatcherPlugin | Adds a listener to the `\Symfony\Component\HttpKernel\KernelEvents::REQUEST` which checks if the user is allowed to access the current resource. |  | Spryker\Zed\Acl\Communication\Plugin\EventDispatcher |
| AclNavigationItemCollectionFilterPlugin | Checks if the navigation item can be accessed by the current user. |  | Spryker\Zed\Acl\Communication\Plugin\Navigation |
| AclInstallerPlugin | Fills the DB  with required ACL data. |  | Spryker\Zed\Acl\Communication\Plugin |
| GroupPlugin | Provides Acl Groups for User. |  | Spryker\Zed\Acl\Communication\Plugin |
| AclEntityAclRolePostSavePlugin | Saves `RoleTransfer.aclEntityRules` to database. |  | Spryker\Zed\AclEntity\Communication\Plugin\Acl |
| AclRulesAclRolesExpanderPlugin | Expands `Roles` transfer object with ACL rules. |  | Spryker\Zed\AclEntity\Communication\Plugin\Acl |
| AclEntityApplicationPlugin | Enables ACL for the whole Application. |  | Spryker\Zed\AclEntity\Communication\Plugin\Application |

**src/Pyz/Zed/EventDispatcher/EventDispatcherDependencyProvider.php**

```php
class EventDispatcherDependencyProvider extends SprykerEventDispatcherDependencyProvider
{
    /**
    * @return \Spryker\Shared\EventDispatcherExtension\Dependency\Plugin\EventDispatcherPluginInterface[]
    */
    protected function getEventDispatcherPlugins(): array
    {
        return [
            new AccessControlEventDispatcherPlugin(),
        ];
    }
}
```

**src/Pyz/Zed/ZedNavigation/ZedNavigationDependencyProvider.php**

```php
class ZedNavigationDependencyProvider extends SprykerZedNavigationDependencyProvider
{
    /**
     * @return \Spryker\Zed\ZedNavigationExtension\Dependency\Plugin\NavigationItemCollectionFilterPluginInterface[]
     */
    protected function getNavigationItemCollectionFilterPlugins(): array
    {
        return [
            new AclNavigationItemCollectionFilterPlugin(),
        ];
    }
}
```

**src/Pyz/Zed/Installer/InstallerDependencyProvider.php**

```php
class InstallerDependencyProvider extends SprykerInstallerDependencyProvider
{
    /**
     * @return \Spryker\Zed\Installer\Dependency\Plugin\InstallerPluginInterface[]
     */
    public function getInstallerPlugins()
    {
        return [
            new AclInstallerPlugin(),
        ];
    }
}
```

**src/Pyz/Zed/User/UserDependencyProvider.php**

```php
class InstallerDependencyProvider extends SprykerUserDependencyProvider
{
    /**
     * @param \Spryker\Zed\Kernel\Container $container
     *
     * @return \Spryker\Zed\Kernel\Container
     */
    protected function addGroupPlugin(Container $container)
    {
        $container->set(static::PLUGIN_GROUP, function (Container $container) {
            return new GroupPlugin();
        });

        return $container;
    }
}
```

**src/Pyz/Zed/Acl/AclDependencyProvider.php**

```php
class AclDependencyProvider extends SprykerAclDependencyProvider
{
    /**
     * @return \Spryker\Zed\AclExtension\Dependency\Plugin\AclRolesExpanderPluginInterface[]
     */
    protected function getAclRolesExpanderPlugins(): array
    {
        return [
            new AclRulesAclRolesExpanderPlugin(),
        ];
    }

    /**
     * @return \Spryker\Zed\AclExtension\Dependency\Plugin\AclRolePostSavePluginInterface[]
     */
    protected function getAclRolePostSavePlugins(): array
    {
        return [
            new AclEntityAclRolePostSavePlugin(),
        ];
    }
}
```

Use the following example if you want to enable ACL Entity for the whole Application, for example,for the Merchant Portal:

**src/Pyz/Zed/MerchantPortalApplication/MerchantPortalApplicationDependencyProvider.php**

```php
class MerchantPortalApplicationDependencyProvider extends SprykerMerchantPortalApplicationDependencyProvider
{
   /**
     * @return \Spryker\Shared\ApplicationExtension\Dependency\Plugin\ApplicationPluginInterface[]
     */
    protected function getMerchantPortalApplicationPlugins(): array
    {
        return [
            new AclEntityApplicationPlugin(),
        ];
    }
}
```

### 5) Install the database data for ACL

Run the following command:

```bash
console setup:init-db
```

{% info_block warningBox "Verification" %}

Make sure that the request doesn't succeed for users without permission.

Make sure that the user can see only the allowed menu links.

Make sure that `spy_acl_role`, `spy_acl_group`, and `spy_acl_user_has_group` tables contain default data.

Make sure that current User transfer contains appropriate Acl groups inside.

Make sure that `AclEntityRule` is created in `spy_acl_entity_rule` when the `RoleTransfer` is saved and contains `AclEntityRules`.

Make sure that `RolesTransfer` contains needed `AclEntityRules`.

Ensure the user who is not supposed to have access to an entity or endpoint does not have it.

{% endinfo_block %}
