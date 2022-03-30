---
title: Retrieving Customer's Order History
last_updated: May 16, 2019
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v1/docs/retrieving-order-history
originalArticleId: 16d6503d-10ad-4a6a-8076-de730d45d124
redirect_from:
  - /v1/docs/retrieving-order-history
  - /v1/docs/en/retrieving-order-history
---

For every registered customer, there is an order history retrievable. The list of orders, as well as detailed order information including every step of the calculation and addresses used in the orders, is available for retrieval.

In your development, this resource can help you to:

* Make the order history available to customers
* Make order details available to enable reordering functionality

The **Order History API** allows you to retrieve all orders made by a registered customer.

{% info_block warningBox "Authentication" %}
Since order history is available for registered users only, the endpoints provided by the API cannot be accessed anonymously. For this reason, you always need to pass a user's authentication token in your REST requests. For details on how to authenticate a user and retrieve the token, see [Authentication and Authorization]().
{% endinfo_block %}

## Installation
For detailed information on the modules that provide the API functionality and related installation instructions, see Order History API.

## Getting Customer's Orders
To retrieve a list of all orders made by a registered customer, send a GET request to the following endpoint:
`/orders`
Sample request: `GET http://mysprykershop.com/orders`
**Sample Response:**

| Field* | Type | Description |
| --- | --- | --- |
| createdAt | String | Date and time when the order was created. |
| expenseTotal | Integer | Total amount of expenses (e.g. shipping costs). |
| discountTotal | Integer | Total amount of discounts applied to the order. |
| taxTotal | Integer | Total amount of taxes paid. |
| subtotal | Integer | Subtotal of the order. |
| grandTotal | Integer | Grand total of the order. |
| canceledTotal | Integer | Total canceled amount. |
| currencyIsoCode | String | Currency that was selected when placing the order. |
| priceMode | String | Price mode that was active when placing the order. |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.
 

The endpoint responds with a RestOrdersResponse. The following is an example of a response for a customer that has placed 1 order:

**Response sample:**
```js
{
		"data": [
			{
				"type": "orders",
				"id": "DE--1",
				"attributes": {
					"createdAt": "2018-11-01 17:57:14.354849",
					"totals": {
						"expenseTotal": 490,
						"discountTotal": 30237,
						"taxTotal": 42746,
						"subtotal": 297470,
						"grandTotal": 267723,
						"canceledTotal": 0
					},
					"currencyIsoCode": "EUR",
					"priceMode": "GROSS_MODE"
				},
				"links": {
					"self": "http://mysprykershop.com/orders/DE--1"
				}
			}
		],
		"links": {
			"self": "http://mysprykershop.com/orders"
		}
	}
```
In the response, each order will have an ID specified in the **id** attribute that can be used to retrieve detailed information on the order. Also, **self** links will be provided to access each order individually.

## Paging Through Orders
By default, the above request will return all orders placed by a customer. However, you can also enable paging and receive results in pages of a limited size. For this purpose, use the **limit** and **offset** parameters in your request:
| URL | Description |
| --- | --- |
| /orders | Returns all orders made by a customer. |
| /orders?limit=10 | Returns maximum 10 orders. |
| /orders?offset=10&limit=10 | Returns orders 11 through 20. |
| /orders?offset=20 | Returns all orders starting from the 21st to the end. |

When paging is enabled, the **links** section of the JSON response will contain links for the first, previous, next and last pages.

**Sample response**
```js
{
		"data": [
			{
				"type": "orders",
				"id": "DE--1",
				"attributes": {
					"createdAt": "2018-11-01 17:57:14.354849",
					"totals": {
						"expenseTotal": 490,
						"discountTotal": 30237,
						"taxTotal": 42746,
						"subtotal": 297470,
						"grandTotal": 267723,
						"canceledTotal": 0
					},
					"currencyIsoCode": "EUR",
					"priceMode": "GROSS_MODE"
				},
				"links": {
					"self": "http://mysprykershop.com/orders/DE--1"
				}
			}
		],
		"links": {
			"self": "http://mysprykershop.com/orders?page[offset]=2&page[limit]=2",
			"last": "http://mysprykershop.com/orders?page[offset]=2&page[limit]=2",
			"first": "http://mysprykershop.com/orders?page[offset]=0&page[limit]=2",
			"prev": "http://mysprykershop.com/orders?page[offset]=0&page[limit]=2"
		}
	}
```

## Retrieving Specific Order
To retrieve detailed information on a specific order, including the items that the customer ordered, use the following endpoint:
`/orders/{% raw %}{{{% endraw %}order_id{% raw %}}}{% endraw %}`
Sample request: `GET http://mysprykershop.com/orders/DE--1`
where `DE--1` is the ID of the order you want to retrieve.
**Sample Response:**
**General Order Information**
| Field* | Type | Description |
| --- | --- | --- |
| createdAt | String | Date and time when the order was created. |
| expenseTotal | Integer | Total amount of expenses (e.g. shipping costs). |
| discountTotal | Integer | Total amount of discounts applied to the order. |
| taxTotal | Integer | Total amount of taxes paid. |
| subtotal | Integer | Subtotal of the order. |
| grandTotal | Integer | Grand total of the order. |
| canceledTotal | Integer | Total canceled amount. |
| currencyIsoCode | String | Currency that was selected when placing the order. |
| priceMode | String | Price mode that was active when placing the order. |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

**Order Item Information**
| Field* | Type | Description |
| --- | --- | --- |
| name | String | Name of the product. |
| sku | String | SKU of the product. |
| sumPrice | Integer | Sum of the prices. |
| sumPriceToPayAggregation | Integer | Sum of the prices to pay (after discounts). |
| quantity | Integer | Quantity of the product ordered. |
| superAttributes | String | Since the bought product is a concrete product, and super attributes are saved with the abstract product, this field is expected to stay empty. |
| image | String | URL to an image of the product. |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

**Calculated discounts for items**
| Field* | Type | Description |
| --- | --- | --- |
| unitAmount | Integer | Discount value applied to each order item of the corresponding product. |
| sumAmount | Integer | Sum of the discount values applied to the order items of the corresponding product. |
| displayName | String | Name of the discount applied. |
| description | String | Description of the discount. |
| voucherCode | String | Voucher code redeemed. |
| quantity | String | Number of discounts applied to the corresponding product. |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

**Item Calculation**
| Field* | Type | Description |
| --- | --- | --- |
| unitGrossPrice | Integer | Single item gross price. |
| sumGrossPrice | Integer | Sum of items gross price. |
| taxRate | Integer | Current tax rate in percentage. |
| unitNetPrice | Integer | Single item net price. |
| sumNetPrice | Integer | Sum of items net price. |
| unitPrice | Integer | Single item price without assuming if it is new or gross, this value should be used everywhere the price is displayed, it allows switching tax mode without side effects. |
| unitTaxAmountFullAggregation | Integer | Total tax amount for a given item with additions. |
| sumTaxAmountFullAggregation | Integer | Total tax amount for a given sum of items with additions. |
| refundableAmount | Integer | Available refundable amount for an item (order only). |
| canceledAmount | Integer | Total canceled amount for this item (order only). |
| sumSubtotalAggregation | Integer | Sum of subtotals of the items. |
| unitSubtotalAggregation | Integer | Subtotal for the given item. |
| unitProductOptionPriceAggregation | Integer | Item total product option price. |
| sumProductOptionPriceAggregation | Integer | Item total of product options for the given sum of items. |
| unitExpensePriceAggregation | Integer | Item expense total for a given item. |
| sumExpensePriceAggregation | Integer | Sum of item expense totals for the items. |
| unitDiscountAmountAggregation | Integer | Item total discount amount. |
| sumDiscountAmountAggregation | Integer | Sum of Item total discount amount. |
| unitDiscountAmountFullAggregation | Integer | Sum of Item total discount amount. |
| sumDiscountAmountFullAggregation | Integer | Item total discount amount with additions. |
| unitPriceToPayAggregation | Integer | Item total price to pay after discounts with additions. |
| taxRateAverageAggregation | Integer | Item tax rate average, with additions used when recalculating tax amount after cancellation. |
| taxAmountAfterCancellation | Integer | Tax amount after cancellation, recalculated using tax average. |


\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

**Expenses**
| Field* | Type | Description |
| --- | --- | --- |
| sumPrice | Integer | Sum of items' price calculated. |
| unitGrossPrice | Integer | Single item's gross price. |
| sumGrossPrice | Integer | Sum of items' gross price. |
| taxRate | Integer | Current tax rate in percentage. |
| unitNetPrice | Integer | Single item net price. |
| sumNetPrice | Integer | Sum of items' net price. |
| canceledAmount | Integer | Total canceled amount for this item (order only). |
| unitDiscountAmountAggregation | Integer | Item total discount amount. |
| sumDiscountAmountAggregation | Integer | Sum of items' total discount amount. |
| unitTaxAmount | Integer | Tax amount for a single item after discounts. |
| sumTaxAmount | Integer | Tax amount for a sum of items (order only). |
| unitPriceToPayAggregation | Integer | Item total price to pay after discounts with additions. |
| sumPriceToPayAggregation | Integer | Sum of items' total price to pay after discounts with additions. |
| taxAmountAfterCancellation | Integer | Tax amount after cancellation, recalculated using tax average. |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

**Billing and Shipping Addresses**
| Field* | Type | Description |
| --- | --- | --- |
| salutation | String | Salutation to use when addressing the customer. |
| firstName | String | Customer's first name. |
| lastName | String | Customer's last name. |
| address1 | String | The 1st line of the customer's address. |
| address2 | String | The 2nd line of the customer's address. |
| address3 | String | The 3rd line of the customer's address. |
| zipCode | String | ZIP code. |
| city | String | Specifies the city. |
| country | String | Specifies the country. |
| company | String | Specifies the customer's company. |
| phone | String | Specifies the customer's phone number. |
| isDefaultShipping | String | Specifies whether the address should be used as the default shipping address of the customer. If the parameter is not set, the default value is **true**. This is also the case for the first address to be saved. |
| isDefaultBilling | String | Specifies whether the address should be used as the default billing address of the customer. If the parameter is not set, the default value is **true**. This is also the case for the first address to be saved. |
| iso2Code | String | Specifies an ISO 2 Country Code to use. |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

**Payments**
| Field* | Type | Description |
| --- | --- | --- |
| amount | Integer | Amount paid via the corresponding payment provider in cents. |
| paymentProvider | String | Name of the payment provider. |
| paymentMethod | String | Name of the payment method. |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

If the specified order exists, the endpoint will respond with a **RestOrdersResponse** containing detailed order information, including the items ordered.

**Sample response**
```js
{
		"data": {
			"type": "orders",
			"id": "DE--1",
			"attributes": {
				"createdAt": "2018-11-01 17:57:14.354849",
				"totals": {
					"expenseTotal": 490,
					"discountTotal": 30237,
					"taxTotal": 42746,
					"subtotal": 297470,
					"grandTotal": 267723,
					"canceledTotal": 0
				},
				"currencyIsoCode": "EUR",
				"items": [
					{
						"name": "Canon PowerShot N",
						"sku": "035_17360369",
						"sumPrice": 297470,
						"sumPriceToPayAggregation": 267723,
						"quantity": 10,
						"metadata": {
							"superAttributes": [],
							"image": "//images.icecat.biz/img/gallery_mediums/17360369_3328.jpg"
						},
						"calculatedDiscounts": [
							{
								"unitAmount": 2975,
								"sumAmount": 29747,
								"displayName": "10% Discount for all orders above",
								"description": "Get a 10% discount on all orders above certain value depending on the currency and net/gross price. This discount is not exclusive and can be combined with other discounts.",
								"voucherCode": null,
								"quantity": 10
							}
						],
						"unitGrossPrice": 29747,
						"sumGrossPrice": 297470,
						"taxRate": "19.00",
						"unitNetPrice": 0,
						"sumNetPrice": 0,
						"unitPrice": 29747,
						"unitTaxAmountFullAggregation": 4275,
						"sumTaxAmountFullAggregation": 42746,
						"refundableAmount": 267723,
						"canceledAmount": 0,
						"sumSubtotalAggregation": 297470,
						"unitSubtotalAggregation": 29747,
						"unitProductOptionPriceAggregation": 0,
						"sumProductOptionPriceAggregation": 0,
						"unitExpensePriceAggregation": 0,
						"sumExpensePriceAggregation": null,
						"unitDiscountAmountAggregation": 2975,
						"sumDiscountAmountAggregation": 29747,
						"unitDiscountAmountFullAggregation": 2975,
						"sumDiscountAmountFullAggregation": 29747,
						"unitPriceToPayAggregation": 26772,
						"taxRateAverageAggregation": "19.00",
						"taxAmountAfterCancellation": null
					}
				],
				"expenses": [
					{
						"type": "SHIPMENT_EXPENSE_TYPE",
						"name": "Standard",
						"sumPrice": 490,
						"unitGrossPrice": 490,
						"sumGrossPrice": 490,
						"taxRate": "19.00",
						"unitNetPrice": 0,
						"sumNetPrice": 0,
						"canceledAmount": null,
						"unitDiscountAmountAggregation": null,
						"sumDiscountAmountAggregation": null,
						"unitTaxAmount": 0,
						"sumTaxAmount": 0,
						"unitPriceToPayAggregation": 0,
						"sumPriceToPayAggregation": 0,
						"taxAmountAfterCancellation": null
					}
				],
				"billingAddress": {
					"salutation": "Mr",
					"firstName": "Jason",
					"middleName": null,
					"lastName": "Voorhees",
					"address1": "123 Sleep Street",
					"address2": "123",
					"address3": null,
					"company": null,
					"city": "CatCity",
					"zipCode": "12345",
					"poBox": null,
					"phone": null,
					"cellPhone": null,
					"description": null,
					"comment": null,
					"email": null,
					"country": "Germany",
					"iso2Code": "DE"
				},
				"shippingAddress": {
					"salutation": "Mr",
					"firstName": "Jason",
					"middleName": null,
					"lastName": "Voorhees",
					"address1": "123 Sleep Street",
					"address2": "123",
					"address3": null,
					"company": null,
					"city": "CatCity",
					"zipCode": "12345",
					"poBox": null,
					"phone": null,
					"cellPhone": null,
					"description": null,
					"comment": null,
					"email": null,
					"country": "Germany",
					"iso2Code": "DE"
				},
				"priceMode": "GROSS_MODE",
				"payments": [
					{
						"amount": 267723,
						"paymentProvider": "DummyPayment",
						"paymentMethod": "invoice"
					}
				],
				"calculatedDiscounts": [
					{
						"unitAmount": 490,
						"sumAmount": 490,
						"displayName": "Free standard delivery",
						"description": "Free standard delivery for all orders above certain value depending on the currency and net/gross price. This discount is not exclusive and can be combined with other discounts.",
						"voucherCode": null,
						"quantity": 1
					},
					{
						"unitAmount": 2975,
						"sumAmount": 29747,
						"displayName": "10% Discount for all orders above",
						"description": "Get a 10% discount on all orders above certain value depending on the currency and net/gross price. This discount is not exclusive and can be combined with other discounts.",
						"voucherCode": null,
						"quantity": 10
					}
				]
			},
			"links": {
				"self": "http://mysprykershop.com/orders/DE--1"
			}
		}
	}
```
