---
title: PayOne - Integration into the SCOS Project
description: Integrate Payone into the Spryker Commerce OS by following the instructions from this article.
last_updated: Apr 3, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v5/docs/payone-integration-with-project-scos
originalArticleId: 435d797a-a309-4386-84e3-880beb8f3db1
redirect_from:
  - /v5/docs/payone-integration-with-project-scos
  - /v5/docs/en/payone-integration-with-project-scos
related:
  - title: PayOne - Cash on Delivery
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/scos-integration/payone-cash-on-delivery.html
  - title: PayOne - Authorization and Preauthorization Capture Flows
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-authorization-and-preauthorization-capture-flows.html
  - title: PayOne - Invoice Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-invoice-payment.html
  - title: PayOne - Prepayment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-prepayment.html
  - title: PayOne - Direct Debit Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-direct-debit-payment.html
  - title: PayOne - Security Invoice Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-security-invoice-payment.html
  - title: PayOne - Online Transfer Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-online-transfer-payment.html
  - title: PayOne - Paypal Payment
    link: docs/scos/user/technology-partners/page.version/payment-partners/bs-payone/legacy-demoshop-integration/payone-payment-methods/payone-paypal-payment.html
---

**Objectives:**
* Place order with PayPal express checkout.
* Be redirected to summary page of standard checkout.
* Have a shipping method selector on summary page.

## Frontend Update

To make JavaScript and CSS styles enabled in the Suite, update:
`<root>/tsconfig.json` in section "include":

```php
./vendor/spryker-eco/**/*",
```

Update `<root>/frontend/settings.js`:

add entry to 'paths':

```php
// eco folders
eco: {
 // all modules
 modules: './vendor/spryker-eco'
},
```

add one more directory to `module.exports.find.componentEntryPoints.dirs`:

```php
path.join(context, paths.eco.modules)
```

Run `npm run yves` after applying these changes.
Due to the pending update to Suite, you also have to apply Checkout template `.../src/Pyz/Yves/CheckoutPage/Theme/default/views/payment/payment.twig` update:

```xml
{% raw %}{%{% endraw %} extends template('page-layout-checkout', 'CheckoutPage') {% raw %}%}{% endraw %}

{% raw %}{%{% endraw %} define data = {
 backUrl: _view.previousStepUrl,
 forms: {
 payment: _view.paymentForm
 },
 title: 'checkout.step.payment.title' | trans
} {% raw %}%}{% endraw %}

{% raw %}{%{% endraw %} block content {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} embed molecule('form') with {
 class: 'box',
 data: {
 form: data.forms.payment,
 options: {
 attr: {
 id: 'payment-form'
 }
 },
 submit: {
 enable: true,
 text: 'checkout.step.summary' | trans
 },
 cancel: {
 enable: true,
 url: data.backUrl,
 text: 'general.back.button' | trans
 }
 }
 } only {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} block fieldset {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} for name, choices in data.form.paymentSelection.vars.choices {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} set paymentProviderIndex = loop.index0 {% raw %}%}{% endraw %}
 <h5>{% raw %}{{{% endraw %} ('checkout.payment.provider.' ~ name) | trans {% raw %}}}{% endraw %}</h5>
 <ul>
 {% raw %}{%{% endraw %} for key, choice in choices {% raw %}%}{% endraw %}
 <li class="list__item spacing-y clear">
 {% raw %}{%{% endraw %} embed molecule('form') with {
 data: {
 form: data.form[data.form.paymentSelection[key].vars.value],
 enableStart: false,
 enableEnd: false
 },
 embed: {
 index: loop.index ~ '-' ~ paymentProviderIndex,
 toggler: data.form.paymentSelection[key],
 }
 } only {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} block fieldset {% raw %}%}{% endraw %}
 {% raw %}{{{% endraw %} form_row(embed.toggler, {
 required: false,
 component: molecule('toggler-radio'),
 attributes: {
 'target-selector': '.js-payment-method-' ~ embed.index,
 'class-to-toggle': 'is-hidden'
 }
 }) {% raw %}}}{% endraw %}
 <div class="col col--sm-12 is-hidden js-payment-method-{% raw %}{{{% endraw %}embed.index{% raw %}}}{% endraw %}">
 <div class="col col--sm-12 col--md-6">
 {% raw %}{%{% endraw %} if data.form.vars.template_path is defined {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} set paymentPath = data.form.vars.template_path | split('/') {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} set nameTemplate = paymentPath[1] | replace('_', '-') {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} include view(nameTemplate, paymentPath[0]) ignore missing with {
 form: data.form.parent
 } only {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} else {% raw %}%}{% endraw %}
 {% raw %}{{{% endraw %}parent(){% raw %}}}{% endraw %}
 {% raw %}{%{% endraw %} endif {% raw %}%}{% endraw %}
 </div>
 </div>
 {% raw %}{%{% endraw %} endblock {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} endembed {% raw %}%}{% endraw %}
 </li>
 {% raw %}{%{% endraw %} endfor {% raw %}%}{% endraw %}
 </ul>
 {% raw %}{%{% endraw %} endfor {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} endblock {% raw %}%}{% endraw %}
 {% raw %}{%{% endraw %} endembed {% raw %}%}{% endraw %}
{% raw %}{%{% endraw %} endblock {% raw %}%}{% endraw %}
```

Run `console cache:empty` afterwards to make this template used during rendering.

## Backend Update

First of all we need to provide a URL to Payone module, which will be used to redirect user when the quote is filled with data obtained from PayPal.
 To achieve this, make the following steps:

1. Add custom controller action to `src/Pyz/Yves/Checkout/Controller/CheckoutController.php`:

```php
/**
* @return \Symfony\Component\HttpFoundation\RedirectResponse
*/
public function paypalExpressCheckoutEntryPointAction()
{
$this->getFactory()
->createExpressCheckoutHandler()
->fulfillPostConditionsUntilSummaryStep();
return $this->redirectResponseInternal(CheckoutPageControllerProvider::CHECKOUT_SUMMARY);
}
```
2. Register a new controller action in controller provider:

```php
...
const CHECKOUT_PAYPAL_EXPRESS_CHECKOUT_ENTRY_POINT = 'checkout-paypal-express-checkout-entry-point';
...
protected function defineControllers(Application $app)
{
...
$this->createController('/{checkout}/paypal-express-checkout-entry-point', self::CHECKOUT_PAYPAL_EXPRESS_CHECKOUT_ENTRY_POINT, 'Checkout', 'Checkout', 'paypalExpressCheckoutEntryPoint')
->assert('checkout', $allowedLocalesPattern . 'checkout|checkout')
->value('checkout', 'checkout')
->method('GET');
...
}
```
3. Create `ExpressCheckoutHandler` class `src/Pyz/Yves/CheckoutPage/Handler/ExpressCheckoutHandler.php` with corresponding interface:

```php
namespace Pyz\Yves\CheckoutPage\Handler;
use Generated\Shared\Transfer\ExpenseTransfer;
use Spryker\Client\Cart\CartClientInterface;
use Spryker\Shared\Shipment\ShipmentConstants;
class ExpressCheckoutHandler implements ExpressCheckoutHandlerInterface
{
/**
* @var \Spryker\Client\Cart\CartClientInterface
*/
protected $cartClient;
/**
* @param \Spryker\Client\Cart\CartClientInterface $cartClient
*/
public function __construct(CartClientInterface $cartClient)
{
$this->cartClient = $cartClient;
}
/**
* @return void
*/
public function fulfillPostConditionsUntilSummaryStep()
{
$quoteTransfer = $this->cartClient->getQuote();
$quoteTransfer->addExpense(
(new ExpenseTransfer())->setType(ShipmentConstants::SHIPMENT_EXPENSE_TYPE)
);
}
}
```

4. Add `ExpressCheckoutHandler` related method in `src/Pyz/Yves/CheckoutPage/CheckoutPageFactory.php`:

```php
/**
* @return \Pyz\Yves\CheckoutPage\Handler\ExpressCheckoutHandler
*/
public function createExpressCheckoutHandler()
{
return new ExpressCheckoutHandler(
$this->getCartClient()
);
}
```

5. Extend `ShipmentForm` class to override a property_path option (create `src/Pyz/Yves/Shipment/Form/ShipmentSubForm.php`):

```php
namespace Pyz\Yves\Shipment\Form;
class ShipmentSubForm extends ShipmentForm
{
/**
* @const string
*/
const SHIPMENT_SELECTION_PROPERTY_PATH = self::SHIPMENT_SELECTION;
}
```

6. Adjust summary form by adding a shipment subform in `src/Pyz/Yves/CheckoutPage/Form/Steps/SummaryForm.php`:

```php
class SummaryForm extends AbstractType
{
/**
* Builds the form.
*
* This method is called for each type in the hierarchy starting from the
* top most type. Type extensions can further modify the form.
*
* @see FormTypeExtensionInterface::buildForm()
*
* @param \Symfony\Component\Form\FormBuilderInterface $builder The form builder
* @param array $options The options
*
* @return void
*/
public function buildForm(FormBuilderInterface $builder, array $options)
{
$builder->add(
'shipmentForm',
ShipmentSubForm::class,
array_merge(
$options,
[
'data_class' => ShipmentTransfer::class,
'property_path' => 'shipment',
]
)
);
}
/**
* @param \Symfony\Component\OptionsResolver\OptionsResolver $resolver
*
* @return void
*/
public function configureOptions(OptionsResolver $resolver)
{
$resolver->setRequired('shipmentMethods');
$resolver->setDefaults([
'data_class' => QuoteTransfer::class,
]);
}
/**
* Returns the name of this type.
*
* @return string The name of this type
*/
public function getName()
{
return 'summaryForm';
}
}
```

7. Create shipment subform template for summary page in `src/Pyz/Yves/CheckoutPage/Theme/default/checkout/partials/shipment.twig`:

```php

<div class="row columns">

 {% raw %}{%{% endraw %} set shipmentForm = summaryForm.shipmentForm {% raw %}%}{% endraw %}

 <div class="callout">
  <ul class="no-bullet">

   {% raw %}{%{% endraw %} for name, choices in shipmentForm.idShipmentMethod.vars.choices {% raw %}%}{% endraw %}

   <h4>{% raw %}{{{% endraw %} name {% raw %}}}{% endraw %}</h4>

   {% raw %}{%{% endraw %} for key, choice in choices {% raw %}%}{% endraw %}
   <li>
    <label>
     {% raw %}{{{% endraw %} form_widget(shipmentForm.idShipmentMethod[key], {'attr': {'class': '__toggler'{% raw %}}}{% endraw %}) {% raw %}}}{% endraw %}
     {% raw %}{{{% endraw %} shipmentForm.idShipmentMethod[key].vars.label | raw {% raw %}}}{% endraw %}
    </label>
   </li>
   {% raw %}{%{% endraw %} endfor {% raw %}%}{% endraw %}
   {% raw %}{%{% endraw %} endfor {% raw %}%}{% endraw %}
  </ul>
 </div>
</div>
```

8. Update summary twig template in `src/Pyz/Yves/CheckoutPage/Theme/default/checkout/summary.twig`.
Move `"form_start"` expression to the top of a content section and `"form_end"` to the end:

```php
...
{% raw %}{%{% endraw %} block content {% raw %}%}{% endraw %}
{% raw %}{{{% endraw %} form_start(summaryForm, {'attr': {'class': 'row'{% raw %}}}{% endraw %}) {% raw %}}}{% endraw %}
...
...
...
{% raw %}{{{% endraw %} form_end(summaryForm) {% raw %}}}{% endraw %}
{% raw %}{%{% endraw %} endblock {% raw %}%}{% endraw %}
```

9. Remove `{% raw %}{%{% endraw %} include '@checkout/checkout/partials/voucher-form.twig' {% raw %}%}{% endraw %}` include from summary template. Include `checkout/partials/shipment.twig` in your summary template:

```php
      ...
{% raw %}{{{% endraw %} 'checkout.step.summary.shipping' | trans {% raw %}}}{% endraw %}
      {% raw %}{%{% endraw %} include '@checkout/checkout/partials/shipment.twig' {% raw %}%}{% endraw %}
      ...
```
10. Add shipment form data provider and remove voucher form from summary form collection(It is just an example, if you need voucher form, you need to adjust summary page on your own). In `src/Pyz/Yves/CheckoutPage/Form/FormFactory.php`:

```php
/**
* @param \Generated\Shared\Transfer\QuoteTransfer
*
* @return \Spryker\Yves\StepEngine\Form\FormCollectionHandlerInterface
*/
public function createSummaryFormCollection()
{
return $this->createFormCollection($this->createSummaryFormTypes(), $this->getShipmentFormDataProviderPlugin());
}

....


/**
* @return \Symfony\Component\Form\FormTypeInterface[]
*/
protected function createSummaryFormTypes()
{
return [
$this->createSummaryForm(),
//$this->createVoucherFormType(),
];
}
```
11. Handle shipment form data, when summary form is submitted. Inject two dependencies into `src/Pyz/Yves/CheckoutPage/Process/Steps/SummaryStep.php`:

```php
/**
* @var \Spryker\Client\Calculation\CalculationClientInterface
*/
protected $calculationClient;
/**
* @var \Spryker\Yves\StepEngine\Dependency\Plugin\Handler\StepHandlerPluginCollection
*/
protected $shipmentPlugins;
/**
* @param \Spryker\Yves\ProductBundle\Grouper\ProductBundleGrouperInterface $productBundleGrouper
* @param \Spryker\Client\Cart\CartClientInterface $cartClient
* @param \Spryker\Client\Calculation\CalculationClientInterface $calculationClient
* @param \Spryker\Client\Calculation\CalculationClientInterface $shipmentPlugins
* @param string $stepRoute
* @param string $escapeRoute
*/
public function __construct(
ProductBundleGrouperInterface $productBundleGrouper,
CartClientInterface $cartClient,
CalculationClientInterface $calculationClient,
StepHandlerPluginCollection $shipmentPlugins,
$stepRoute,
$escapeRoute
) {
parent::__construct($stepRoute, $escapeRoute);
$this->productBundleGrouper = $productBundleGrouper;
$this->cartClient = $cartClient;
$this->calculationClient = $calculationClient;
$this->shipmentPlugins = $shipmentPlugins;
}
```

12. Extend `execute` method:

```php
/**
* @param \Symfony\Component\HttpFoundation\Request $request
* @param \Spryker\Shared\Kernel\Transfer\AbstractTransfer|\Generated\Shared\Transfer\QuoteTransfer $quoteTransfer
*
* @return \Generated\Shared\Transfer\QuoteTransfer
*/
public function execute(Request $request, AbstractTransfer $quoteTransfer)
{
$shipmentHandler = $this->shipmentPlugins->get(CheckoutPageDependencyProvider::PLUGIN_SHIPMENT_STEP_HANDLER);
$shipmentHandler->addToDataClass($request, $quoteTransfer);
$this->calculationClient->recalculate($quoteTransfer);
$this->markCheckoutConfirmed($request, $quoteTransfer);
return $quoteTransfer;
}
```

Now, go to checkout and try placing an order with Paypal express checkout.
