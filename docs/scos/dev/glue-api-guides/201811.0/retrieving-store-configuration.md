---
title: Retrieving Store Configuration
search: exclude
last_updated: May 19, 2020
template: glue-api-storefront-guide-template
originalLink: https://documentation.spryker.com/v1/docs/retrieving-store-configuration
originalArticleId: 096e1d9d-54bd-45d7-a833-782db0484568
redirect_from:
  - /v1/docs/retrieving-store-configuration
  - /v1/docs/en/retrieving-store-configuration
---

Depending on your project needs, you can set up a single store that serves all your business needs or have multiple stores designed for different applications or available in different countries. Regardless of how many stores you have, a store contains such generic configuration as the currencies that can be used in transactions, countries where a store is available, supported languages and the time zone of the store.

The configuration of the current store in a project can be retrieved via an endpoint provided by the **Stores API**.

## Installation
For detailed information on the modules that provide the API functionality and related installation instructions, see [Glue Application Feature Integration](/docs/scos/dev/feature-integration-guides/{{page.version}}/glue-api/glue-api-glue-application-feature-integration.html).

## Usage
To retrieve store configuration, send a GET request to the following endpoint:
`/stores`
Request sample: `GET http://mysprykershop.com/stores`
The endpoint will respond with a **RestStoresResponse**.

**Response sample**
```js
{
		"data": [
			{
				"type": "stores",
				"id": "DE",
				"attributes": {
					"timeZone": "Europe/Berlin",
					"defaultCurrency": "EUR",
					"currencies": [
						{
							"code": "EUR",
							"name": "Euro"
						},
						{
							"code": "CHF",
							"name": "Swiss Franc"
						}
					],
					"locales": [
						{
							"code": "en",
							"name": "en_US"
						},
						{
							"code": "de",
							"name": "de_DE"
						}
					],
					"countries": [
						{
							"iso2Code": "AT",
							"iso3Code": "AUT",
							"name": "Austria",
							"postalCodeMandatory": true,
							"postalCodeRegex": "\\d{4}",
							"regions": []
						},
						{
							"iso2Code": "DE",
							"iso3Code": "DEU",
							"name": "Germany",
							"postalCodeMandatory": true,
							"postalCodeRegex": "\\d{5}",
							"regions": []
						}
					]
				},
				"links": {
					"self": "http://mysprykershop.com/stores/DE"
				}
			}
		],
		"links": {
			"self": "http://mysprykershop.com/stores"
		}
}
```

### General Attributes
| Field* | Type | Description |
| --- | --- | --- |
| timeZone | String | Name of the time zone of the selected store |
| defaultCurrency | String | Default currency of the store |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

### Currencies
| Field* | Type | Description |
| --- | --- | --- |
| code | String | Currency code |
| name | String | Currency name |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

### Locales
| Field* | Type | Description |
| --- | --- | --- |
| code | String | Locale code |
| name | String | Locale name |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

### Countries
| Field* | Type | Description |
| --- | --- | --- |
| iso2Code | String | 2 digit country code |
| iso3Code | String | 3 digit country code |
| name | String | Country name |
| postalCodeMandatory | Boolean | Boolean to tell if a postal code is mandatory or not |
| postalCodeRegex | String | A regular expression for the allowed postal codes |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.

### Regions
| Field* | Type | Description |
| --- | --- | --- |
| iso2Code | String | Iso 2 code for the region |
| name | String | Region name |

\*The fields mentioned are all attributes in the response. Type and ID are not mentioned.
