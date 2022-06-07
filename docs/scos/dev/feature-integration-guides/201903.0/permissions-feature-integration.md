---
title: Permissions feature integration
search: exclude
description: The guide provides a step-by-step procedure to install the Permissions feature into your project.
last_updated: Jan 28, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v2/docs/permissions-feature-integration
originalArticleId: 3a6d7fa8-28d8-4a0a-b2e9-233ef40ee7a9
redirect_from:
  - /v2/docs/permissions-feature-integration
  - /v2/docs/en/permissions-feature-integration
---

The Permissions feature is shipped with following modules:

| Module | Description |
| --- | --- |
| [Permission](https://github.com/spryker/spryker/tree/master/Bundles/Permission) | Provides permissions support that can be used as a part of ACL / RBAC. |
| [PermissionExtension](https://github.com/spryker/spryker/tree/master/Bundles/PermissionExtension) | Holds a set of plugin interfaces that can be used as extension points of the Permission module. |

To install the feature, follow the steps below:
1. Install necessary modules using composer:

```bash
composer update "spryker/*" "spryker-shop/*"
composer require spryker/permission-extension:"^1.0.0" spryker/permission:"^1.0.0"
```

2. Add plugins to Zed `CustomerDependencyProvider`:


| Module | Plugin | Description | Method in Dependency Provider |
| --- | --- | --- | --- |
| `CompanyRole` | `PermissionCustomerExpanderPlugin` | Adds permissions to the company user. | `getCustomerTransferExpanderPlugins` |
| `CompanyUser` | `CustomerTransferCompanyUserExpanderPlugin` | Adds company user information to customer transfer. | `getCustomerTransferExpanderPlugins` |

**src/Pyz/Zed/Customer/CustomerDependencyProvider.php**

```php
namespace Pyz\Zed\Customer;
 
use Spryker\Zed\CompanyUser\Communication\Plugin\Customer\CustomerTransferCompanyUserExpanderPlugin;
use Spryker\Zed\CompanyRole\Communication\Plugin\PermissionCustomerExpanderPlugin;
use Spryker\Zed\Customer\CustomerDependencyProvider as SprykerCustomerDependencyProvider;
 
class CustomerDependencyProvider extends SprykerCustomerDependencyProvider
{
 
    /**
     * @return \Spryker\Zed\Customer\Dependency\Plugin\CustomerTransferExpanderPluginInterface[]
     */
    protected function getCustomerTransferExpanderPlugins()
    {
        return [
            new PermissionCustomerExpanderPlugin(),
            new CustomerTransferCompanyUserExpanderPlugin()
        ];
    }
}
```

3. Synchronize permission plugins with storage:

Go to the Administration interface, **Maintenance** menu and click **Sync permissions**.
