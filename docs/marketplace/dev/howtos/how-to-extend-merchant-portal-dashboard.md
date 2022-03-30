---
title: "How-To: Extend Merchant portal dashboard"
description: This articles provides details how to create new module with application
template: howto-guide-template
---

This document describes how to extend the Merchant Portal dashboard.

## 1) Create a plugin

Introduce a new plugin which implements `Spryker\Zed\DashboardMerchantPortalGuiExtension\Dependency\Plugin\MerchantDashboardCardPluginInterface`, for example:

```php
<?php

namespace Pyz\Zed\ExampleModule;

use Generated\Shared\Transfer\MerchantDashboardCardTransfer;
use Spryker\Zed\DashboardMerchantPortalGuiExtension\Dependency\Plugin\MerchantDashboardCardPluginInterface;
use Spryker\Zed\Kernel\Communication\AbstractPlugin;

class ExampleMerchantDashboardCardPlugin extends AbstractPlugin implements MerchantDashboardCardPluginInterface
{
    public function getDashboardCard(): MerchantDashboardCardTransfer
    {
        return (new MerchantDashboardCardTransfer())
                    ->setTitle('Card title')
                    ->setContent('Card content')
                    ->setActionButtons(new ArrayObject([
                        (new MerchantDashboardActionButtonTransfer())
                            ->setTitle('Button title')
                            ->setUrl('button-url'),
                    ]));
    }
}
```

## 2) Register a plugin

Add a newly introduced plugin to `Pyz\Zed\DashboardMerchantPortalGui\DashboardMerchantPortalGuiDependencyProvider`:

```php
<?php

namespace Pyz\Zed\DashboardMerchantPortalGui;

use Spryker\Zed\DashboardMerchantPortalGui\DashboardMerchantPortalGuiDependencyProvider as SprykerDashboardMerchantPortalGuiDependencyProvider;
use Pyz\Zed\ExampleModule\ExampleMerchantDashboardCardPlugin;

class DashboardMerchantPortalGuiDependencyProvider extends SprykerDashboardMerchantPortalGuiDependencyProvider
{
    /**
     * @return \Spryker\Zed\DashboardMerchantPortalGuiExtension\Dependency\Plugin\MerchantDashboardCardPluginInterface[]
     */
    protected function getDashboardCardPlugins(): array
    {
        return [
            new ExampleMerchantDashboardCardPlugin(),
        ];
    }
}
```

{% info_block warningBox "Verification" %}

Go to `/dashboard-merchant-portal-gui/dashboard` in the Merchant Portal, make sure a new card is presented.

{% endinfo_block %}
