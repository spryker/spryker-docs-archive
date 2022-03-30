---
title: Searching by company users
description: Learn how to search by company users via Glue API.
last_updated: Feb 9, 2021
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v6/docs/searching-by-company-users
originalArticleId: 2bce3269-9c53-4eff-a2a9-d21e4f5eed46
redirect_from:
  - /v6/docs/searching-by-company-users
  - /v6/docs/en/searching-by-company-users
related:
  - title: Authentication and Authorization
    link: docs/scos/dev/glue-api-guides/page.version/managing-customers/authenticating-as-a-customer.html
  - title: Retrieving Company Role Information
    link: docs/scos/dev/glue-api-guides/page.version/managing-b2b-account/retrieving-company-roles.html
  - title: Retrieving Company User Information
    link: docs/scos/dev/glue-api-guides/page.version/managing-b2b-account/retrieving-company-users.html
  - title: Company Account and General Organizational Structure
    link: docs/scos/user/features/page.version/company-account-feature-overview/company-accounts-overview.html
  - title: Prices per Merchant Relation Feature Overview
    link: docs/scos/user/features/page.version/merchant-custom-prices-feature-overview.html
  - title: Password Management
    link: docs/scos/user/features/page.version/customer-account-management-feature-overview/password-management-overview.html
---

This endpoint allows [authenticated customers](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-customers/authenticating-as-a-customer.html#authenticate-as-a-customer) to search by the company users available to them. Usually, authenticated customers search for a company user which they want to authenticate as. 

## Installation
For detailed information on the modules that provide the API functionality and related installation instructions, see [Glue API: Company Account Feature Integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-company-account-feature-integration.html).

## Retrieve available company users

To retrieve company users of the current authenticated customer, send the request:

***
`GET`**/company-users/mine**
***

### Request

| Header key | Required | Description |
| --- | --- | --- |
| Authorization | &check; | Alphanumeric string that authorizes the customer to send requests to protected resources. Get it by [authenticating as a customer](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-customers/authenticating-as-a-customer.html).  |


| Query parameter | Description | Possible values |
| --- | --- | --- |
| Include | Adds resource relationships to the request. | companies, company-business-units, company-roles |


| Request | Usage |
| --- | --- |
| GET https://glue.mysprykershop.com/company-users/mine | Retrieve all the copmany users the current authenticated customer can authenticate as. |
| GET https://glue.mysprykershop.com/company-users/mine?include=companies,company-business-units,company-roles | Retrieve all the copmany users the current authenticated customer can authenticate as. Include information about the company and business unit each company user belongs to. Include information about the roles of each company user. |


### Response

<details open>
    <summary markdown='span'>Response sample</summary>
    
```json
{
    "data": [
        {
            "type": "company-users",
            "id": "4c677a6b-2f65-5645-9bf8-0ef3532bead1",
            "attributes": {
                "isActive": true,
                "isDefault": false
            },
            "links": {
                "self": "https://glue.mysprykershop.com/company-users/4c677a6b-2f65-5645-9bf8-0ef3532bead1"
            }
        },
        {
            "type": "company-users",
            "id": "cfbe2644-a9bd-581b-977b-e72d1c9a9c54",
            "attributes": {
                "isActive": true,
                "isDefault": false
            },
            "links": {
                "self": "https://glue.mysprykershop.com/company-users/cfbe2644-a9bd-581b-977b-e72d1c9a9c54"
            }
        },
        {
            "type": "company-users",
            "id": "e1019900-88c4-5582-af83-2c1ea8775ac5",
            "attributes": {
                "isActive": true,
                "isDefault": false
            },
            "links": {
                "self": "https://glue.mysprykershop.com/company-users/e1019900-88c4-5582-af83-2c1ea8775ac5"
            }
        }
    ],
    "links": {
        "self": "https://glue.mysprykershop.com/company-users/mine"
    }
}
```

</details>

<details open>
<summary markdown='span'>Response sample with companies, company business units and company roles</summary>
    
```json
{
    "data": [
        {
            "type": "company-users",
            "id": "4c677a6b-2f65-5645-9bf8-0ef3532bead1",
            "attributes": {...},
            "links": {...},
            "relationships": {
                "companies": {
                    "data": [
                        {
                            "type": "companies",
                            "id": "88efe8fb-98bd-5423-a041-a8f866c0f913"
                        }
                    ]
                },
                "company-business-units": {
                    "data": [
                        {
                            "type": "company-business-units",
                            "id": "b2ea10b2-263a-5cd9-88dc-747309f0534a"
                        }
                    ]
                },
                "company-roles": {
                    "data": [
                        {
                            "type": "company-roles",
                            "id": "50c647a4-d27f-5d82-a587-1d0b7cc6b58d"
                        }
                    ]
                }
            }
        },
        {
            "type": "company-users",
            "id": "cfbe2644-a9bd-581b-977b-e72d1c9a9c54",
            "attributes": {
                "isActive": true,
                "isDefault": false
            },
            "links": {
                "self": "https://glue.mysprykershop.com/company-users/cfbe2644-a9bd-581b-977b-e72d1c9a9c54?include=companies,company-business-units"
            },
            "relationships": {
                "companies": {
                    "data": [
                        {
                            "type": "companies",
                            "id": "88efe8fb-98bd-5423-a041-a8f866c0f913"
                        }
                    ]
                },
                "company-business-units": {
                    "data": [
                        {
                            "type": "company-business-units",
                            "id": "35752ce6-e25f-5d04-8bef-d46b2c359695"
                        }
                    ]
                }
            }
        },
        {
            "type": "company-users",
            "id": "e1019900-88c4-5582-af83-2c1ea8775ac5",
            "attributes": {...},
            "links": {...},
            "relationships": {
                "companies": {
                    "data": [
                        {
                            "type": "companies",
                            "id": "88efe8fb-98bd-5423-a041-a8f866c0f913"
                        }
                    ]
                },
                "company-business-units": {
                    "data": [
                        {
                            "type": "company-business-units",
                            "id": "5a6032dc-fbce-5d0d-9d57-11ade1947bac"
                        }
                    ]
                }
            }
        }
    ],
    "links": {...},
    "included": [
        {
            "type": "companies",
            "id": "88efe8fb-98bd-5423-a041-a8f866c0f913",
            "attributes": {
                "isActive": true,
                "name": "BoB-Hotel Mitte",
                "status": "approved"
            },
            "links": {
                "self": "https://glue.mysprykershop.com/companies/88efe8fb-98bd-5423-a041-a8f866c0f913"
            }
        },
        {
            "type": "company-business-units",
            "id": "b2ea10b2-263a-5cd9-88dc-747309f0534a",
            "attributes": {
                "name": "Hotel Mitte",
                "email": "Hotel.Mitte@spryker.com",
                "phone": "12345617",
                "externalUrl": "",
                "bic": "",
                "iban": "",
                "defaultBillingAddress": null
            },
            "links": {
                "self": "https://glue.mysprykershop.com/b2ea10b2-263a-5cd9-88dc-747309f0534a"
            }
        },
        {
            "type": "company-business-units",
            "id": "35752ce6-e25f-5d04-8bef-d46b2c359695",
            "attributes": {
                "name": "Service Mitte",
                "email": "Service.Mitte@spryker.com",
                "phone": "12345617",
                "externalUrl": "",
                "bic": "",
                "iban": "",
                "defaultBillingAddress": null
            },
            "links": {
                "self": "https://glue.mysprykershop.com/company-business-units/35752ce6-e25f-5d04-8bef-d46b2c359695"
            }
        },
        {
            "type": "company-business-units",
            "id": "5a6032dc-fbce-5d0d-9d57-11ade1947bac",
            "attributes": {
                "name": "Cleaning Mitte",
                "email": "Cleaning.Mitte@spryker.com",
                "phone": "12345617",
                "externalUrl": "",
                "bic": "",
                "iban": "",
                "defaultBillingAddress": null
            },
            "links": {
                "self": "https://glue.mysprykershop.com/company-business-units/5a6032dc-fbce-5d0d-9d57-11ade1947bac"
            }
        },
        {
            "type": "company-roles",
            "id": "50c647a4-d27f-5d82-a587-1d0b7cc6b58d",
            "attributes": {
                "name": "Buyer",
                "isDefault": true
            },
            "links": {
                "self": "https://glue.mysprykershop.com/company-roles/50c647a4-d27f-5d82-a587-1d0b7cc6b58d"
            }
        }
    ]
}
```
    
</details>




| Attribute | Type | Description |
| --- | --- | --- |
| id | String | Unique identifier of a company user. |
| isActive | Boolean | Defines if the company user is active. |
| isDefault | Boolean | Defines if this company user is default for the authenticated customer. |


| Included resource | Attribute | Type | Description |
| --- | --- | --- | --- |
| companies | name | String | Company name. |
| companies | isActive | Boolean | Indicates if the company is active. |
| companies | status | String | Company status. Possible values are: *Pending*, *Approved* or *Denied*. |
| company-roles | name | String | Company role name. |
| company-roles | isDefault | Boolean | Indicates if the company role is default role for the company. | 
| company-business-units | name | String | Business unit name. |
| company-business-units | email | String | Email address of the business unit. |
| company-business-units | phone | String | Telephone number of the business unit. |
| company-business-units | externalUrl | String | URL of the website of the business unit. |
| company-business-units | bic | String | Specifies the Bank Identifier Code of the Business Unit. |
| company-business-units | iban | String | Specifies the International Bank Account Number of the Business Unit. |
| company-business-units | defaultBillingAddress | String | Specifies the default billing address of the Business Unit. |




## Possible errors

| Code | Reason |
| --- | --- |
| 001 | The access token is invalid. |
| 002 | The access token is missing. |

To view generic errors that originate from the Glue Application, see [Reference information: GlueApplication errors](/docs/scos/dev/glue-api-guides/{{page.version}}/reference-information-glueapplication-errors.html).

## Next steps

* [Authenticate as a company user](/docs/scos/dev/glue-api-guides/{{page.version}}/managing-b2b-account/authenticating-as-a-company-user.html)
