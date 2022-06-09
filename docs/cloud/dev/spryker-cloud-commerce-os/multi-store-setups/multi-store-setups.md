---
title: Multi-store setups
description: Types of multi-store setups in Spryker Cloud Commerce OS
template: concept-topic-template
---

This document describes the multi-store setups supported by Spryker Cloud Commerce OS.

Currently, the following setups are available:

* Separated: a codebase with dedicated databases per store.
* Shared: a codebase with all the stores sharing a database.


## Shared setup

With the shared setup, stores share a single codebase and databases per region. If there are several stores in a region, they share a single database.


![shared setup diagram](https://spryker.s3.eu-central-1.amazonaws.com/docs/cloud/spryker-cloud-commerce-os/multi-store-setups.md/shared-setup.png)


### Shared setup: When to use

We recommend this setup for simple shops that have two to three stores that don't

### Shared setup: Advantages

* Products, customers, orders, and so on are stored in the same database, which simplifies collaborative management.

* All stores are hosted in the same AWS region.


## Separated setup

With the separated setup, store share the same codebase but have dedicated databases. It is the standard setup.

![separated setup diagram](https://spryker.s3.eu-central-1.amazonaws.com/docs/cloud/spryker-cloud-commerce-os/multi-store-setups.md/separated-setup.png)


### Separated setup: When to use

* The stores are completely different from the perspective of the following:

    * Design

    * Business logic

    * Features or modules

* Separated data management for products, customers, orders, etc. Data sharing and synchronization requires external systems.


### Separated setup: Advantages

* Flexible deployment: since stores are independent of one another, deploy, remove, and scale each store without affecting other stores.

* Flexible URL management. For example, the same product in different stores can have the same URL.

* Flexible management of the configuration of stores: distinct category navigation, product schema details, and users.

* Separate deployment of each database per store: deploy a new version of a store's database without affecting the other stores' databases.

### Separated setup: Integration

New projects are shipped with a separated setup by default. If your project is still on a shared setup, [integrate multi-database logic](/docs/scos/dev/technical-enhancement-integration-guides/integrate-multi-database-logic.html).
