---
title: Session Management
last_updated: Oct 4, 2021
template: concept-topic-template
originalLink: https://documentation.spryker.com/2021080/docs/session-management-201903
originalArticleId: 53d2c060-c45d-45a8-8d00-d0f1b10c7dbb
redirect_from:
  - /2021080/docs/session-management-201903
  - /2021080/docs/en/session-management-201903
  - /docs/session-management-201903
  - /docs/en/session-management-201903
  - /v6/docs/session-management-201903
  - /v6/docs/en/session-management-201903
  - /v5/docs/session-management-201903
  - /v5/docs/en/session-management-201903
  - /v4/docs/session-management-201903
  - /v4/docs/en/session-management-201903
  - /v3/docs/session-management-201903
  - /v3/docs/en/session-management-201903
  - /v2/docs/session-management-201903
  - /v2/docs/en/session-management-201903
  - /v1/docs/session-management-201903
  - /v1/docs/en/session-management-201903
---

In Spryker Commerce OS, session behavior is supported by User, Customer and CustomerPage modules.

The following article provides an overview on how sessions are handled in Zed and Yves, as well as describes possible use cases for both of them.

## Zed
In Zed (back-end), sessions are managed by the following javascript:

`vendor/spryker/spryker/Bundles/Gui/assets/Zed/js/modules/update-session.js`
The script handles sessions as follows:

1. Gets Session lifetime (`SessionConstants::ZED_SESSION_TIME_TO_LIVE`) from the [configuration file](#configuration-file).
2. Stores this value in browser local storage or a specific cookie with the current timestamp.
3. When a page is loaded, java-script timeout function is used for refreshing the session. Timeout is calculated by the following formula:

{% info_block warningBox %}

timeout = ((current_timestamp - session_started_at) - (session_lifetime - refresh_before_session_end)) * -1

{% endinfo_block %}

For example:

{% info_block infoBox %}

current time: 10:00 (1543399200)<br>session lifetime: 30m (18000)<br>session started at: 9:35 (1543397700)<br>session refresh before end: 5m (300)<br>((1543399200 - 1543397700) - (1800-300))*-1 = 0

{% endinfo_block %}

4. When time is out, sends Ajax request to PHP controller to extend session lifetime.
5. Refreshes data in browser storage after Ajax request is complete.

## Yves
In Yves (front-end), sessions are managed by the following widget:
`vendor/spryker/spryker-shop/Bundles/UpdateSessionTtlWidget/src/SprykerShop/Yves/UpdateSessionTtlWidget/Widget/UpdateSessionTtlWidget.php`

The widget handles sessions as follows:

1. Gets Session lifetime (`SessionConstants::YVES_SESSION_TIME_TO_LIVE`) from configuration the [configuration file](#configuration-file).

2. When a page is loaded, checks whether session update is necessary. Check calculation is based on:

{% info_block warningBox %}
timeout = ((current_timestamp - session_started_at) - (session_lifetime - refresh_before_session_end)) * -1.
{% endinfo_block %}

3. If time is out, refreshes the session.



<a name="configuration-file"></a> All the constants for session behavior are taken from the following configuration file:

`config/Shared/config_default.php`

However, depending on your environment, the values can be taken from the corresponding config files in config/Shared, if mentioned there.

{% info_block infoBox %}
By default, session lifetime value is 30 minutes while session check is set to be performed 5 minutes prior to the session timeout.
{% endinfo_block %}

## Use cases
Based on the introduced formula and configuration values, the following scenarios can be assumed for both Yves and Zed:

### Scenario #1

1. User logs into Yves or Zed
2. User performs certain actions
3. If the interval between user's actions does not exceed 25 minutes, the user is not logged out.

### Scenario #2
1. User logs into Yves or Zed
2. User performs certain actions
3. User does not perform any actions for more than 25 minutes.
4. Upon performing any action, user is redirected to the corresponding login page.

**See also:**

* Session handlers

<!-- _Last review date: Feb 19, 2019_ by Jeremy Foruna, Andrii Tserkovnyi -->
