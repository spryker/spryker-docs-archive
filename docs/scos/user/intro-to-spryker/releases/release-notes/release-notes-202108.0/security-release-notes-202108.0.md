---
title: Security release notes 202108.0
last_updated: Aug 27, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/security-release-notes-2021080
originalArticleId: 02a20e34-b404-4d2f-a0c4-29a154d2c389
redirect_from:
  - /2021080/docs/security-release-notes-2021080
  - /2021080/docs/en/security-release-notes-2021080
  - /docs/security-release-notes-2021080
  - /docs/en/security-release-notes-2021080
---

The following information pertains to security-related issues that have been recently resolved. All issues are listed by description and affected modules.

{% info_block infoBox "Note" %}

If you need any additional support with this content, please contact [support@spryker.com](mailto:support@spryker.com). If you found a new security vulnerability, please inform us via [security@spryker.com](mailto:security@spryker.com).

{% endinfo_block %}

## XSS due to assigning customers function in the Back Office

When a Back Office user assigns customers to users, a Cross-Site-Scripting (XSS) attack (with user interaction) is possible.

**Changes**:
The `CustomerGroup` module:
* Added `UtilSanitizeServiceInterface` to dependencies.
* Adjusted `AbstractAssignmentTable::getSelectCheckboxColumn()` to sanitize HTML tags for customer data.

The `CustomerUserConnectorGui` module:
* Added `UtilSanitizeServiceInterface` to dependencies.
* Added `UtilEncodingServiceInterface` to dependencies.
* Adjusted `AbstractCustomerTable::getCheckboxColumn()` to sanitize HTML tags for customer data.

**Affected modules**:
* CustomerGroup (2.5.5)
* CustomerUserConnectorGui (1.2.3)


**How to get the fix**: 
* Update the modules: 
```bash
composer update spryker/customer-user-connector-gui spryker/customer-group
```
* Check `AbstractAssignmentTable::getSelectCheckboxColumn()` and `AbstractCustomerTable::getCheckboxColumn()` if they were changed on the project level.

## Stored XSS in product reviews

An attacker can enter JavaScript or HTML code that will be executed in the Back Office.
This vulnerability allows an attacker to execute code in the context of the Back Office user.

**Changes**:
* Adjusted `ProductReviewTable::getCustomerName()` to escape HTML tags in the customer's first and last names.
* Adjusted `ProductReviewTable::getProductName()` to escape HTML tags in the product name.


**Affected modules**:
* ProductReviewGui (1.2.0)

**How to get the fix**: 
* Update the modules:
```bash
composer update spryker/product-review-gui
```

## Open redirect in the login script of the Back Office

You can manipulate the `referer` parameter and redirect a Back Office user to any URL.
The login script of the Back Office backend allows the specification of a path named `referer`. This parameter redirects an unauthenticated Back Office user to a specific page after logging in.

**Changes**:
* Adjusted `RedirectAfterLoginProvider` to make referer field validation more strict.
* Adjusted `RedirectAfterLoginEventDispatcherPlugin` to make referer field validation more strict.


**Affected modules**:
* Auth (3.7.5)

**How to get the fix**: 
* Update the modules:
```bash
composer update spryker/auth
```
## Bypass of redirection restrictions

 In the Back Office, on the *edit CMS redirect* page, you can set an incorrect parameter, which redirects a user to another site. By default, those redirects should be possible only to the same application.

**Changes**:
* Adjusted `CmsRedirectForm` to more strict URL validation.
* Adjusted the Back Office translations for the `en_US` and `de_DE` locale.

**Affected modules**:
* CMS (7.10.1)

**How to get the fix**: 
* Update the modules: 
```bash
composer update spryker/cms
```

## Missing CSRF protection in approving product reviews

The written product reviews are present in the Back Office (/product-review-gui). A Back Office user can decide if a product review is approved or rejected. Actions for this do not have any Cross-Site-Request-Forgery (CSRF)  token implemented. Due to that, a simple click rejects or approves a product review.

**Changes**:
* Adjusted `ProductReviewTable` to generate approve/reject buttons with the CSRF protection form.

**BC breaking impact**:
* `UpdateController::approveAction()` now becomes POST only and must be called by submitting `CloseReclamationForm` in order to use CSRF protection.
* `UpdateController::rejectAction()` now becomes POST only and must be called by submitting `CloseReclamationForm` in order to use CSRF protection.

**Affected modules**:
* ProductReviewGui (1.2.0)

**How to get the fix**: 
* Update the modules: 
```bash
composer update spryker/product-review-gui
```

## Missing CSRF protection in handling reclamations

When dealing with reclamations in the Back Office, you can execute an action without a token provided. Thus, the function is vulnerable against CSRF.

**Changes**:
* Adjusted `ReclamationTable::createCloseAction()` to generate buttons with the CSRF protection form.

**BC breaking impact**:
* Adjusted `DetailController::closeAction()`to use CSRF protection. It can handle POST requests only and must be called by submitting `CloseReclamationForm`.

**Affected modules**:
* SalesReclamationGui (1.5.0)

**How to get the fix**: 
* Update the modules: 
```bash
composer update spryker/sales-reclamation-gui
```

## Missing password policy in the Front Office and Back Office (B2C and B2B)

There is a difference between the Front Office and Back Office password policy in the following functionality:
* Registration
* Change password
* Forgot password

Back Office users can use weak or compromised passwords.

**Changes**:
The `SecurityGui` module:
* Adjusted `ResetPasswordForm` to use min/max length for password validation.
* Introduced `SecurityGuiConfig::getUserPasswordMinLength()`.
* Introduced `SecurityGuiConfig::getUserPasswordMaxLength()`.

The `User` module:
* Adjusted` UserForm` to use min/max length for password validation.
* Adjusted `UserUpdateForm` to use min/max length for password validation.
* Introduced `UserConfig::getUserPasswordMinLength()`.
* Introduced `UserConfig::getUserPasswordMaxLength()`.
* Introduced the `NotCompromisedPassword` validation, which will allow users to use only safe passwords.

The `CustomerPage` module:
* Adjusted `RestorePasswordForm` to use min/max length for password validation.

**Affected modules**:
* SecurityGui (0.1.1)
* User (3.12.2)
* CustomerPage (2.31.0)

**How to get the fix**: 
* Update the modules: 
```bash
composer update spryker-shop/customer-page spryker/user spryker/security-gui.
```
* Check if `ResetPasswordForm`, `UserUpdateForm`, and `UserForm` contain any changes on the project level.


## The web server takes any given value for www-de-suite-local and if it doesn't belong to a session.

All users can create their own cookies with a chosen name. This cookie name can have a large value (up to 4 KB) that is stored to Redis and thus can waste server memory.

**Changes**:
* Adjusted `SessionKeyBuilder::buildSessionKey()` to check maximum session key length. By default, the session key length is 32 symbols. All keys longer than 64 symbols will be trimmed.

**Affected modules**:
* SessionRedis (1.4.0)

**How to get the fix**: 
* Update the modules:
```bash
composer update spryker/session-redis
```

## Missing email validation for users in the Back Office

In the Back Office, there is no filter in place to prevent that the email address consists of a “bogus” value.

**Changes**:
•	Adjusted UserForm::addEmailField() so it validates email according RFC 5322 instead. 

**Affected modules**:
•	User (3.13.1)

## Security vulnerability in bl NPM package (CVE-2020-8244)

A buffer over-read vulnerability exists in bl <4.0.3, <3.0.1, <2.2.1, and <1.2.3, which allows an attacker to supply user input (even typed) that if it ends up in the `consume()` argument and can become negative, the *BufferList* state can be corrupted, tricking it into exposing uninitialized memory via regular `.slice()` calls.

**Changes**:
The version of the bl NPM package was updated.

## Outdated PHP version in use

In this case, PHP version 7.3.22 was used. This version was published on 03.09.2020.
There have been several patches for bugs, including 2 security vulnerabilities:
* CVE-2020-7070 (PHP parses encoded cookie names so malicious `__Host-` cookies can be sent)
* CVE-2020-7069 (OpenSSL: Wrong `ciphertext/tag` in the AES-CCM encryption for a 12 bytes IV)

**Changes**:
Updated PHP to the required version and extensions.

## Maintenance module deployed in PROD by default

A Back Office user can have a look at `phpinfo()`. In the section of the environment variable, sensitive information is exposed to the user.

**Changes**: 
* Introduced the `BackofficeNavigationItemCollectionFilterPlugin` plugin to filter the navigation items collection if the navigation element has a route.

**Affected modules:**
* ZedNavigation (1.11.0)

