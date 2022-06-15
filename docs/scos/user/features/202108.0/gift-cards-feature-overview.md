---
title: Gift Cards feature overview
description: This article describes general concepts of gift cards, gift card’s purchase and redeeming process, as well as the various use case scenarios.
last_updated: Aug 2, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/gift-cards-feature-overview
originalArticleId: 942e081b-6312-483d-bc93-761af98f1f44
redirect_from:
  - /2021080/docs/gift-cards-feature-overview
  - /2021080/docs/en/gift-cards-feature-overview
  - /docs/gift-cards-feature-overview
  - /docs/en/gift-cards-feature-overview
---

The _Gift Card_ feature lets you create a special product type with a chosen value amount. The purchase of a gift card generates an individual code that can then be used as a payment method during checkout.

A Gift Card is a prepaid certificate entitling its owner to purchase products for the gift card’s value.

When paying for orders with a gift card, the gift cards are considered as an additional payment method. You can use the full balance  or part of the total gift card's value. In the latter case, the remaining value is stored as leftover balance on the original code. You can also use additional gift cards to pay for products. However, gift cards can only be applied for products in the same currency they have been bought.

{% info_block warningBox %}

Gift cards are sensitive data and can be used to pay orders; therefore, keep in mind that they should be protected like real money.

{% endinfo_block %}

In a Spryker-based shop, the gift cards follow the same rules and bought as products and can even be bundles. However, they are purely virtual and do not require shipping. A gift card can be applied as a voucher and redeemed to pay an order. Therefore, the gift cards have two characteristics: a product characteristic and a voucher (+payment method) characteristic. When a gift card is bought, it is treated like a product. When it is applied, it’s a *voucher* that can be used as a payment method.

Gift cards have variants just like abstract products. For example, a New Year Gift Card can have all the different values—50 Euro and 100 Euro. In this case, the New Year Gift Card would be handled like an abstract product, and 50 Euro and 100 Euro gift cards would be its variants.

When a customer puts a gift card to cart, they can change a variant, quantity and remove it from cart, just like any abstract product. It should be noted, however, that no discounts are applied to gift card products since the price paid for the gift card must equal the value of the gift card. Even though technically you can have different amounts for gift card’s price and value (say, the gift card price is 100 Euro, however, the gift card value is 150 Euro), you need to consult your local legislation to make sure it would be legal in your country.
![Gift cards](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Gift+Cards/Gift+Cards+Purchase+and+Redeeming/gift_card.png)

You can't to pay a gift card by using another gift card, even if the order contains other products with the gift card. Also, the range of payment methods that can be used to pay for gift cards can be limited. That is, you can filter out the payment methods for gift cards. Payment methods available for gift cards can be specified in the configuration file. By default, invoice payment method is not available for gift cards to avoid fraud.

After a customer buys a gift card, they get a code sent to the specified email address.

Once the gift card code has been generated, it becomes a voucher that can be used as a payment method.

The following diagram shows the gift card product-voucher transition workflow:
![Gift card product-voucher transition workflow schema](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Gift+Cards/Gift+Cards+Purchase+and+Redeeming/GC+product-voucher+transition.png)

When buying a gift card, the shipment method selection step is skipped on Yves. In the background, there is a “noshipment” constant in the app configuration, which can be selected to configure shipment for a specific type of products, in our case, for gift cards.


When customer buys a gift card, you can use the default OMS states for the GiftCardSubprocess to be displayed on the Storefront, or set custom state names so they would make more sense for the Storefront users. For details about how to set the custom state names on the Storefront for refunded orders, see [HowTo - Display custom names for order item states on the Storefront](https://docs.spryker.com/docs/scos/dev/tutorials-and-howtos/howtos/feature-howtos/howto-display-custom-names-for-order-item-states-on-the-storefront.html).

## Buying with gift cards

With a gift card code in place, users get an alternative payment method to pay for their orders. The payment workflow with the gift card would be as follows:
1. A user puts products into cart, and, assume they have discounts for the products and also apply a voucher.
2. **Order subtotal** is calculated: General products’ prices without discounts.
3. **Order grand total** is calculated: Price including discounts, vouchers, and taxes.
4. **Gift card** is applied: Grand total minus Gift Card value. If the order value is lower or equals the gift card value, the checkout workflow stops here, as the gift card is used to fully pay the order.
5. If the order value is higher than the value of the applied gift, a price to pay is calculated: the remaining sum to be paid using an additional payment method.
6. Payment method selection and payment.

Schematically, the order placement process with a gift card is as follows:
![Order placement process schema](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Gift+Cards/Gift+Cards+Purchase+and+Redeeming/gc_payment_process.png)

In the Back Office, a Back Office user can see whether an order was paid with a gift card or regular payment method. The amount paid with the gift card as well as the amount paid with a regular payment method (if applicable) are shown as well.
![Gift card payment method](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Gift+Cards/Gift+Cards+Purchase+and+Redeeming/gift_card_payment_method.png)

## Gift card value checking strategies

Gift card value checking strategy means the way the gift cards are checked for the value they represent. There are two strategies that can be followed: Replacement and Balance. Out of the box, Replacement strategy is applied for the gift cards in a Spryker shop. However, which strategy to use can be defined on a project level, by installing a respective module and enabling a plugin.

### Replacement strategy

Replacement means that if after using a gift card it has some remaining balance, a new gift card with the value equal to the remaining balance is issued for the gift card owner. For example, a user has a gift card for 100 Euro, but spends just 60 Euro to pay the order. In this case, a new 40 Euro gift card with a new code will be sent to the user. The old gift card code would not be valid anymore.

For this strategy, gift cards have a pattern for codes generation. For each gift card code generation, a pattern from the previous gift card is used. For example, if the code X-GC-{number} is used for gift cards generation, where {number} is the pattern, the 100 Euro gift card code generated for customers would be X-GC-1, and the code generated for the remaining 40 Euro would be X-GC-2.

The main advantage of this strategy is that one and the same gift card code can not be used twice if the gift card has some remaining balance after a purchase has been made. This might be especially useful, for example, in case when a customer wants another customer to use a part of the value from their gift card. In this case, the initial gift card owner would get an email with the new code for the remaining gift card value.

### Balance strategy

In the case of the Balance strategy, gift card purchase history and gift card balance information are checked. If after paying an order a gift card has some remaining balance, then, in contrast to the Replacement strategy, the user does not get a new gift card code with the new gift card value, but the old gift card code is used instead. The remaining gift card value is calculated by the following formula: GC Value - Value of all orders where it is used.

With this strategy, a Back Office user will see gift card balance information: a date when the gift card was used, a customer who used it, a gift card code and spent value.

Even though the Balance strategy is a bit more complicated than Replacement, it provides the shop owner with detailed information about the gift card as well as the purchase history. From the customer’s perspective, this strategy might be a better option if a gift card is used by one person and it does not make sense to send emails with new codes every time a gift card was used.

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Gift Cards feature walkthrough](/docs/scos/dev/feature-walkthroughs/{{page.version}}/gift-cards-feature-walkthrough.html) for developers.

{% endinfo_block %}
