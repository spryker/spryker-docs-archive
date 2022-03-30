---
title: Checkout Workflow Integration Guide
last_updated: Aug 27, 2020
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v6/docs/checkout-workflow-integration
originalArticleId: 9eca2557-c2de-4688-807d-b4aad0da680e
redirect_from:
  - /v6/docs/checkout-workflow-integration
  - /v6/docs/en/checkout-workflow-integration
---

For example let's create alternative checkout workflow which would only save order in database without any additional checks or calculations.

To define an alternative checkout workflow, add a constant to `\Pyz\Shared\Checkout\CheckoutConstants`:

```bash
const KEY_WORKFLOW_ALTERNATIVE_CHECKOUT = 'alternative-checkout';
```

Modify the `getCheckoutWorkflows()` method in `\Pyz\Zed\Checkout\CheckoutDependencyProvider` to define plugins for new workflow:

```php
protected function getCheckoutWorkflows(Container $container)
{
	return [
		CheckoutConstants::KEY_WORKFLOW_MULTISTEP_CHECKOUT => (new CheckoutWorkflowPluginContainer(
			$this->getCheckoutPreConditions($container),
			$this->getCheckoutOrderSavers($container),
			$this->getCheckoutPostHooks($container),
			$this->getCheckoutPreSaveHooks($container)
		)),
		CheckoutConstants::KEY_WORKFLOW_ALTERNATIVE_CHECKOUT => (new CheckoutWorkflowPluginContainer(
		[],
			[
				new SalesOrderSaverPlugin(),
			],
		[],
		[]
		)),
	];
}
```

After this, pass workflow id as a second parameter in the `placeOrder()` call of `CheckoutFacade`.

```bash
$this->getCheckoutFacade()->placeOrder($quoteTransfer, CheckoutConstants::KEY_WORKFLOW_ALTERNATIVE_CHECKOUT);
```
