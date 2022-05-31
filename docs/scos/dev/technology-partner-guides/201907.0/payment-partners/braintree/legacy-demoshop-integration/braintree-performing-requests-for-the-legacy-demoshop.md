---
title: Braintree - Performing Requests for the Legacy Demoshop
description: This article contains information on the state machine commands and conditions for the Braintree module in the Spryker Legacy Demoshop.
last_updated: Nov 22, 2019
template: concept-topic-template
originalLink: https://documentation.spryker.com/v3/docs/braintree-requests-legacy-demoshop
originalArticleId: b29e0b7c-d8bd-4b4a-b95b-6d1ba86d8527
redirect_from:
  - /v3/docs/braintree-requests-legacy-demoshop
  - /v3/docs/en/braintree-requests-legacy-demoshop
  - /docs/scos/dev/technology-partner-guides/201907.0/payment-partners/braintree/braintree-guides-for-the-legacy-demoshop/braintree-performing-requests-for-the-legacy-demoshop.html
related:
  - title: Braintree
    link: docs/scos/user/technology-partners/page.version/payment-partners/braintree.html
  - title: Braintree - Request workflow for Legacy Demoshop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/braintree/braintree-guides-for-the-legacy-demoshop/braintree-workflow-for-legacy-demoshop.html
  - title: Braintree - Configuration for the Legacy Demoshop
    link: docs/scos/dev/technology-partner-guides/page.version/payment-partners/braintree/braintree-guides-for-the-legacy-demoshop/braintree-configuration-for-the-legacy-demoshop.html
---

To perform the needed requests, you can easily use the implemented state machine commands and conditions. The next section gives a summary of them. You can also use the facade methods directly which, however, are invoked by the state machine.

## Braintree State Machine Commands and Conditions

### Commands

<b>Authorize</b>

* Authorize the payment by validating the given payment data
* Response:
  - Success: Payment Details accepted
  - Declined: Request format error, payment details not accepted
* Plugin: `AuthorizePlugin`

<b>Revert</b>

* Revert a previous pre-authorization call
* Always reverts the complete pre-check or authorization
* Plugin: `RevertPlugin`

<b>Capture</b>

* Capture of previous (p)re-authorization call Response:
  - Success: Previous (p)re-authorization still valid and accepted
  - Declined: Previous (p)re- authorization expired, request format error, or internal error
* Plugin: `CapturePlugin`

<b>Refund</b>

* Refund previous captured amount
* Full and partial refunds possible
* Response:
  - Success: Refund possible and accepted
  - Declined: Previous capture to far in the past, request format error, or internal
* Plugin: `RefundPlugin`

### Conditions

| Name | Description | Plugin |
| --- | --- | --- |
| `IsAuthorizationApproved` | Checks transaction status log for successful authorization response | `IsAuthorizationApprovedPlugin` |
| `IsReversalApproved` | Checks transaction status log for successful reversal response | `IsReversalApprovedPlugin` |
| `IsCaptureApproved` | Checks transaction status log for successful capture response | `IsCaptureApprovedPlungin` |
| `IsRefundApproved` | Checks transaction status log for successful refund response | `IsRefundApprovedPlugin` |

## Braintree Facade

| Facade Method | Param | Return | Description |
| --- | --- | --- | --- |
| `saveOrderPayment` | `QuoteTransfer``CheckoutResponseTransfer` | void | Saves order payment method data according to quote and checkout response transfer data. |
| `preCheckPayment` | `QuoteTransfer` | `BraintreeTransactionResponseTransfer` | Sends pre-authorize payment request to Braintree gateway to retrieve transaction data.Checks that form data matches transaction response data. |
| `authorizePayment` | `TransactionMetaTransfer` | `BraintreeTransactionResponseTransfer` | Processes payment confirmation request to Braintree gateway. |
| `capturePayment` | `TransactionMetaTransfer` | `BraintreeTransactionResponseTransfer` | Processes capture payment request to Braintree gateway. |
| `revertPayment` | `TransactionMetaTransfer` | `BraintreeTransactionResponseTransfer` | Processes cancel payment request to Braintree gateway. |
| `refundPayment` | `SpySalesOrderItem[]``SpySalesOrder` | `BraintreeTransactionResponseTransfer` | Calculate `RefundTransfer` for given `$salesOrderItems` and `$salesOrderEntity`.Processes refund request to Braintree gateway by calculated `RefundTransfer`. |
| `isAuthorizationApproved` | `OrderTransfer` | bool | Checks if pre-authorization API request got success response from Braintree gateway. |
| `isReversalApproved` | `OrderTransfer` | bool | Checks if cancel API request got success response from Braintree gateway. |
| `isCaptureApproved` | `OrderTransfer` | bool | Checks if capture API request got success response from Braintree gateway. |
| `isRefundApproved` | `OrderTransfer` | bool | Checks if refund API request got success response from Braintree gateway. |
| `postSaveHook` | `OrderTransfer``CheckoutResponseTransfer` | `CheckoutResponseTransfer` | Execute post-save hook. |
