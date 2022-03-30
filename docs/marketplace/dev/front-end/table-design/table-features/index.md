---
title: Table Feature extension
last_updated: Jun 07, 2021
description: This document provides details about the Table Feature extension in the Components Library.
template: concept-topic-template
---

This document explains the Table Feature extension in the Components Library.

## Overview

The table has the ability to add custom features/components to the defined table locations (`TableFeatureLocation`). By default, the table has a simplified view. However, you can embed additional components to the specified locations and extend the table (title, pagination, totals).

A Table Feature is an Angular Component encapsulating a piece of UI that is targeted to a specific location within a Table Component or that may provide additional functionality.

The Table Feature must extend a specific Angular Component (`TableFeatureComponent`) and provide itself as a `TableFeatureComponent` via `ExistingProvider` in the registry.

```ts
// Module augmentation
import { TableFeatureConfig } from '@spryker/table';

declare module '@spryker/table' {
    interface TableConfig {
        custom?: TableCustomFeatureConfig;
    }
}

export interface TableCustomFeatureConfig extends TableFeatureConfig {}

// Component implementation
// Module
import { ModuleWithFeature, TableFeatureModule } from '@spryker/table';

@NgModule({
    imports: [CommonModule, TableFeatureModule],
    exports: [TableCustomFeatureComponent],
    declarations: [TableCustomFeatureComponent],
})
export class TableCustomFeatureModule implements ModuleWithFeature {
    featureComponent = TableCustomFeatureComponent;
}

// Component
@Component({
    selector: 'spy-table-custom-feature',
    ...,
    providers: [
        {
            provide: TableFeatureComponent,
            useExisting: TableCustomFeatureComponent,
        },
    ],
})
export class TableCustomFeatureComponent extends TableFeatureComponent<
    TableCustomFeatureConfig
> {}
```

```html
<ng-container
    *spyTableFeatureTpl="
        tableFeatureLocation.beforeTable; // any location from TableFeatureLocation
        styles: { order: '0' } // custom styles
    "
>
    COMPONENT MARKUP
</ng-container>
```

## Usage and registration

There are two ways to use the Table Feature:

- Via HTML tag (as a component) being projected into the Table Component—this lets users control how the Table Feature is loaded on the page, but it does not control its loading from the Table Configuration.

    ```html
    <spy-table>
        <spy-table-title-feature spy-table-feature></spy-table-title-feature>
    </spy-table>
    ```

    To add a feature via HTML, it's enough to include a feature tag with a custom attribute (`spy-table-feature`) inside a table. When the table content is initialized, the table receives all templates by attribute and initializes features.

- Via the registry of the Table Module — the Table feature can be lazy-loaded when the Table Component requires it based on the Table Configuration, but it does not allow custom loading (custom loading is possible if the Angular versions are the same and shared).

    ```ts
    @NgModule({
        imports: [
            TableModule.withFeatures({
                title: () =>
                    import('@spryker/table.feature.title').then(
                        (m) => m.TableTitleFeatureModule,
                    ),
            }),
        ],
    })
    export class RootModule {}
    ```

To add a feature via the registry, register the feature in the Table Module using static method `TableModule.withFeatures()`. Under the hood, it assigns the object of actions to the `TableFeaturesRegistryToken`. The `TableFeatureLoaderService` injects all registered types from the `TableFeaturesRegistryToken`, `Compiler`, and `Injector`. Upon initialization, the table loads only enabled feature modules and compiles them via Compiler with Injector before initializing them.

In the table configuration, you can enable or disable, and configure any feature.

```html
<spy-table
    [config]="{
        ...,
        title: {
            enabled: true,
            ...,
        },
    }"
>
</spy-table>
```

## Interfaces

Below you can find interfaces for the Table Feature extension configuration.

```ts
export interface ModuleWithFeature {
    featureComponent: Type<TableFeatureComponent>;
}

export interface TableFeatureConfig {
    enabled?: boolean;
    [k: string]: unknown;
}

export enum TableFeatureLocation {
    top = 'top',
    beforeTable = 'before-table',
    header = 'header',
    headerExt = 'header-ext',
    beforeRows = 'before-rows',
    beforeColsHeader = 'before-cols-header',
    beforeCols = 'before-cols',
    cell = 'cell',
    afterCols = 'after-cols',
    afterColsHeader = 'after-cols-header',
    afterRows = 'after-rows',
    afterTable = 'after-table',
    bottom = 'bottom',
    hidden = 'hidden',
}
```

## Table Feature types

There are multiple standard Table Features that are shipped with the UI library:

- [Batch Actions](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-batch-actions.html) - allows triggering batch/multiple actions from rows.
- [Editable](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-editable.html) - allows editing/adding rows of the table
- [Filters](/docs/marketplace/dev/front-end/table-design/table-filters/) - allows filtering the data set.
- [Pagination](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-pagination.html) - renders pagination of the table.
- [Row Actions](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-row-actions.html) - allows triggering actions from rows.
- [Search](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-search.html) - allows searching within the data set.
- [Selectable](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-selectable.html) - allows selecting multiple rows.
- [Settings](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-settings.html) - allows customizing columns of the table (show/hide and reorder).
- [Sync State](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-sync-state.html) - allows syncing the state of the table with browser URL (like pagination, filters, sorting).
- [Title](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-title.html) - renders the title of the table.
- [Total](/docs/marketplace/dev/front-end/table-design/table-features/table-feature-total.html) - renders the total number of the data set.
