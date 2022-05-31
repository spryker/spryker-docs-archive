---
title: Marketplace Product Approval Process feature overview
description: This document contains concept information for the Marketplace Product Approval Process feature.
template: concept-topic-template
---
The [marketplace operator](/docs/marketplace/user/intro-to-spryker-marketplace/back-office-for-marketplace-operator.html) is primarily responsible for ensuring the quality of data in the marketplace, including merchants, products, and offers. To control those things in the marketplace, the approval mechanism is a key feature.

The *Marketplace Product Approval Process* allows marketplace owners to verify the products of merchants before showing them to customers.

{% info_block warningBox "Note" %}

The Storefront displays only the products that are approved, active, lie within the validity period, and exist for the defined store.

{% endinfo_block %}

## Product lifecycle

{% info_block warningBox "Note" %}

The following workflow is valid only in case the [Marketplace Product Approval Process feature is enabled](/docs/marketplace/dev/feature-integration-guides/{{page.version}}/marketplace-product-approval-process-feature-integration.html).

{% endinfo_block %}

A product can have one of the following statuses:

| STATUS               | DESCRIPTION                                                  |
| -------------------- | ------------------------------------------------------------ |
| Draft                | When the product is created, it obtains the *draft* status.  |
| Waiting for approval | When the product is sent for approval by a merchant in the Merchant Portal, the status changes to *waiting for approval*. |
| Approved             | The marketplace administrator can  approve the product in the Back Office and in this case the status of the product changes to the *approved* one in the Merchant Portal. The marketplace administrator can cancel the approval procedure and return the product into the *draft* status. |
| Denied               | When the marketplace administrator rejects the product in the Back Office, the product gets *denied* status in the Merchant Portal. The marketplace administrator can cancel the approval procedure and return the product into the *draft* status. |

{% info_block infoBox "Info" %}

You can configure the logic of the statuses on the project level.

{% endinfo_block %}

## Marketplace Product Approval process workflow

If a [merchant](/docs/marketplace/user/features/{{page.version}}/marketplace-merchant-feature-overview/marketplace-merchant-feature-overview.html) wants their new marketplace product to be displayed in the Storefront, this product has to be approved by the marketplace administrator. The procedure goes through the following stages:

1. [**Creating a marketplace product**](/docs/marketplace/user/merchant-portal-user-guides/{{page.version}}/products/abstract-products/creating-marketplace-abstract-product.html).

2. **Submitting the product for approval.** The [merchant user](/docs/marketplace/user/features/{{page.version}}/marketplace-merchant-feature-overview/merchant-users-overview.html) submits the request for product approval in the Merchant Portal. The status of the product changes to *Waiting for approval*.

3. **Product approval or rejection.** The marketplace administrator can view the products and update their statuses in the Back Office. If a product is approved, the approval status changes to *Approved*. If the marketplace administrator rejects a product, the product gets the *Denied* status.

## Marketplace Product Approval data import

A marketplace owner can set a default approval status for marketplace products owned by a certain merchant via the data import. See [File details: merchant_product_approval_status_default.csv](/docs/marketplace/dev/data-import/{{page.version}}/file-details-merchant-product-approval-status-default.csv.html) to learn more how to do that.

## Related Business User articles

| BACK OFFICE USER GUIDES  | MERCHANT PORTAL USER GUIDES  |
| -------------------- | ------------------ |
|  [Approve and deny marketplace products](/docs/marketplace/user/back-office-user-guides/{{page.version}}/catalog/products/managing-products/managing-products.html#approving-and-denying-marketplace-products)  | [Send the product for approval](/docs/marketplace/user/merchant-portal-user-guides/{{page.version}}/products/abstract-products/creating-marketplace-abstract-product.html#sending-the-product-for-approval)   |

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Marketplace Product Approval feature walkthrough](/docs/marketplace/dev/feature-walkthroughs/{{page.version}}/marketplace-product-approval-process-feature-walkthrough.html) for developers.

{% endinfo_block %}