---
title: Creating user roles
description: Learn how to create roles in the Back Office.
last_updated: Aug 2, 2021
template: back-office-user-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/managing-roles
originalArticleId: 646ae8f6-32b9-440d-8cdf-c720d046de25
redirect_from:
  - /2021080/docs/managing-roles
  - /2021080/docs/en/managing-roles
  - /docs/managing-roles
  - /docs/en/managing-roles
  - /docs/scos/user/back-office-user-guides/202108.0/users/roles-groups-and-users/managing-roles.html
  - /docs/scos/user/back-office-user-guides/202009.0/users/roles-groups-and-users/references/reference-information-roles.html
---

This document describes how to create user roles in the Back Office.

## Prerequisites

1. If you are new to the **Users** section, you might want to start with [Best practices: Managing users and their permissions with roles and groups](/docs/scos/user/back-office-user-guides/{{page.version}}/users/best-practices-managing-users-and-their-permissions-with-roles-and-groups.html).
2. To start working with roles, go to **Users** > **User Roles**.

Review the [reference information](#reference-information-creating-user-roles) before you start, or look up the necessary information as you go through the process.

## Creating roles

1. On the **User Roles** page, click **Add new Role**.
2. On the **Create new Role** page, enter a **NAME** and click **Create**.
    This opens the **Edit Role** page with the success message displayed.
3. In the **Rule** pane, enter a **BUNDLE**.
4. Enter a **CONTROLLER**.
5. Enter an **ACTION**.
6. Select a **PERMISSION**
7. Click **Add Rule**.
      The page refreshes with the success message displayed and the rule displayed in the **Assigned Rules** section.
8. Repeat steps 3-7 until you add all the needed rules.       


### Reference information: Creating user roles

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


## Next steps

[Creating user groups](/docs/scos/user/back-office-user-guides/{{page.version}}/users/managing-user-groups/creating-user-groups.html)
