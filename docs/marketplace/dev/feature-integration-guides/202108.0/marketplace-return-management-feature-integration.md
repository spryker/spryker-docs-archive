---
title: Marketplace Return Management feature integration
last_updated: Sep 14, 2021
description: This document describes the process how to integrate the Marketplace Return Management feature into a Spryker project.
template: feature-integration-guide-template
---

This document describes how to integrate the Marketplace Return Management feature into a Spryker project.

## Install feature core

Follow the steps below to install the Marketplace Return Management feature core.

### Prerequisites

To start feature integration, integrate the required features:

| NAME | VERSION | INTEGRATION GUIDE |
| --------------- | ------- | ---------- |
| Spryker Core                 | {{page.version}} | [Spryker Core Feature Integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/spryker-core-feature-integration.html) |
| Return Management            | {{page.version}} | [Return Management Feature Integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/return-management-feature-integration.html) |
| Marketplace Order Management | {{page.version}} | [Marketplace Order Management Feature Integration](/docs/marketplace/dev/feature-integration-guides/{{page.version}}/marketplace-order-management-feature-integration.html) |

### 1) Install required modules using Composer
<!--Provide one or more console commands with the exact latest version numbers of all required modules. If the Composer command contains the modules that are not related to the current feature, move them to the [prerequisites](#prerequisites).-->

Install the required modules:

```bash
composer require spryker-feature/marketplace-return-management:"{{page.version}}" --update-with-dependencies
```

<!-- Have to be deleted after Return Management feature will be released with a new version-->


{% info_block warningBox "Verification" %}

Make sure that the following modules have been installed:

| MODULE  | EXPECTED DIRECTORY <!--for public Demo Shops--> |
| -------- | ------------------- |
| MerchantSalesReturn | spryker/merchant-sales-return |
| MerchantSalesReturnGui | spryker/merchant-sales-return-gui |
| MerchantSalesReturnMerchantUserGui | spryker/merchant-sales-return-merchant-user-gui |

{% endinfo_block %}

### 2) Set up the configuration
<!--Describe system and module configuration changes. If the default configuration is enough for a primary behavior, skip this step.-->

Add the following configuration:

| CONFIGURATION | SPECIFICATION | NAMESPACE |
| ------------- | ------------ | ------------ |
| MainMerchantStateMachine | Adjust `MainMerchantStateMachine` to have the `MerchantReturn` and `MerchantRefund` subprocesses. | config/Zed/StateMachine/Merchant/MainMerchantStateMachine.xml |
| MerchantDefaultStateMachine | Adjust `MerchantDefaultStateMachine` to have the `MerchantReturn` and `MerchantRefund` subprocesses. | config/Zed/StateMachine/Merchant/MerchantDefaultStateMachine.xml |
| MerchantRefund  | Add configuration for `MerchantRefund` subprocess in the `Subprocess` folder for the Merchant StateMachine configuration. | config/Zed/StateMachine/Merchant/Subprocess/MerchantRefund.xml |
| MerchantReturn  | Add configuration for the `MerchantReturn` subprocess in the `Subprocess` folder for the Merchant StateMachine configuration. | config/Zed/StateMachine/Merchant/Subprocess/MerchantReturn.xml |
| MarketplacePayment  | Adjust OMS configuration for the `MarketplacePayment` to have the `MarketplaceReturn` and `MarketplaceRefund` subprocesses. | config/Zed/oms/MarketplacePayment01.xml |
| MarketplaceRefund  | Add configuration for the `MarketplaceRefund` subprocess in the `MarketplaceSubprocess` folder for the OMS configuration. | config/Zed/oms/MarketplaceSubprocess/MarketplaceRefund01.xml |
| MarketplaceReturn  | Add configuration for `MarketplaceReturn` subprocess in the `MarketplaceSubprocess` folder for the OMS configuration. | config/Zed/oms/MarketplaceSubprocess/MarketplaceReturn01.xml |

<details>
<summary markdown='span'>config/Zed/StateMachine/Merchant/MainMerchantStateMachine.xml</summary>

```xml
<?xml version="1.0"?>
<statemachine
    xmlns="spryker:state-machine-01"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="spryker:state-machine-01 http://static.spryker.com/state-machine-01.xsd">

    <process name="MainMerchantStateMachine" main="true">
        <subprocesses>
            <process>MerchantReturn</process>
            <process>MerchantRefund</process>
        </subprocesses>
    </process>

    <process name="MerchantReturn" file="Subprocess/MerchantReturn"/>
    <process name="MerchantRefund" file="Subprocess/MerchantRefund"/>

</statemachine>
```

</details>

<details>
<summary markdown='span'>config/Zed/StateMachine/Merchant/MerchantDefaultStateMachine.xml</summary>

```xml
<?xml version="1.0"?>
<statemachine
    xmlns="spryker:state-machine-01"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="spryker:state-machine-01 http://static.spryker.com/state-machine-01.xsd">

    <process name="MerchantDefaultStateMachine" main="true">
        <subprocesses>
            <process>MerchantReturn</process>
            <process>MerchantRefund</process>
        </subprocesses>
    </process>

    <process name="MerchantReturn" file="Subprocess/MerchantReturn"/>
    <process name="MerchantRefund" file="Subprocess/MerchantRefund"/>

</statemachine>
```

</details>

<details>
<summary markdown='span'>config/Zed/StateMachine/Merchant/Subprocess/MerchantRefund.xml</summary>

```xml
<?xml version="1.0"?>
<statemachine
        xmlns="spryker:oms-01"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="spryker:oms-01 http://static.spryker.com/oms-01.xsd">

  <process name="MerchantRefund">
    <states>
      <state name="refunded"/>
    </states>

    <transitions>
      <transition>
        <source>delivered</source>
        <target>refunded</target>
        <event>refund</event>
      </transition>

      <transition>
        <source>returned</source>
        <target>refunded</target>
        <event>refund</event>
      </transition>
    </transitions>

    <events>
      <event name="refund" manual="true" command="MarketplaceOrder/Refund"/>
    </events>
  </process>

</statemachine>
```

</details>

<details>
<summary markdown='span'>config/Zed/StateMachine/Merchant/Subprocess/MerchantReturn.xml</summary>

```xml
<?xml version="1.0"?>
<statemachine
        xmlns="spryker:oms-01"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="spryker:oms-01 http://static.spryker.com/oms-01.xsd">

  <process name="MerchantReturn">
    <states>
       <state name="waiting for return"/>
       <state name="returned"/>
       <state name="return canceled"/>
       <state name="shipped to customer"/>
    </states>

    <transitions>
      <transition>
        <source>shipped</source>
        <target>waiting for return</target>
        <event>start-return</event>
      </transition>

      <transition>
        <source>delivered</source>
        <target>waiting for return</target>
        <event>start-return</event>
      </transition>

      <transition>
        <source>waiting for return</source>
        <target>returned</target>
        <event>execute-return</event>
      </transition>

      <transition>
        <source>waiting for return</source>
        <target>return canceled</target>
        <event>cancel-return</event>
      </transition>

      <transition>
        <source>return canceled</source>
        <target>shipped to customer</target>
        <event>ship-return</event>
      </transition>

      <transition>
        <source>shipped to customer</source>
        <target>delivered</target>
        <event>deliver-return</event>
      </transition>
    </transitions>

    <events>
      <event name="start-return"/>
      <event name="execute-return" command="MarketplaceReturn/ExecuteReturnForOrderItem" manual="true"/>
      <event name="cancel-return" command="MarketplaceReturn/CancelReturnForOrderItem" manual="true"/>
      <event name="ship-return" command="MarketplaceReturn/ShipReturnForOrderItem" manual="true"/>
      <event name="deliver-return" command="MarketplaceReturn/DeliverReturnForOrderItem" manual="true"/>
    </events>
  </process>

</statemachine>
```

</details>

<details>
<summary markdown='span'>config/Zed/oms/MarketplacePayment01.xml</summary>

```xml
<?xml version="1.0"?>
<statemachine
    xmlns="spryker:oms-01"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="spryker:oms-01 http://static.spryker.com/oms-01.xsd">

    <process name="MarketplacePayment01" main="true">
        <subprocesses>
            <process>MarketplaceReturn</process>
            <process>MarketplaceRefund</process>
        </subprocesses>
    </process>

    <process name="MarketplaceReturn" file="MarketplaceSubprocess/MarketplaceReturn01.xml"/>
    <process name="MarketplaceRefund" file="MarketplaceSubprocess/MarketplaceRefund01.xml"/>

</statemachine>
```

</details>

<details>
<summary markdown='span'>config/Zed/oms/MarketplaceSubprocess/MarketplaceRefund01.xml</summary>

```xml
<?xml version="1.0"?>
<statemachine
        xmlns="spryker:oms-01"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="spryker:oms-01 http://static.spryker.com/oms-01.xsd">

    <process name="MarketplaceRefund">
        <states>
            <state name="refunded"/>
        </states>

        <transitions>
            <transition>
                <source>delivered</source>
                <target>refunded</target>
                <event>refund</event>
            </transition>

            <transition>
                <source>returned</source>
                <target>refunded</target>
                <event>refund</event>
            </transition>
        </transitions>

        <events>
            <event name="refund" command="DummyPayment/Refund"/>
        </events>
    </process>

</statemachine>
```

</details>

<details>
<summary markdown='span'>config/Zed/oms/MarketplaceSubprocess/MarketplaceReturn01.xml</summary>

```xml
<?xml version="1.0"?>
<statemachine
        xmlns="spryker:oms-01"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="spryker:oms-01 http://static.spryker.com/oms-01.xsd">

  <process name="MarketplaceReturn">
    <states>
      <state name="waiting for return"/>
      <state name="returned"/>
      <state name="return canceled"/>
      <state name="shipped to customer"/>
    </states>

    <transitions>
      <transition>
        <source>shipped by merchant</source>
        <target>waiting for return</target>
        <event>start-return</event>
      </transition>

      <transition>
        <source>delivered</source>
        <target>waiting for return</target>
        <event>start-return</event>
      </transition>

      <transition>
        <source>waiting for return</source>
        <target>returned</target>
        <event>execute-return</event>
      </transition>

      <transition>
        <source>waiting for return</source>
        <target>return canceled</target>
        <event>cancel-return</event>
      </transition>

      <transition>
        <source>return canceled</source>
        <target>shipped to customer</target>
        <event>ship-return</event>
      </transition>

      <transition>
        <source>shipped to customer</source>
        <target>delivered</target>
        <event>deliver-return</event>
      </transition>
    </transitions>

    <events>
      <event name="start-return" command="MerchantOms/ReturnOrderItem"/>
      <event name="execute-return"/>
      <event name="cancel-return"/>
      <event name="ship-return"/>
      <event name="deliver-return"/>
    </events>
  </process>

</statemachine>
```

</details>

### 3) Set up database schema and transfer objects
<!--Provide the following with a description before each item:
* Code snippets with DB schema changes.
* Code snippets with transfer schema changes.
* The console command to apply the changes in project and core. -->

Apply database changes and to generate entity and transfer changes:

```bash
console transfer:generate
console propel:install
console transfer:generate
```

{% info_block warningBox "Verification" %}

Make sure that the following changes have been applied by checking your database:

| DATABASE ENTITY | TYPE | EVENT |
| --------------- | ---- | ------ |
| spy_sales_return.merchant_reference | column | created |

Make sure that the following changes have been triggered in transfer objects:

| TRANSFER | TYPE | EVENT  | PATH  |
| --------- | ------- | ----- | ------------- |
| MerchantOrderCriteria.orderItemUuids | attribute | created | src/Generated/Shared/Transfer/MerchantOrderCriteriaTransfer |
| MerchantOrder.return | attribute | created | src/Generated/Shared/Transfer/MerchantOrderTransfer |
| Return.merchantOrders | attribute | created | src/Generated/Shared/Transfer/ReturnTransfer |


{% endinfo_block %}

### 4) Add translations
<!--Provide glossary keys for `DE` and `EN` of your feature as a code snippet. When a glossary key is dynamically generated, describe how to construct the key.-->

Add translations as follows:

1. Append glossary for the feature:

<details>
<summary markdown='span'>data/import/common/common/glossary.csv</summary>

```
merchant_sales_return.message.items_from_different_merchant_detected,"There are products from different merchants in your order. You can only return products from one merchant at a time.",en_US
merchant_sales_return.message.items_from_different_merchant_detected,"Diese Bestellung enthält Artikel von verschiedenen Händlern. Sie können nur Artikel von einem Händler zur selben Zeit zurückschicken.",de_DE
merchant_sales_return_widget.create_form.different_merchants_info,There are products from different merchants in your order. You can only return products from one merchant at a time.,en_US
merchant_sales_return_widget.create_form.different_merchants_info,Diese Bestellung enthält Artikel von verschiedenen Händlern. Sie können nur Artikel von einem Händler zur selben Zeit zurückschicken.,de_DE
```

</details>


2. Import data:

```bash
console data:import glossary
```

{% info_block warningBox "Verification" %}
<!--Describe how a developer can check they have completed the step correctly.-->

Make sure that the configured data has been added to the `spy_glossary` table.

{% endinfo_block %}

### 5) Set up behavior
<!--This is a comment, it will not be included -->
Enable the following behaviors by adding and registering the plugins:

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE |
| ------------ | ----------- | ----- | ------------ |
| MerchantReturnPreCreatePlugin | Sets merchant reference to the return transfer. |  |   Spryker\Zed\MerchantSalesReturn\Communication\Plugin\SalesReturn |
| MerchantReturnCreateRequestValidatorPlugin | Checks if each item in the `itemTransfers` has the same merchant reference. |  |   Spryker\Zed\MerchantSalesReturn\Communication\Plugin |
| MerchantReturnExpanderPlugin | Expands `Return` transfer object with merchant orders. |  |   Spryker\Zed\MerchantSalesReturn\Communication\Plugin\SalesReturn |
| CancelReturnMarketplaceOrderItemCommandPlugin | Triggers 'cancel-return' event on a marketplace order item. |  |   Pyz\Zed\MerchantOms\Communication\Plugin\Oms |
| DeliverReturnMarketplaceOrderItemCommandPlugin | Triggers 'deliver-return' event on a marketplace order item. |  |   Pyz\Zed\MerchantOms\Communication\Plugin\Oms |
| ExecuteReturnMarketplaceOrderItemCommandPlugin | Triggers 'execute-return' event on a marketplace order item. |  |   Pyz\Zed\MerchantOms\Communication\Plugin\Oms |
| RefundMarketplaceOrderItemCommandPlugin | Triggers 'refund' event on a marketplace order item. |  |   Pyz\Zed\MerchantOms\Communication\Plugin\Oms |
| ReturnMerchantOrderItemCommandPlugin | Triggers 'start-return' event on a marketplace order item, initiate return. |  |   Pyz\Zed\MerchantOms\Communication\Plugin\Oms |
| ShipReturnMarketplaceOrderItemCommandPlugin | Triggers 'ship-return' event on a marketplace order item. |  |   Pyz\Zed\MerchantOms\Communication\Plugin\Oms |
| MerchantReturnCreateTemplatePlugin |  Replace the template, that renders item table on return create page in Zed. |  |   Spryker\Zed\MerchantSalesReturnGui\Communication\Plugin\SalesReturnGui |

<details>
<summary markdown='span'>src/Pyz/Zed/SalesReturn/SalesReturnDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\SalesReturn;

use Spryker\Zed\MerchantSalesReturn\Communication\Plugin\MerchantReturnCreateRequestValidatorPlugin;
use Spryker\Zed\MerchantSalesReturn\Communication\Plugin\MerchantReturnPreCreatePlugin;
use Spryker\Zed\MerchantSalesReturn\Communication\Plugin\SalesReturn\MerchantReturnExpanderPlugin;
use Spryker\Zed\SalesReturn\SalesReturnDependencyProvider as SprykerSalesReturnDependencyProvider;

class SalesReturnDependencyProvider extends SprykerSalesReturnDependencyProvider
{
    protected function getReturnPreCreatePlugins(): array
    {
        return [
            new MerchantReturnPreCreatePlugin(),
        ];
    }

    protected function getReturnCreateRequestValidatorPlugins(): array
    {
        return [
            new MerchantReturnCreateRequestValidatorPlugin(),
        ];
    }

    /**
     * @return \Spryker\Zed\SalesReturnExtension\Dependency\Plugin\ReturnExpanderPluginInterface[]
     */
    protected function getReturnExpanderPlugins(): array
    {
        return [
            new MerchantReturnExpanderPlugin(),
        ];
    }
}
```

</details>

{% info_block warningBox "Verification" %}

<!--Describe how a developer can check they have completed the step correctly.-->

1. To verify `MerchantReturnPreCreatePlugin` make sure that when you create return for merchant order items, row in `spy_sales_return` that identifies the new return has `spy_sales_return.merchant_reference` field populated.
2. To verify `MerchantReturnCreateRequestValidatorPlugin` make sure, that you can't create return for items from different merchants.
3. To verify `MerchantReturnExpanderPlugin` make sure that you can see merchant order references on return detail page.

{% endinfo_block %}

<details>
<summary markdown='span'>src/Pyz/Zed/MerchantOms/Communication/Plugin/Oms/AbstractTriggerOmsEventCommandPlugin.php</summary>

```php
<?php

namespace Pyz\Zed\MerchantOms\Communication\Plugin\Oms;

use Generated\Shared\Transfer\MerchantOrderItemCriteriaTransfer;
use Generated\Shared\Transfer\StateMachineItemTransfer;
use LogicException;
use Spryker\Zed\Kernel\Communication\AbstractPlugin;
use Spryker\Zed\StateMachine\Dependency\Plugin\CommandPluginInterface;

/**
 * @method \Pyz\Zed\MerchantOms\Communication\MerchantOmsCommunicationFactory getFactory()
 * @method \Pyz\Zed\MerchantOms\MerchantOmsConfig getConfig()
 */
abstract class AbstractTriggerOmsEventCommandPlugin extends AbstractPlugin implements CommandPluginInterface
{
    /**
     * @return string
     */
    abstract public function getEventName(): string;

    /**
     * {@inheritDoc}
     * - Triggers event on a marketplace order item.
     *
     * @param \Generated\Shared\Transfer\StateMachineItemTransfer $stateMachineItemTransfer
     *
     * @throws \LogicException
     *
     * @return void
     */
    public function run(StateMachineItemTransfer $stateMachineItemTransfer)
    {
        $merchantOrderItemTransfer = $this->getFactory()->getMerchantSalesOrderFacade()->findMerchantOrderItem(
            (new MerchantOrderItemCriteriaTransfer())
                ->setIdMerchantOrderItem($stateMachineItemTransfer->getIdentifier())
        );

        if (!$merchantOrderItemTransfer) {
            return;
        }

        $result = $this->getFactory()
            ->getOmsFacade()
            ->triggerEventForOneOrderItem($this->getEventName(), $merchantOrderItemTransfer->getIdOrderItem());

        if ($result === null) {
            throw new LogicException(sprintf(
                'Sales Order Item #%s transition for event "%s" has not happened.',
                $merchantOrderItemTransfer->getIdOrderItem(),
                $this->getEventName()
            ));
        }
    }
}

```

</details>

<details>
<summary markdown='span'>src/Pyz/Zed/MerchantOms/Communication/Plugin/Oms/CancelReturnMarketplaceOrderItemCommandPlugin.php</summary>

```php
<?php

namespace Pyz\Zed\MerchantOms\Communication\Plugin\Oms;

class CancelReturnMarketplaceOrderItemCommandPlugin extends AbstractTriggerOmsEventCommandPlugin
{
    protected const EVENT_CANCEL_RETURN = 'cancel-return';

    /**
     * @return string
     */
    public function getEventName(): string
    {
        return static::EVENT_CANCEL_RETURN;
    }
}

```

</details>

<details>
<summary markdown='span'>src/Pyz/Zed/MerchantOms/Communication/Plugin/Oms/DeliverReturnMarketplaceOrderItemCommandPlugin.php</summary>

```php
<?php

namespace Pyz\Zed\MerchantOms\Communication\Plugin\Oms;

class DeliverReturnMarketplaceOrderItemCommandPlugin extends AbstractTriggerOmsEventCommandPlugin
{
    protected const EVENT_DELIVER_RETURN = 'deliver-return';

    /**
     * @return string
     */
    public function getEventName(): string
    {
        return static::EVENT_DELIVER_RETURN;
    }
}

```

</details>

<details>
<summary markdown='span'>src/Pyz/Zed/MerchantOms/Communication/Plugin/Oms/ExecuteReturnMarketplaceOrderItemCommandPlugin.php</summary>

```php
<?php

namespace Pyz\Zed\MerchantOms\Communication\Plugin\Oms;

class ExecuteReturnMarketplaceOrderItemCommandPlugin extends AbstractTriggerOmsEventCommandPlugin
{
    protected const EVENT_EXECUTE_RETURN = 'execute-return';

    /**
     * @return string
     */
    public function getEventName(): string
    {
        return static::EVENT_EXECUTE_RETURN;
    }
}

```

</details>

<details>
<summary markdown='span'>src/Pyz/Zed/MerchantOms/Communication/Plugin/Oms/RefundMarketplaceOrderItemCommandPlugin.php</summary>

```php
<?php

namespace Pyz\Zed\MerchantOms\Communication\Plugin\Oms;

class RefundMarketplaceOrderItemCommandPlugin extends AbstractTriggerOmsEventCommandPlugin
{
    protected const EVENT_REFUND = 'refund';

    /**
     * @return string
     */
    public function getEventName(): string
    {
        return static::EVENT_REFUND;
    }
}

```

</details>

<details>
<summary markdown='span'>src/Pyz/Zed/MerchantOms/Communication/Plugin/Oms/ReturnMerchantOrderItemCommandPlugin.php</summary>

```php
<?php

namespace Pyz\Zed\MerchantOms\Communication\Plugin\Oms;

use Generated\Shared\Transfer\ItemTransfer;
use Generated\Shared\Transfer\MerchantOmsTriggerRequestTransfer;
use Generated\Shared\Transfer\MerchantOrderItemCriteriaTransfer;
use LogicException;
use Orm\Zed\Sales\Persistence\SpySalesOrderItem;
use Spryker\Zed\Kernel\Communication\AbstractPlugin;
use Spryker\Zed\Oms\Business\Util\ReadOnlyArrayObject;
use Spryker\Zed\Oms\Dependency\Plugin\Command\CommandByItemInterface;

/**
 * @method \Pyz\Zed\MerchantOms\Communication\MerchantOmsCommunicationFactory getFactory()
 * @method \Pyz\Zed\MerchantOms\MerchantOmsConfig getConfig()
 * @method \Spryker\Zed\MerchantOms\Business\MerchantOmsFacade getFacade()()
 */
class ReturnMerchantOrderItemCommandPlugin extends AbstractPlugin implements CommandByItemInterface
{
    protected const EVENT_START_RETURN = 'start-return';

    /**
     * {@inheritDoc}
     * - Triggers 'start return' event on a merchant order item.
     *
     * @param \Orm\Zed\Sales\Persistence\SpySalesOrderItem $orderItem
     * @param \Spryker\Zed\Oms\Business\Util\ReadOnlyArrayObject $data
     *
     * @throws \LogicException
     *
     * @return array
     */
    public function run(SpySalesOrderItem $orderItem, ReadOnlyArrayObject $data): array
    {
        $merchantOrderItemTransfer = $this->getFactory()->getMerchantSalesOrderFacade()->findMerchantOrderItem(
            (new MerchantOrderItemCriteriaTransfer())
                ->setIdOrderItem($orderItem->getIdSalesOrderItem())
        );

        if (!$merchantOrderItemTransfer) {
            return [];
        }

        $merchantOmsTriggerRequestTransfer = (new MerchantOmsTriggerRequestTransfer())
            ->setMerchantOmsEventName(static::EVENT_START_RETURN)
            ->addMerchantOrderItem($merchantOrderItemTransfer);

        $transitionCount = $this->getFacade()->triggerEventForMerchantOrderItems($merchantOmsTriggerRequestTransfer);

        if ($transitionCount === 0) {
            throw new LogicException(sprintf(
                'Merchant Order Item #%s transition for event "%s" has not happened.',
                $merchantOrderItemTransfer->getIdMerchantOrderItem(),
                static::EVENT_START_RETURN
            ));
        }

        $itemTransfer = (new ItemTransfer())
            ->setIdSalesOrderItem($orderItem->getIdSalesOrderItem());

        $this->getFactory()->getSalesReturnFacade()->setOrderItemRemunerationAmount($itemTransfer);

        return [];
    }
}

```

</details>

<details>
<summary markdown='span'>src/Pyz/Zed/MerchantOms/Communication/Plugin/Oms/ShipReturnMarketplaceOrderItemCommandPlugin.php</summary>

```php
<?php

namespace Pyz\Zed\MerchantOms\Communication\Plugin\Oms;

class ShipReturnMarketplaceOrderItemCommandPlugin extends AbstractTriggerOmsEventCommandPlugin
{
    protected const EVENT_SHIP_RETURN = 'ship-return';

    /**
     * @return string
     */
    public function getEventName(): string
    {
        return static::EVENT_SHIP_RETURN;
    }
}

```

</details>

<details>
<summary markdown='span'>src/Pyz/Zed/MerchantOms/MerchantOmsDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\MerchantOms;

use Pyz\Zed\MerchantOms\Communication\Plugin\Oms\CancelReturnMarketplaceOrderItemCommandPlugin;
use Pyz\Zed\MerchantOms\Communication\Plugin\Oms\DeliverReturnMarketplaceOrderItemCommandPlugin;
use Pyz\Zed\MerchantOms\Communication\Plugin\Oms\ExecuteReturnMarketplaceOrderItemCommandPlugin;
use Pyz\Zed\MerchantOms\Communication\Plugin\Oms\RefundMarketplaceOrderItemCommandPlugin;
use Pyz\Zed\MerchantOms\Communication\Plugin\Oms\ShipReturnMarketplaceOrderItemCommandPlugin;
use Spryker\Zed\Kernel\Container;
use Spryker\Zed\MerchantOms\MerchantOmsDependencyProvider as SprykerMerchantOmsDependencyProvider;

class MerchantOmsDependencyProvider extends SprykerMerchantOmsDependencyProvider
{
    public const FACADE_SALES_RETURN = 'FACADE_SALES_RETURN';

    protected function getStateMachineCommandPlugins(): array
    {
        return [
            'MarketplaceOrder/Refund' => new RefundMarketplaceOrderItemCommandPlugin(),
            'MarketplaceReturn/CancelReturnForOrderItem' => new CancelReturnMarketplaceOrderItemCommandPlugin(),
            'MarketplaceReturn/DeliverReturnForOrderItem' => new DeliverReturnMarketplaceOrderItemCommandPlugin(),
            'MarketplaceReturn/ExecuteReturnForOrderItem' => new ExecuteReturnMarketplaceOrderItemCommandPlugin(),
            'MarketplaceReturn/ShipReturnForOrderItem' => new ShipReturnMarketplaceOrderItemCommandPlugin(),
        ];
    }

    /**
     * @param \Spryker\Zed\Kernel\Container $container
     *
     * @return \Spryker\Zed\Kernel\Container
     */
    public function provideCommunicationLayerDependencies(Container $container): Container
    {
        $container = parent::provideCommunicationLayerDependencies($container);

        $container = $this->addSalesReturnFacade($container);

        return $container;
    }

    /**
     * @param \Spryker\Zed\Kernel\Container $container
     *
     * @return \Spryker\Zed\Kernel\Container
     */
    public function addSalesReturnFacade(Container $container): Container
    {
        $container->set(static::FACADE_SALES_RETURN, function (Container $container) {
            return $container->getLocator()->salesReturn()->facade();
        });

        return $container;
    }
}
```

</details>

<details>
<summary markdown='span'>src/Pyz/Zed/Oms/OmsDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\Oms;

use Pyz\Zed\MerchantOms\Communication\Plugin\Oms\ReturnMerchantOrderItemCommandPlugin;
use Spryker\Zed\Kernel\Container;
use Spryker\Zed\Oms\Dependency\Plugin\Command\CommandCollectionInterface;
use Spryker\Zed\Oms\OmsDependencyProvider as SprykerOmsDependencyProvider;

class OmsDependencyProvider extends SprykerOmsDependencyProvider
{    
    /**
     * @param \Spryker\Zed\Kernel\Container $container
     *
     * @return \Spryker\Zed\Kernel\Container
     */
    public function provideBusinessLayerDependencies(Container $container): Container
    {
        $container = parent::provideBusinessLayerDependencies($container);

        $container = $this->extendCommandPlugins($container);

        return $container;
    }

    /**
     * @param \Spryker\Zed\Kernel\Container $container
     *
     * @return \Spryker\Zed\Kernel\Container
     */
    protected function extendCommandPlugins(Container $container): Container
    {
        $container->extend(static::COMMAND_PLUGINS, function (CommandCollectionInterface $commandCollection) {
            $commandCollection->add(new ReturnMerchantOrderItemCommandPlugin(), 'MerchantOms/ReturnOrderItem');

            return $commandCollection;
        });

        return $container;
    }
}
```

</details>


<details>
<summary markdown='span'>src/Pyz/Zed/MerchantOms/Communication/MerchantOmsCommunicationFactory.php</summary>

```php
<?php
namespace Pyz\Zed\MerchantOms\Communication;

use Pyz\Zed\MerchantOms\MerchantOmsDependencyProvider;
use Spryker\Zed\MerchantOms\Communication\MerchantOmsCommunicationFactory as SprykerMerchantOmsCommunicationFactory;
use Spryker\Zed\SalesReturn\Business\SalesReturnFacadeInterface;

/**
 * @method \Spryker\Zed\MerchantOms\MerchantOmsConfig getConfig()
 * @method \Spryker\Zed\MerchantOms\Business\MerchantOmsFacadeInterface getFacade()
 * @method \Spryker\Zed\MerchantOms\Persistence\MerchantOmsRepositoryInterface getRepository()
 */
class MerchantOmsCommunicationFactory extends SprykerMerchantOmsCommunicationFactory
{
    /**
     * @return \Spryker\Zed\SalesReturn\Business\SalesReturnFacadeInterface
     */
    public function getSalesReturnFacade(): SalesReturnFacadeInterface
    {
        return $this->getProvidedDependency(MerchantOmsDependencyProvider::FACADE_SALES_RETURN);
    }
}
```

</details>

{% info_block warningBox "Verification" %}

<!--Describe how a developer can check they have completed the step correctly.-->

Make sure that when you create and process return for merchant order items, it's statuses synced between state machines in the following way:

| Marketplace SM     | Default Merchant SM     | Main Merchant SM
| -------- | ------------------- | ---------- |
| Used by Operator	 | Used by 3rd-party Merchant	 | Used by Main Merchant
| start-return (can be started by entering in the Return Flow, it is not manually executable as a button) --> waiting for return	  | start-return (can be started by entering in the Return Flow, it is not manually executable as a button) --> waiting for return	 | start-return (can be started by entering in the Return Flow, it is not manually executable as a button) --> waiting for return
| execute return --> returned   | execute return (manually executable) --> returned 	 | execute return (manually executable) --> returned
| refund --> refunded		  | refund (manually executable) --> refunded	 | refund (manually executable) --> refunded
| cancel return --> return canceled	  | cancel return (manually executable) --> return canceled 	 | cancel return (manually executable) --> return canceled
| ship return --> shipped to customer 	  | ship return (manually executable) --> shipped to customer	 | ship return (manually executable) --> shipped to customer
| deliver return --> delivered		  | deliver return (manually executable) --> delivered	 | deliver return (manually executable) --> delivered

{% endinfo_block %}

<details>
<summary markdown='span'>src/Pyz/Zed/SalesReturnGui/SalesReturnGuiDependencyProvider.php</summary>

```php
<?php

namespace Pyz\Zed\SalesReturnGui;

use Spryker\Zed\MerchantSalesReturnGui\Communication\Plugin\SalesReturnGui\MerchantReturnCreateTemplatePlugin;
use Spryker\Zed\SalesReturnGui\SalesReturnGuiDependencyProvider as SprykerSalesReturnGuiDependencyProvider;

class SalesReturnGuiDependencyProvider extends SprykerSalesReturnGuiDependencyProvider
{
    /**
     * @return \Spryker\Zed\SalesReturnGuiExtension\Dependency\Plugin\ReturnCreateTemplatePluginInterface[]
     */
    protected function getReturnCreateTemplatePlugins(): array
    {
        return [
            new MerchantReturnCreateTemplatePlugin(),
        ];
    }
}

```

</details>

{% info_block warningBox "Verification" %}

Make sure when you open any order on `http://backoffice.de.spryker.local/sales-return-gui` containing products from different merchants, you see the message: "You can only return products from one merchant at a time".

{% endinfo_block %}

Add config for the `SalesReturn`:

<details>
<summary markdown='span'>src/Pyz/Zed/SalesReturn/SalesReturnConfig.php</summary>

```php
<?php

namespace Pyz\Zed\SalesReturn;

use Spryker\Zed\SalesReturn\SalesReturnConfig as SprykerSalesReturnConfig;

class SalesReturnConfig extends SprykerSalesReturnConfig
{
    protected const RETURNABLE_STATE_NAMES = [
        'shipped',
        'delivered',
        'shipped by merchant',
    ];
}
```

</details>

### 6) Configure navigation
Add marketplace section to `navigation.xml`:

**config/Zed/navigation.xml**

```xml
<?xml version="1.0"?>
<config>
    <sales>
        <pages>
            <merchant-sales-return>
                <label>My Returns</label>
                <title>My Returns</title>
                <bundle>merchant-sales-return-merchant-user-gui</bundle>
                <controller>index</controller>
                <action>index</action>
                <visible>1</visible>
            </merchant-sales-return>
        </pages>
    </sales>
    <marketplace>
        <pages>
            <returns>
                <label>Returns</label>
                <title>Returns</title>
                <bundle>sales-return-gui</bundle>
                <controller>index</controller>
                <action>index</action>
                <visible>1</visible>
            </returns>
        </pages>
    </marketplace>
</config>
```

Execute the following command:
```bash
console navigation:build-cache
```

{% info_block warningBox "Verification" %}

Make sure that, in the navigation menu of the Back Office, you can see the menu item **Returns** in the **Marketplace** section and **My Returns** in the **Sales** section.

{% endinfo_block %}


## Install feature front end

Follow the steps below to install the Marketplace return management feature front end.

### 1) Install required modules using Сomposer

<!--Provide the console command\(s\) with the exact latest version numbers of all required modules. If the composer command contains the modules that are not related to the current feature, move them to the [prerequisites](#prerequisites).-->

Install the required modules:

```bash
composer require spryker-feature/marketplace-return-management:"{{page.version}}" --update-with-dependencies
```

{% info_block warningBox "Verification" %}

<!--Describe how a developer can check they have completed the step correctly.-->

Make sure that the following modules have been installed:

| MODULE  | EXPECTED DIRECTORY <!--for public Demo Shops--> |
| -------- | ------------------- |
| MerchantSalesReturnWidget | spryker-shop/merchant-sales-return-widget |

{% endinfo_block %}

### 2) Set up widgets

<!--Provide a list of plugins and global widgets to enable widgets. Add descriptions for complex javascript code snippets. Provide a console command for generating front-end code.-->

Set up widgets as follows:

1. Register the following plugins to enable widgets:

| PLUGIN | SPECIFICATION | PREREQUISITES | NAMESPACE   |
| --------------- | -------------- | ------ | -------------- |
| MerchantSalesReturnCreateFormWidgetCacheKeyGeneratorStrategyPlugin  | Disables widget cache for for the `MerchantSalesReturnCreateFormWidget`. |  |  SprykerShop\Yves\MerchantSalesReturnWidget\Plugin |
| MerchantSalesReturnCreateFormWidget |  Provides "Create Return" only with the items of one merchant order at a time and only for the returnable items. |  |  SprykerShop\Yves\MerchantSalesReturnWidget\Widget |


```php
<?php
namespace Pyz\Yves\ShopApplication;
use SprykerShop\Yves\MerchantSalesReturnWidget\Plugin\MerchantSalesReturnCreateFormWidgetCacheKeyGeneratorStrategyPlugin;
use SprykerShop\Yves\MerchantSalesReturnWidget\Widget\MerchantSalesReturnCreateFormWidget;
class ShopApplicationDependencyProvider extends SprykerShopApplicationDependencyProvider
{
    /**
     * @return string[]
     */
    protected function getGlobalWidgets(): array
    {
        return [
              MerchantSalesReturnCreateFormWidget::class,
        ];
    }
    /**
     * @return \SprykerShop\Yves\ShopApplicationExtension\Dependency\Plugin\WidgetCacheKeyGeneratorStrategyPluginInterface[]
     */
    protected function getWidgetCacheKeyGeneratorStrategyPlugins(): array
    {
        return [
            new MerchantSalesReturnCreateFormWidgetCacheKeyGeneratorStrategyPlugin(),
        ];
    }
}
```

{% info_block warningBox "Verification" %}

<!--Describe how a developer can check they have completed the step correctly.-->

Make sure that the following widgets have been registered by adding the respective code snippets to a Twig template:

| WIDGET | VERIFICATION |
| ---------------- | ----------------- |
| MerchantSalesReturnCreateFormWidget | Go through the Return flow in the same way as now by clicking the **Create Return** button on the top of the *Order Details* page. Go to the *Create Return* page and create a return only with the items of one merchant order at a time and only for returnable items. |

{% endinfo_block %}

2. Enable Javascript and CSS changes:

```bash
console frontend:yves:build
```

## Related features

| FEATURE | REQUIRED FOR THE CURRENT FEATURE | INTEGRATION GUIDE |
| - | - | - |
| Marketplace Return Management API | | [Glue API: Marketplace Return Management feature integration](/docs/marketplace/dev/feature-integration-guides/{{page.version}}/glue/marketplace-return-management-feature-integration.html) |
