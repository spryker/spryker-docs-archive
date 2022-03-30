---
title: Table Column Type extension
description: This document provides details about the Table Column Type extension in the Components Library.
template: concept-topic-template
---

This document explains the Table Column Type extension in the Components library.

## Overview

Column Type is an Angular Component that describes how a specific type of the column is rendered within a table column.

Check out the following example to see how to configure columns in the table config:

```html
<spy-table
    [config]="{
        ...,
        columns: [
            ...
            {
                id: 'columnId',
                title: 'Column Title',
                type: 'COLUMN_TYPE',
                typeOptions: {
                    // ... COLUMN_TYPE Options
                },
            },
            ...
       ]
  }"
>
</spy-table>
```

## Main Services/Decorators/Components

Using the table module, any table column can be registered by key via the static method `TableModule.withColumnComponents()`.
It assigns the object of columns to the `TableColumnComponentsToken` under the hood.

### ColumnTypeOption decorator

By using the `ColumnTypeOption` decorator, properties of columns can be validated at runtime. The `ColumnTypeOptions` interface shows all the properties.

### TableColumnTypeComponent decorator

The `TableColumnTypeComponent` decorator merges the default config parameters from the argument with the dynamic config parameters from the table.

## TableColumnRendererComponent

The `TableColumnRendererComponent` is used by the table to render each column based on the configuration and data.

## Table Column

As an Angular Component, Table Column must implement specific interface (`TableColumnTypeComponent`) and be registered on the Table Module via its `TableModule.withColumnComponents()` method by passing a string that will be associated with it when rendering.

It is also necessary to create your own column module and add it to the RootModule.

```ts
// Module augmentation
import {
    ColumnTypeOption,
    TableColumnTypeComponent,
    TableColumnComponent,
    TableColumnContext,
} from '@spryker/table';

declare module '@spryker/table' {
    interface TableColumnTypeRegistry {
        custom: CustomTableColumnConfig;
    }
}

// Component implementation
@Injectable({ providedIn: 'root' })
export class CustomTableColumnConfig {
    @ColumnTypeOption({
        type: ColumnTypeOptionsType.AnyOf,
        value: [String, Boolean],
    })
    customOption? = 'customOption';
}

// Module
@NgModule({
    ...,
    declarations: [CustomTableColumnComponent],
    exports: [CustomTableColumnComponent],
})
export class CustomTableColumnModule {}

// Component
@Component({
    ...
})
@TableColumnTypeComponent(TableColumnTextConfig)
export class CustomTableColumnComponent
    implements TableColumnComponent<CustomTableColumnConfig> {
    @Input() config?: CustomTableColumnConfig;
    @Input() context?: TableColumnContext;
}

// Root module
@NgModule({
    imports: [
        TableModule.withColumnComponents({
            custom: CustomTableColumnComponent,
        }),
        CustomTableColumnModule,
    ],
})
export class RootModule {}
```

### Context interpolation

Check out an example of getting a Table Column config value from the context:

```ts
// Module
import { ContextModule } from '@spryker/utils';

@NgModule({
    imports: [CommonModule, ContextModule],
    exports: [CustomTableColumnModule],
    declarations: [CustomTableColumnModule],
})
export class CustomTableColumnModule {}

// Component
@Injectable({ providedIn: 'root' })
export class CustomTableColumnConfig {
    @ColumnTypeOption()
    propName? = this.contextService.wrap('displayValue');

    constructor(private contextService: ContextService) {}
}
```

```html
// Usage
<div
    [propName]="config.propName | context: context"
/>
```

## Interfaces

Below you can find interfaces for the Table Column Type extension configuration.

```ts
export interface TableColumnComponent<C = any> {
    config?: C;
    context?: TableColumnContext;
}

export interface ColumnTypeOptions {
    /** Is it required */
    required?: boolean;
    /** Expected type. Specify exact type in {@link value} prop */
    type?: ColumnTypeOptionsType;
    /** Value type. See {@link ColumnTypeOptionsType} for more details.
     * May be recursive for some types */
    value?: unknown | ColumnTypeOptions;
}

export enum ColumnTypeOptionsType {
    /** Value will be compared with strict equality */
    Literal = 'literal',
    /** Value must be any Javascript type (String, Number)  */
    TypeOf = 'typeOf',
    /** Value will be compared with every array item. May be recursive */
    ArrayOf = 'arrayOf',
    /** Value must be an array of other types. May be recursive */
    AnyOf = 'anyOf',
}
```

## Table Column types

UI library comes with a number of standard column types that can be used on any project:

- [Autocomplete](/docs/marketplace/dev/front-end/table-design/table-column-types/table-column-type-autocomplete.html) - renders `@spryker/input` and `@spryker/autocomplete` components.
- [Chip](/docs/marketplace/dev/front-end/table-design/table-column-types/table-column-type-chip.html) - renders `@spryker/chip` component.
- [Date](/docs/marketplace/dev/front-end/table-design/table-column-types/table-column-type-date.html) - renders a formatted date by `config`.
- [Dynamic](/docs/marketplace/dev/front-end/table-design/table-column-types/table-column-type-dynamic.html) - is a higher-order column that gets `ColumnConfig` from the configured `Datasource` and renders a column with the retrieved `ColumnConfig`.
- [Image](/docs/marketplace/dev/front-end/table-design/table-column-types/table-column-type-image.html) - renders an image.
- [Input](/docs/marketplace/dev/front-end/table-design/table-column-types/table-column-type-input.html) - renders `@spryker/input` component.
- [List](/docs/marketplace/dev/front-end/table-design/table-column-types/table-column-type-list.html) - renders a list of column types.
- [Select](/docs/marketplace/dev/front-end/table-design/table-column-types/table-column-type-select.html) - renders `@spryker/select` component.
- [Text](/docs/marketplace/dev/front-end/table-design/table-column-types/table-column-type-text.html) - renders a static text.
