---
title: Product feature overview
description: Detailed overview of the Product feature.
last_updated: Jul 9, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/products-overview
originalArticleId: d12e5fdb-b74a-4d9b-91d9-866f330b46df
redirect_from:
  - /2021080/docs/products-overview
  - /2021080/docs/en/products-overview
  - /docs/products-overview
  - /docs/en/products-overview
  - /2021080/docs/product
  - /2021080/docs/en/product
  - /docs/product
  - /docs/en/product
  - /2021080/docs/shop-guide-managing-products
  - /2021080/docs/en/shop-guide-managing-products
  - /docs/shop-guide-managing-products
  - /docs/en/shop-guide-managing-products
  - /docs/scos/user/features/202200.0/product-feature-overview/product-feature-overview.html
---

The *Product* feature allows creating products, manage their characteristics and settings.

In Spryker Commerce OS, you create and manage products in the [Back Office](/docs/scos/user/features/{{page.version}}/spryker-core-back-office-feature-overview/spryker-core-back-office-feature-overview.html). The product information you specify serves multiple purposes:

* Defines product characteristics.
* Affects shop behavior. For example, filtering and search on the Storefront is based on product attributes.
* It's used for internal calculations, like delivery costs based on the product weight.


## Abstract products and product variants

A product can have multiple variants, such as size or color. Such product variations are called *product variants*, or *concrete products*. To distinguish product versions, track their stock, and provide a better shopping experience, product variants are grouped under *abstract products*.

The abstract product is the highest level of the product hierarchy. It does not have its own stock, but defines the properties shared by its product variants. A product variant always belongs to one abstract product, has a distinctive stock, and is always different from another product variant with at least one [super product attribute](/docs/scos/user/features/{{page.version}}/product-feature-overview/product-attributes-overview.html).

The following table shows the differences between abstract products and product variants:

| PRODUCT DATA | ABSTRACT PRODUCT | PRODUCT VARIANT |
| --- | --- | --- |
| SKU | v | v |
| Name | v | v |
| Description | v | v |
| Product attributes | v | v |
| Super attributes |  | v |
| Media assets | v | v |
| Stock |  | v |

### Abstract products and product variants on the Storefront

On the Storefront, only abstract products are displayed in the product catalog and can be searched for.

Product variants are always a part of an abstract product. Abstract product and all its product variants share the same URL.

In this example, a T-shirt, which is an abstract product, is available in sizes S, M, and L, which are three different product variants, each having its own stock. When you search *T-shirt* on the Storefront, it's the abstract product that appears as the search result. A Storefront user can only buy one of the product variants. On the **Product Details** page of the abstract product, they select and add to cart one of the product variants: S, M, L.


### Product information inheritance

Information of a concrete product on the Storefront is a combination of the information of the concrete product and its abstract  product.  

The information of a concrete product always overwrites the information of its abstract product. For example, if the abstract product name is *VGA cable*, and the concrete product name is *VGA cable(1.5m)*, the latter is displayed.
If some information is not specified for a concrete product, it inherits the information from its abstract product. For example, if no price is specified for a concrete product, the price of its abstract product is displayed.

To better understand how abstract and concrete products are processed in a shop, see the following use cases.

#### Case 1: Selling books

Most of the time, books do not have variations. In this case, you create an abstract product and a concrete product per book. The abstract product holds all the information about the product. The concrete product holds the stock information.

#### Case 2: Selling blue and green products

To sell a product in blue and green colors, you create an abstract product and two concrete products. To let your customers select the product variant of which color they want to buy, you create a `color` super attribute.

Suppose the green variant is more expensive than the blue one. In this case, you add the price to the green product variant. The blue variant inherits the price from the abtract product.

The product information is structured as follows:
* The abstract product contains all the information about the product.
* The concrete products contain the following information:
  - The blue variant holds the stock information and the super attribute: `color = blue`.
  - The green variant holds:
    - The stock information.
    - The super attribute: `color = green`.
    - The price, which is different from the abstract product's price.

#### Case 3: Selling a product in five colors, four sizes, and three materials

To a product in five colors, four sizes, and three materials, you can structure product information in one of the following ways. You can create an abstract product and up to 60 variants to support all the combinations. Or, you can use the [Product Groups](/docs/scos/user/features/{{page.version}}/product-groups-feature-overview.html) feature.

Using the Product Group feature, you create a group of five abstract products, one for each color. Each abstract product  contains up to 12 concrete products of different combinations of the sizes and the materials.

The abstract products contain all the information about the product. The product variants hold the stock information and the super attribute of color, size, and material.


## Managing product information in a third-party product information management system

Besides the Back Office, you can maintain product information in an external Product Information Management (PIM) system. The data from the PIM systems can be exported to Spryker. An import interface transforms the incoming product data into a Spryker specific data structure and persists it. After that, the data is exported to Redis and Elasticsearch. This way, the Storefront can access the relevant product data very fast. After the import was finished, you can access the products in the Spryker Back Office.

![Product information management](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Product+Management/Product/product_information_management.png)

The Spryker Commerce OS supports integration of the following PIM systems:

* [Akeneo](/docs/scos/dev/back-end-development/extending-spryker/development-strategies/spryker-os-module-customisation/extending-the-core.html)
* [Censhare PIM](/docs/scos/user/technology-partners/{{page.version}}/product-information-pimerp/censhare-pim.html)
* [Xentral](/docs/scos/user/technology-partners/{{page.version}}/product-information-pimerp/xentral.html)


## Related Business User articles

|BACK OFFICE USER GUIDES|
|---|
| [Get a general idea of Product Attributes](/docs/scos/user/features/{{page.version}}/product-feature-overview/product-attributes-overview.html)  |
| [Get a general idea of Discontinued Products](/docs/scos/user/features/{{page.version}}/product-feature-overview/discontinued-products-overview.html)  |
| [Get a general idea Product Images](/docs/scos/user/features/{{page.version}}/product-feature-overview/product-images-overview.html)  |
| [Get a general idea of Timed Product Availability](/docs/scos/user/features/{{page.version}}/product-feature-overview/timed-product-availability-overview.html)  |
| [Create an abstract product](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/products/manage-abstract-products/creating-abstract-products-and-product-bundles.html) |
| [Edit an abstract product](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/products/manage-abstract-products/editing-abstract-products.html) |
| [Create a product variant](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/products/manage-concrete-products/creating-product-variants.html) |
| [Edit a product variant](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/products/manage-concrete-products/editing-product-variants.html) |
| [Manage products](/docs/scos/user/back-office-user-guides/{{page.version}}/catalog/products/managing-products/managing-products.html) |

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Product feature walkthrough](/docs/scos/dev/feature-walkthroughs/{{page.version}}/product-feature-walkthrough.html) for developers.

{% endinfo_block %}
