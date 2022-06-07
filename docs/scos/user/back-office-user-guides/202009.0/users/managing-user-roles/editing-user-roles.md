---
title: Editing user roles
search: exclude
description: Learn how to edit user roles in the Back Office.
template: back-office-user-guide-template
---

This document describes how to edit user roles in the Back Office.

## Prerequisites

To start working with user roles, go to **Users** > **User Roles**.

Review the [reference information](#reference-information-editing-roles) before you start, or look up the necessary information as you go through the process.

## Editing roles

1. On the **User Roles** page, click **Edit** next to the role you want to edit.
2. In the **Role** pane, update the **NAME**.
3. If you updated the **NAME**, click **Save**.
4. In the **Rule** pane, to add a rule, do the following:
    1. Enter a **BUNDLE**.
    4. Enter a **CONTROLLER**.
    5. Enter an **ACTION**.
    6. Select a **PERMISSION**.
    7. Click **Add Rule**.
      The page refreshes with the success message displayed and the ruled displayed in the **Assigned Rules** section.
5. Repeat steps 3-7 until you add all the needed rules.
6. In the **Assigned Rules** section, delete one or more rules by clicking **Delete** next to the rules you want to delete.
    This refershes the page with the success message displayed. The rule is no longer displayed in the list.

### Reference information: Editing roles

The following table describes the attributes you enter and select when creating roles:

| ATTRIBUTE | DESCRIPTION |
| --- | --- |
| NAME | Unique identifier of the role. You use this name to assign roles when managing users. |
| BUNDLE | Depending on the **PERMISSION**, allows or denies access to a section of the Back Office. You can check this value by going to the needed section and looking it up in the URL. For example, in `https://backoffice.de.b2b-demo-shop.local/product-attribute-gui/attribute/create`, `product-attribute-gui` is a bundle. |
| CONTROLLER | Depending on the **PERMISSION**, allows or denies access to a  subsection of the Back Office. You can check this value by going to the needed subsection and looking it up in the URL. For example, in `https://backoffice.de.b2b-demo-shop.local/product-attribute-gui/attribute/create`, `attribute` is a controller. |
| ACTION | Depending on the **PERMISSION**, allows or denies access to making actions. You can check this value by going to the needed action and looking it up in the URL. For example, in `https://backoffice.de.b2b-demo-shop.local/product-attribute-gui/attribute/create`, `create` is an action.
| PERMISSION | Denies or allows access to the **BUNDLE**, **CONTROLLER**, and **ACTION**. |

**Tips and tricks**

To allow or deny access for all of the bundles, controllers or actions, enter `*` in the needed field.

Alternatively, you can look up **BUNDLE**, **CONTROLLER**, and **ACTION** values in the `navigation.xml` of the needed module.

See the example of the `navigation.xml` file of the AvailabilityGui module:

<details open>
<summary markdown='span'>navigation.xml</summary>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<config>
    <product>
        <pages>
            <AvailabilityGui>
                <label>Availability</label>
                <title>Availability</title>
                <bundle>availability-gui</bundle>
                <controller>index</controller>
                <action>index</action>
                <pages>
                    <product-availability>
                        <label>Product Availability</label>
                        <title>Product Availability</title>
                        <bundle>availability-gui</bundle>
                        <controller>index</controller>
                        <action>view</action>
                        <visible>0</visible>
                    </product-availability>

                    <stock-edit>
                        <label>Edit Stock</label>
                        <title>Edit Stock</title>
                        <bundle>availability-gui</bundle>
                        <controller>index</controller>
                        <action>edit</action>
                        <visible>0</visible>
                    </stock-edit>
                </pages>
            </AvailabilityGui>
        </pages>
    </product>
</config>
```

</details>
