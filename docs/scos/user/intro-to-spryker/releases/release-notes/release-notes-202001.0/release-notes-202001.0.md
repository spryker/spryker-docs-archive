---
title: Release Notes 202001.0
last_updated: Jun 16, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/release-notes-2020010
originalArticleId: 8e561ae0-5d15-45d1-934d-94a7c36d4be8
redirect_from:
  - /2021080/docs/release-notes-2020010
  - /2021080/docs/en/release-notes-2020010
  - /docs/release-notes-2020010
  - /docs/en/release-notes-2020010
  - /v5/docs/release-notes-2020010
  - /v5/docs/en/release-notes-2020010
  - /v4/docs/release-notes-2020010
  - /v4/docs/en/release-notes-2020010
  - /v6/docs/release-notes-2020010
  - /v6/docs/en/release-notes-2020010
---

The Spryker Commerce OS is an end-to-end solution for digital commerce. This document contains a business level description of major new features and enhancements released in January of 2020.

For information about installing the Spryker Commerce OS see [Getting Started Guide](/docs/scos/dev/developer-getting-started-guide.html).

## Spryker Commerce OS

### Split Delivery
Spryker now supports **splitting of orders** across multiple delivery addresses during the checkout process.
Starting from this release, besides delivering an order to one address, a customer can choose delivery to multiple addresses as well.
A back-office user can also **split an order** into multiple shipments or modify shipment data on the order details page.
![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image12.png)

#### Compatibility Issues
**Split delivery** is not compatible with the following features:

* Manual Order Entry
* Sales-quantity module with the functionality of order quantity threshold

#### Documentation
[Split Delivery](/docs/scos/user/features/202001.0/order-management-feature-overview/split-delivery-overview.html)

### Decimal Stock
Spryker now supports product stock definition as **decimal** instead of integer. You can define a product stock as
* 1 or 1.00
* 0.0123456789
* 415.51
* 1000
![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image3.png)

#### Documentation
[Packaging Units](/docs/scos/user/features/202001.0/packaging-units-feature-overview.html)

### Improved Packaging Unit
You can set a **decimal amount** for your packages, which allows you to sell products in flexible quantities.
The requirement is to share your package stock with another concrete product. In the previous implementation of **Packaging Units**, it was required to add the *Lead Concrete Product* that was holding the stock for all other concrete products. With the new release creating the *Lead Concrete Product* is optional.
![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image5.png)

#### Documentation
[Packaging Units](/docs/scos/user/features/202001.0/packaging-units-feature-overview.html)

### Improved Scheduled Prices
The **Scheduled Price** feature allows you to define a price for your products that will take effect in the future. Create a scheduled price manually in the Back Office or import them in bulk via CSV files. Starting from this release, you can manage your previously imported **Scheduled Prices** directly in the Back Office.
![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image1.png)

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image8.png)

#### Documentation

* [Scheduled Prices](/docs/scos/user/features/202001.0/scheduled-prices-feature-overview.html)
* [Creating Scheduled Prices in the Back Office](/docs/scos/user/back-office-user-guides/202001.0/catalog/scheduled-prices/creating-scheduled-prices.html)
* [Managing Scheduled Prices in the Back Office](/docs/scos/user/back-office-user-guides/202001.0/catalog/scheduled-prices/managing-scheduled-prices.html)

### Multi-store Improvements
Spryker increases the number of features that you can manage per store.

* First, you can see your stores in the Back Office.
* Second, you can now decide which Payment Methods your customers can use in the checkout process for a given store.
* Third, decide which Warehouses to assign to which stores.
* Fourth, you can now set which Delivery Methods are available to your customers in the checkout process for a given store.
* Fifth, you can perform all those actions in the Back Office.

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image7.png)

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image9.png)

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image2.png)

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image6.png)

#### Documentation

* [Multiple Stores](/docs/scos/dev/tutorials-and-howtos/howtos/howto-set-up-multiple-stores.html)
* [Inventory](/docs/scos/user/features/202001.0/inventory-management-feature-overview.html)
* [Warehouse Management](/docs/scos/user/features/202001.0/inventory-management-feature-overview.html)
* [Managing Payment Methods in the Back Office](/docs/scos/user/back-office-user-guides/202001.0/administration/payment-methods/managing-payment-methods.html)
* [Managing Delivery Methods in the Back Office](/docs/scos/user/back-office-user-guides/202001.0/administration/delivery-methods/creating-and-managing-delivery-methods.html)

***
## CMS
### CMS Templates with Content Slots
Spryker’s Content Management System had a significant upgrade in this release. Our new feature, **Templates with Slots**, incorporates a coherent and flexible way of managing content across the entire Storefront.  
A **Template with Slots** defines the layout and placement of content with a predefined arrangement of Slots. A Slot is a dedicated area for content in a Template, and the Content Manager can easily embed content - CMS Blocks into Slots of different Templates by using the Back Office.
When a **Template with Slots** defines multiple storefront pages, the Block assignment to a Slot could be narrowed down using Visibility Conditions (e.g., Product SKU, Category ID, CMS Page Name).
Out-of-the-box, the B2C and the B2B Demos Shops now come with the following Templates: Home Page, Category pages, Product Detail pages, CMS Pages, and Footer.
Another significant advantage of the **Templates with Slots** feature is that it offers a better integration pattern of a Technology Partner CMS within Spryker. A partner-specific Slot Widget fetches and renders content created in the Technology Partner CMS editor.
Moreover, a project can mix both e-commerce content created in Spryker, and rich media content created in a 3rd party CMS.

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image11.png)

#### Documentation
[Templates and Slots](/docs/scos/user/features/202001.0/cms-feature-overview/templates-and-slots-overview.html)
***
## B2B
### Adding Shipment Cost for the Approval Process
In the **Approval Process**, previously, it was not possible to add shipment cost before submitting an order for approval. This has been solved by moving the Approval action to the Summary page of the checkout and adding shipment cost for it.
![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image4.png)


#### Documentation
[Approval Process](/docs/scos/user/features/202001.0/approval-process-feature-overview.html)

### Configurable Bundle
Configurable Bundle provides a guiding tool to simplify the purchasing of complex product combinations and brings a smooth shopping experience. It allows companies to sell online complex combinations of products that would otherwise require a physical presence in the store.
Configurable bundles are compatible with both B2B & B2C stores but at this point have been only integrated into the B2B Demo Shop.
![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/About/Releases/Release+notes/Release+Notes+202001.0/image10.png)

#### Documentation
[Configurable Bundle](/docs/scos/user/features/202001.0/configurable-bundle-feature-overview.html)
***
## Spryker Glue REST API
In this release, we continue exposing the Storefront functionality for both B2C and B2B.
New endpoints and relevant improvements to the existing ones are now available.

### Product Labels API
There are many scenarios where shop owners want to display labels on product items to increase customers’ engagement and conversion. Product labels were already exposed through the Abstract Product API, and now you can make use of them also with concrete products, cart items, both on guest and regular carts, wishlist items, related products, up-selling products, and alternative products.

#### Documentation
[Product Labels API](/docs/scos/dev/glue-api-guides/202001.0/managing-products/retrieving-product-labels.html)

### Product Discounts API
Shop owners need to be able to offer their customers discounts according to different conditions related to their shopping cart and also to provide them with vouchers to save money on the purchase of specific products or related to their shopping volume. With this API, we enable you to let your customers redeem vouchers and manage them in their carts and checkout and to apply discount rules to their carts according to the predefined conditions.

#### Documentation
[Discounts API](/docs/scos/dev/glue-api-guides/202001.0/retrieving-discounts.html)

#### Ratings and Reviews API
Ratings and reviews are critical for the customer’s purchase decision. Shop owners want to display ratings and reviews related to products on the product page and rating averages on product previews.  With this API, you will be able to display the average rating of a product on the product page, to retrieve the existing ratings and reviews with their abstract and concrete products, to let your customers add a review to a product, to display the average rating and the number of reviews with related products, alternative products, up-selling products, wishlist items and on your catalog’s product reviews.

#### Documentation
[Ratings and Reviews API](/docs/scos/dev/glue-api-guides/202001.0/managing-products/managing-product-ratings-and-reviews.html)

### Product Options API
With this API, you will be able to display a product with its different options each of them with its own price, product option group, and tax set, to display the item in the cart or guest cart with the selected option and to make use of those through the checkout process.

#### Documentation
[Product Options API](/docs/scos/dev/glue-api-guides/{{site.version}}/managing-products/abstract-products/retrieving-abstract-products.html)

### Improved Navigation URLs

Navigation vanity URLs are paramount for marketing purposes. To extend your navigation capabilities and make consistent use of them through all channels and touchpoints, resources such as abstract products and category-nodes now include their vanity URLs in their attributes. The vanity URLs are also included when they appear on search suggestions results.

#### Documentation
[Search Engine Friendly URLs](/docs/scos/dev/glue-api-guides/202001.0/resolving-search-engine-friendly-urls.html)

### Additional API Functionality Provided in this Release:

* Convert guest cart to customer cart on log-in
* Unauthenticated customer permissions
* Spryks for code generation

#### Documentation

* [Assigning Guest Cart to Registered Customer](/docs/scos/dev/glue-api-guides/202001.0/managing-carts/guest-carts/managing-guest-carts.html#assigning-guest-cart-to--registered-customer)
* [Getting the list of protected resources](/docs/scos/dev/glue-api-guides/202001.0/retrieving-protected-resources.html)
* [Managing Customer Access to API Resources](/docs/scos/dev/tutorials-and-howtos/howtos/glue-api-howtos/managing-customer-access-to-glue-api-resources.html)

***
## Docker-SDK

There is a new supported service -  **Swagger UI**. The Swagger UI service together with the following existing services now support configuration:
* Redis
* Swagger UI
* ElasticSearch
* Kibana
* RabbitMQ

It is also possible to choose a specific version of a service to be used.

For production setups, now you can generate optimized docker images.

#### Documentation

* [Getting Started with Docker](/docs/scos/dev/setup/installing-spryker-with-docker/installing-spryker-with-docker.html)
* [Deploy File Reference](/docs/scos/dev/the-docker-sdk/202001.0/deploy-file-reference-1.0.html)
* [Spryker in Docker Services](/docs/scos/dev/the-docker-sdk/202001.0/services.html)


***
## Technical Enhancements
### Elasticsearch 6 Support
The Search module is the main entry point for search customizations boosting sales and emphasizing the best of E-commerce catalog of available products.
With this release, Spryker enabled support for **Elasticsearch 6**, while leaving a room for migration by keeping BC to Elasticsearch 5.6.

Even though Elasticsearch is one of the most powerful search engines available, sometimes its functionalities can not satisfy the most extreme requirements. That’s why from now on Search module supports pluggable search engines. This way, project integrations with Fact Finder, Sphinx, or any other search engine is available and supported by the Spryker infrastructure.

#### Documentation:
[Search Migration Guides](/docs/scos/dev/migration-concepts/search-migration-concept/search-migration-concept.html)

### By-pass KV-storage
Separated Backend and Frontend in Spryker communicate over denormalized distributed datasets with underlying Publish & Synchronize mechanism. This powerful data distribution infrastructure emits data to Storage and Search and enables Frontends’ consumers to reach data without hitting relational DB with the increased performance. Though in some cases (typically B2B), amounts of data are large, and Storage (Redis by default) growth is not justified, especially when a number of customers and RPM is not high.

With this release Publish & Synchronize enables direct access to denormalized data sets stored in a relational DB. Storage consumption could be decreased dramatically with a simple configuration.

To get most of this feature, we recommend to set up master-slave replication and point the Storage to the slave instance, avoiding additional load on the master instance.

#### Documentation
[HowTo - Disable Key-value Storage and use the Database Instead](/docs/scos/dev/tutorials-and-howtos/howtos/howto-replace-key-value-storage-with-database.html)

### Spryker Application
In the previous release, our infrastructure provided **Spryker Application** Instead of deprecated Silex. Spryker Application is served with Application Plugins, which should be used instead of Silex Service Providers. This release completes the migration by providing last missing Application Plugins: security, router, validation, messenger, propel, event dispatcher.

From now on, Silex components become optional, with a clear migration path. A project needs to remove deprecated Service Providers with relevant Application Plugins. Silex Service Providers are still supported until Q3 2020, just make sure your projects depend on a Spryker fork: `spryker/silexphp`, instead of archived `silex/silexphp`.

#### Documentation:
[Silex Migration Guides](/docs/scos/dev/migration-concepts/silex-replacement/silex-replacement.html)

### Health Checks
The Heartbeat functionality is replaced with health checks. There is a new set of endpoints you can use to run health checks for your application services. The endpoints are closed by default for security purposes.

#### Documentation:
[Health Checks](/docs/scos/dev/technical-enhancement-integration-guides/integrating-health-checks.html)

### Queue Manager Optimization
The **Queue manager** functionality is extended with the command that makes queue worker exit right after processing a queue. If the queue is empty, the queue worker exits instead of waiting for the configured execution time to pass.

#### Documentation:

[Tutorial - Handling Data - Publish and Synchronization - Spryker Commerce OS](/docs/scos/dev/back-end-development/data-manipulation/data-publishing/handling-data-with-publish-and-synchronization.html#queue)

### Search Initialization Improvement
To improve usability, the `vendor/bin/console setup:search` command which has been generating two processes, was split into two commands:
    * `console search:create-indexes`
    * `console search:setup:index-map`

#### Documentation
[Search Initialization Improvement](/docs/scos/dev/technical-enhancement-integration-guides/integrating-search-initialization-enhancement.html)

### PHP Update
PHP continuously develops and gets more exciting features. Also, old versions get deprecated, such as PHP7.1, which lost support by the end of 2019. From now on, Spryker modules will require **>=PHP7.2**. Please make sure your project doesn’t rely on deprecated technology and applies required infrastructural upgrades.
While PHP7.2 is a minimum required version, we recommend looking at 7.3 and 7.4 as 7.2 is close to EOL. Such technology upgrades could require additional project refactoring, so please include them in your planning. For more information on the PHP versions see [here](https://www.php.net/supported-versions.php).

Check out [Documentation Updates](/docs/scos/user/intro-to-spryker/whats-new/documentation-updates.html) for all the updates to documentation made with this release.
