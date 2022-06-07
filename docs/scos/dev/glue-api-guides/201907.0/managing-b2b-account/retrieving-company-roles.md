---
title: Retrieving Company Role Information
search: exclude
description: The article describes how to use Spryker Glue API to retrieve company roles.
last_updated: Feb 8, 2020
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v3/docs/retrieving-company-role-information-201907
originalArticleId: 4fd525e7-89f8-4b41-86bc-0dd4ff78af11
redirect_from:
  - /v3/docs/retrieving-company-role-information-201907
  - /v3/docs/en/retrieving-company-role-information-201907
related:
  - title: Logging In as Company User
    link: docs/scos/dev/glue-api-guides/page.version/managing-b2b-account/authenticating-as-a-company-user.html
  - title: Retrieving Company User Information
    link: docs/scos/dev/glue-api-guides/page.version/managing-b2b-account/retrieving-company-users.html
  - title: Retrieving Company Information
    link: docs/scos/dev/glue-api-guides/page.version/managing-b2b-account/retrieving-companies.html
  - title: Company User Roles and Permissions Feature Overview
    link: docs/scos/user/features/page.version/company-account-feature-overview/company-user-roles-and-permissions-overview.html
  - title: Authentication and Authorization
    link: docs/scos/dev/glue-api-guides/page.version/authentication-and-authorization.html
---

In corporate environments, where users act as company representatives rather than private buyers, companies can leverage [Company Roles](/docs/scos/user/features/{{page.version}}/company-account-feature-overview/company-user-roles-and-permissions-overview.html) in order to distribute scopes and permissions among [Company Users](/docs/scos/user/features/{{page.version}}/company-account-feature-overview/company-accounts-overview.html). To identify which roles company users are assigned to, you can use the endpoints provided by the **Company Role API**.

{% info_block warningBox "Authentication" %}
The endpoints provided by this API cannot be accessed anonymously. To access them, you need to impersonate users as **Company Accounts** and pass the authentication tokens received. For details on how to authenticate and retrieve such a token, see [Logging In as Company User](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html).
{% endinfo_block %}

In your development, the endpoint can help you to identify the roles existing in the company of the currently logged in user.

## Installation
For detailed information on the modules that provide the API functionality and related installation instructions, see [GLUE: Company Account Feature Integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-company-account-feature-integration.html).

## Retrieving Company Role Information
### Roles Performed by the Current User
To retrieve information on the Company Roles assigned to the currently logged in Company User, send a GET request to the following endpoint:

[/company-roles/mine](/docs/scos/dev/glue-api-guides/{{page.version}}/rest-api-reference.html#//company-roles)

Request sample: *GET http://glue.mysprykershop.com/company-roles/mine*

{% info_block warningBox "Note" %}
You can use the **Accept-Language** header to specify the locale.Sample header: `[{"key":"Accept-Language","value":"de, en;q=0.9"}]` where **de**, **en** are the locales; **q=0.9** is the user's preference for a specific locale. For details, see [14.4 Accept-Language](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4).
{% endinfo_block %}

#### Response
The endpoint responds with a collection of **RestCompanyRoleResponse**, each containing information on a specific role.

**Response Attributes:**

| Attribute* | Type | Specifies the name of the Company Role. |
| --- | --- | --- |
| name | String | cell |
| isDefault | Boolean | Indicates whether the Company Role is the default role for the company. |

*The attributes mentioned are all attributes in the response. Type and ID are not mentioned.

<details open>
<summary markdown='span'>Sample Response</summary>
    
```json
{
    "data": [
        {
            "type": "company-roles",
            "id": "2f0a9d3e-9e69-53eb-8518-284a0db04376",
            "attributes": {
                "name": "Admin",
                "isDefault": true
        },
        "links": {
            "self": "http://glue.mysprykershop.com/company-roles/2f0a9d3e-9e69-53eb-8518-284a0db04376"
        }
    }
    ],
    "links": {
        "self": "http://glue.mysprykershop.com/company-roles/mine"
    }
}
```
    
<br>
</details>

### Specific Role
To retrieve information on a specific Company Role, send a GET request to the following endpoint:

[/company-roles/{% raw %}{{{% endraw %}role_id{% raw %}}}{% endraw %}](/docs/scos/dev/glue-api-guides/{{page.version}}/rest-api-reference.html#//company-roles)
Request sample: *GET http://glue.mysprykershop.com/company-roles/**2f0a9d3e-9e69-53eb-8518-284a0db04376***

where **2f0a9d3e-9e69-53eb-8518-284a0db04376** is the ID of the Company Role you need.

{% info_block infoBox "Info" %}
The endpoint provides information only on the roles a user has access to. If a request is made against a role a user is not allowed to view, the endpoint responds with a **404 Not Found** error code.
{% endinfo_block %}

{% info_block warningBox "Note" %}
You can use the **Accept-Language** header to specify the locale.Sample header: `[{"key":"Accept-Language","value":"de, en;q=0.9"}]` where **de**, **en** are the locales; **q=0.9** is the user's preference for a specific locale. For details, see [14.4 Accept-Language](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4).
{% endinfo_block %}

#### Response
The endpoint responds with a **RestCompanyRoleResponse** that contains information on the requested role.

**Response Attributes:**

| Attribute* | Type | Description |
| --- | --- | --- |
| name | String | Specifies the name of the Company Role. |
| isDefault | Boolean | Indicates whether the Company Role is the default role for the company. |

*The attributes mentioned are all attributes in the response. Type and ID are not mentioned.

<details open>
<summary markdown='span'>Sample Response</summary>
    
```json
{
    "data": {
        "type": "company-roles",
        "id": "2f0a9d3e-9e69-53eb-8518-284a0db04376",
        "attributes": {
            "name": "Admin",
            "isDefault": true
        },
        "links": {
            "self": "http://glue.mysprykershop.com/company-roles/2f0a9d3e-9e69-53eb-8518-284a0db04376"
        }
    }
}
```
    
<br>
</details>

### Fetching Additional Information
You can extend the response with the companies resource relationship in order to obtain information on the company where the role was created.

Request sample: *GET http://glue.mysprykershop.com/company-roles/2f0a9d3e-9e69-53eb-8518-284a0db04376?include=companies*

The response will include the following additional attributes:

| Resource | Attribute* | Type | Description |
| --- | --- | --- | --- |
| companies | name | String | Specifies the Company name. |
| companies | isActive | Boolean | Indicates whether the Company is active. |
| companies | status | String | Specifies the status of the Company. Possible values: *Pending*, *Approved* or *Denied*. |

*The attributes mentioned are all attributes in the response. Type and ID are not mentioned.

<details open>
<summary markdown='span'>Sample Response</summary>
    
```json
{
    "data": {
        "type": "company-roles",
        "id": "2f0a9d3e-9e69-53eb-8518-284a0db04376",
        "attributes": {...},
        "links": {...},
        "relationships": {
            "companies": {
                "data": [
                    {
                        "type": "companies",
                        "id": "0818f408-cc84-575d-ad54-92118a0e4273"
                    }
                ]
            }
        }
    },
    "included": [
        {
            "type": "companies",
            "id": "0818f408-cc84-575d-ad54-92118a0e4273",
            "attributes": {
                "isActive": true,
                "name": "Test Company",
                "status": "approved"
            },
            "links": {
                "self": "http://glue.mysprykershop.com/companies/0818f408-cc84-575d-ad54-92118a0e4273"
            }
        }
    ]
}
```
    
<br>
</details>

### Possible Errors

| Code | Reason |
| --- | --- |
| 401 | The access token is invalid. |
| 403 | The access token is missing.<br>- OR -<br>The current Company Account is not set.<br>This can occur if you didn't properly impersonate the user as a Company User Account. For details on how to do so, see [Logging In as Company User](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html). |
| 404 | The specified role was not found or the user does not have access to it. |

<!-- add to related articles:
See also:
Logging In as Company UserRetrieving Company InformationRetrieving Company User InformationCompany AccountCompany Roles and Permissions Feature OverviewAuthentication and AuthorizationCompany Account API Feature Integration -->
