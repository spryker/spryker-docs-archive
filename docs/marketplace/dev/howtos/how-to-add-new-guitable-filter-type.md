---
title: "How-To: Create a new Gui table filter type"
description: This articles provides details how to create a new Gui table filter type
template: howto-guide-template
related:
  - title: How to create a new Gui table
    link: docs/marketplace/dev/howtos/how-to-create-gui-table.html
  - title: How to extend an existing Gui table
    link: docs/marketplace/dev/howtos/how-to-extend-gui-table.html
  - title: How to create a new Gui table column type
    link: docs/marketplace/dev/howtos/how-to-add-new-guitable-column-type.html
---

This document describes how to create a new Gui table filter type.

## Prerequisites

To install the Marketplace Merchant Portal Core feature providing the `GuiTable` module, follow the [Marketplace Merchant Portal Core feature integration guide](/docs/marketplace/dev/feature-integration-guides/{{site.version}}/marketplace-merchant-portal-core-feature-integration.html).


## Adjust GuiTableConfigurationBuilder

Add a new `addFilter***()` method to `Spryker\Shared\GuiTable\Configuration\Builder\GuiTableConfigurationBuilder`, where you pass all the required data for a new filter configuration. Define a structure as it will be used by the frontend component (the data will be transformed to arrays and then passed to a frontend as JSON).

```php
    /**
     * @param string $id
     * @param string $title
     *
     * @return $this
     */
    public function addFilterExample(
        string $id,
        string $title
    ) {
        $typeOptionTransfers = (new SelectGuiTableFilterTypeOptionsTransfer());

        $typeOptionTransfers
            ->addValue(
                (new OptionSelectGuiTableFilterTypeOptionsTransfer())
                   ->setValue('value1')
                   ->setTitle('value1title')
            )
            ->addValue(
                 (new OptionSelectGuiTableFilterTypeOptionsTransfer())
                    ->setValue('value2')
                    ->setTitle('value2title')
            );

        $this->filters[] = (new GuiTableFilterTransfer())
            ->setId($id)
            ->setTitle($title)
            ->setType('new-type-name')
            ->setTypeOptions($typeOptionTransfers);

        return $this;
    }
```

See the [Table Filter extension](/docs/marketplace/dev/front-end/table-design/table-filters) to learn more about the Table Filters feature.
