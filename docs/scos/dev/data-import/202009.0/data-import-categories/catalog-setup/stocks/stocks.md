---
title: Stocks
search: exclude
last_updated: Aug 27, 2020
template: data-import-template
originalLink: https://documentation.spryker.com/v6/docs/stocks
originalArticleId: 2a96e1c0-442f-4607-ac0e-7fb663b4aa37
redirect_from:
  - /v6/docs/stocks
  - /v6/docs/en/stocks
---

The **Stocks** category contains all data you need to manage stocks in your online store. 
By importing the [product_stock.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/catalog-setup/stocks/file-details-product-stock.csv.html) file you can define the number of product units stored in each of the warehouses.

The table below provides details on the Stocks data importer, its purpose, .csv file, dependencies, and other details. The data importer contains links to .csv files used to import the corresponding data, including specifications of mandatory and unique fields, dependencies, detailed explanations, recommendations, templates, and content examples.

| Data Importer | Purpose | Console Command| File(s) | Dependencies |
| --- | --- | --- | --- |--- |
| **Product Stock**   | Imports information about stock, the number of product units stored in each of the warehouses. |`data:import:product-stock` |[product_stock.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/catalog-setup/stocks/file-details-product-stock.csv.html) |<ul><li>[product_concrete.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/catalog-setup/products/file-details-product-concrete.csv.html)</li><li>[warehouse.csv](/docs/scos/dev/data-import/{{page.version}}/data-import-categories/commerce-setup/file-details-warehouse.csv.html)</li></ul> |
