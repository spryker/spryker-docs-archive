---
title: Agent Assist feature integration
description: Agent Assist enables agent users to log in to shop to perform actions on customers’ behalf. This guide describes how to install Agent Assist in your project
last_updated: Nov 22, 2019
template: feature-integration-guide-template
originalLink: https://documentation.spryker.com/v2/docs/agent-assist-feature-integration
originalArticleId: 1cd23607-4cca-4b4a-8740-4a2a255c75b5
redirect_from:
  - /v2/docs/agent-assist-feature-integration
  - /v2/docs/en/agent-assist-feature-integration
---

## Install Feature Core

### Prerequisites

To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Spryker Core | 201903.0 |
| Spryker Core Back Office | 201903.0 |
| Customer Account Management | 201903.0 |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/agent-assist:"^201903.0" --update-with-dependencies 
```

{% info_block warningBox "Verification" %}
Make sure that the following modules were installed:<table><thead><tr><th>Module</th><th>Expected Directory </th></tr></thead><tbody><tr><td>`Agent`</td><td>`vendor/spryker/agent`</td></tr><tr><td>`AgentGui`</td><td>`vendor/spryker/agent-gui`</td></tr></tbody></table>
{% endinfo_block %}

### 2) Set up the Database Schema

Run the following commands to apply database changes and to generate entity and transfer changes.
```bash
console transfer:generate
console propel:install
console transfer:generate 
```

{% info_block warningBox "Verification" %}
Verify the following changes by checking your database:<table ><thead><tr><td >Database Entity</td><td>Type</td><td>Event</td></tr></thead><tbody><tr><td>`spy_user.is_agent`</td><td>column</td><td>created</td></tr></tbody></table>
{% endinfo_block %}

### 3) Set up Behavior

#### Configure User Zed UI for Agent Handling

Enable the following behaviors by registering the plugins:

| Plugin | Description | Prerequisites | Namespace |
| --- | --- | --- | --- |
|  `UserAgentFormExpanderPlugin` | Adds "is an agent" checkbox to the Zed User form. | None |  `Spryker\Zed\AgentGui\Communication\Plugin` |
|  `UserAgentTableConfigExpanderPlugin` | Adds "is an agent" column to the Zed Users table. | None |  `Spryker\Zed\AgentGui\Communication\Plugin` |
|  `UserAgentTableDataExpanderPlugin` | Fills "is an agent" column in the Zed Users table. | None |  `Spryker\Zed\AgentGui\Communication\Plugin` |

<details open><summary markdown='span'>src/Pyz/Zed/User/UserDependencyProvider.php</summary>

 ```php
 <?php

namespace Pyz\Zed\User;

use Spryker\Zed\AgentGui\Communication\Plugin\UserAgentFormExpanderPlugin;
use Spryker\Zed\AgentGui\Communication\Plugin\UserAgentTableConfigExpanderPlugin;
use Spryker\Zed\AgentGui\Communication\Plugin\UserAgentTableDataExpanderPlugin;
use Spryker\Zed\User\UserDependencyProvider as SprykerUserDependencyProvider;

class UserDependencyProvider extends SprykerUserDependencyProvider
{
 /**
 * @return \Spryker\Zed\UserExtension\Dependency\Plugin\UserFormExpanderPluginInterface[]
 */
 protected function getUserFormExpanderPlugins(): array
 {
 return [
 new UserAgentFormExpanderPlugin(),
 ];
 }

 /**
 * @return \Spryker\Zed\UserExtension\Dependency\Plugin\UserTableConfigExpanderPluginInterface[]
 */
 protected function getUserTableConfigExpanderPlugins(): array
 {
 return [
 new UserAgentTableConfigExpanderPlugin(),
 ];
 }

 /**
 * @return \Spryker\Zed\UserExtension\Dependency\Plugin\UserTableDataExpanderPluginInterface[]
 */
 protected function getUserTableDataExpanderPlugins(): array
 {
 return [
 new UserAgentTableDataExpanderPlugin(),
 ];
 }
} 
```
<br>
</details>

{% info_block warningBox "Verification" %}
Make sure that the following plugins were registered:<table><thead><tr><th>Plugin</th><th>Description</th><th>Prerequisites</th><th>Namespace</th></tr></thead><tbody><tr ><td>`UserAgentFormExpanderPlugin`</td><td>Adds "is an agent" checkbox to the Zed User form.</td><td>None</td><td>`Spryker\Zed\AgentGui\Communication\Plugin`</td></tr><tr><td>`UserAgentTableConfigExpanderPlugin`</td><td>Adds "is an agent" column to the Zed Users table.</td><td>None</td><td>`Spryker\Zed\AgentGui\Communication\Plugin`</td></tr><tr><td>`UserAgentTableDataExpanderPlugin`</td><td>Fills "is an agent" column in the Zed Users table.</td><td>None</td><td>`Spryker\Zed\AgentGui\Communication\Plugin`</td></tr></tbody></table>
{% endinfo_block %}

## Install Feature Frontend

### Prerequisites

To start feature integration, overview and install the necessary features:

| Name | Version |
| --- | --- |
| Spryker Core E-commerce | 201903.0 |

### 1) Install the required modules using Composer

Run the following command(s) to install the required modules:

```bash
composer require spryker-feature/agent-assist:"^201903.0" --update-with-dependencies 
```

{% info_block warningBox "Verification" %}
Verify if the following modules were installed:<table><thead><tr><td>Module</td><td>Expected Directory</td></tr></thead><tbody><tr><td>`AgentPage`</td><td>`vendor/spryker-shop/agent-page`</td></tr><tr><td>`AgentWidget`</td><td>`vendor/spryker-shop/agent-widget`</td></tr></tbody></table>
{% endinfo_block %}

### 2) Add Translations

Append glossary according to your configuration:

<details open><summary markdown='span'>src/data/import/glossary.csv</summary>

 ```yaml
 agent.authentication.failed,Authentication failed,en_US
agent.authentication.failed,Authentifizierung fehlgeschlagen,de_DE
agent.login.title,Access your account,en_US
agent.login.title,Ich bin bereits Kunde,de_DE
agent.confirm_user_selection,Confirm,en_US
agent.confirm_user_selection,Bestätigen,de_DE
agent.login.email,Email,en_US
agent.login.email,E-Mail,de_DE
agent.login.password,Password,en_US
agent.login.password,Passwort,de_DE
agent.control_bar.username,Agent: %username%,en_US
agent.control_bar.username,Agent: %username%,de_DE
agent.control_bar.customer_name,Customer: %username%,en_US
agent.control_bar.customer_name,Kunde: %username%,de_DE
agent.control_bar.logout_as_customer,End Customer Assistance,en_US
agent.control_bar.logout_as_customer,Kunden-Assistenz beenden,de_DE
agent.control_bar.logout,Logout,en_US
agent.control_bar.logout,Abmelden,de_DE
agent.autocomplete.no_results,No results found,en_US
agent.autocomplete.no_results,Keine Ergebnisse gefunden,de_DE
autocomplete.placeholder,Search,en_US
autocomplete.placeholder,Suche,de_DE 
```
<br>
</details>

Run the following command(s) to add the glossary keys:

```
console data:import:glossary 
```
{% info_block warningBox "Verification" %}
Make sure that in the database the configured data are added to the `spy_glossary` table.
{% endinfo_block %}

### 3) Enable Controllers

#### Service Provider List

Register service provider(s) in the Yves application:

| Provider | Namespace | Specification |
| --- | --- | --- |
|  `AgentPageSecurityServiceProvider` |  `SprykerShop\Yves\AgentPage\Plugin\Provider` | Registers security firewalls, access rules, impersonate rules and login/logout handlers for Agent users. |

 <details open><summary markdown='span'>src/Pyz/Yves/ShopApplication/YvesBootstrap.php</summary>

 ```php
 <?php

namespace Pyz\Yves\ShopApplication;

use SprykerShop\Yves\AgentPage\Plugin\Provider\AgentPageSecurityServiceProvider;
use SprykerShop\Yves\ShopApplication\YvesBootstrap as SprykerYvesBootstrap;

class YvesBootstrap extends SprykerYvesBootstrap
{
 /**
 * @return void
 */
 protected function registerServiceProviders()
 {
 $this->application->register(new AgentPageSecurityServiceProvider()); # AgentFeature
 }
}
```
<br>
</details>

{% info_block warningBox "Verification" %}
Verify the following changes:<br>* Try to open the link:`http://mysprykershop.com/agent/secured`<br>
* You should be redirected to`http://mysprykershop.com/agent/login`
{% endinfo_block %}


#### Controller Provider List

Register controller provider(s) in the Yves application:

| Provider | Namespace | Enabled Controller | Controller Specification |
| --- | --- | --- | --- |
|  `AgentPageControllerProvider` |  `SprykerShop\Yves\AgentPage\Plugin\Provider` |  `AgentPage\AuthController` | Login/Logout actions for the Agent user. |
|  `AgentWidgetControllerProvider` |  `SprykerShop\Yves\AgentWidget\Plugin\Provide` |  `AgentWidget\CustomerAutocompleteController` | Customer autocomplete action for the Agent control bar. |

 <details open><summary markdown='span'>src/Pyz/Yves/ShopApplication/YvesBootstrap.php</summary>

 ```php
 <?php

namespace Pyz\Yves\ShopApplication;

use SprykerShop\Yves\AgentPage\Plugin\Provider\AgentPageControllerProvider;
use SprykerShop\Yves\AgentWidget\Plugin\Provider\AgentWidgetControllerProvider;
use SprykerShop\Yves\ShopApplication\YvesBootstrap as SprykerYvesBootstrap;

class YvesBootstrap extends SprykerYvesBootstrap
{
 /**
 * @param bool|null $isSsl
 *
 * @return \SprykerShop\Yves\ShopApplication\Plugin\Provider\AbstractYvesControllerProvider[]
 */
 protected function getControllerProviderStack($isSsl)
 {
 return [
 new AgentPageControllerProvider($isSsl), #AgentFeature
 new AgentWidgetControllerProvider($isSsl), #AgentFeature
 ];
 }
} 
```
<br>
</details>

{% info_block warningBox "Verfication" %}
Verify the `AgentPageControllerProvider` opening the agent login page by the link: `http://mysprykershop.com/agent/login](http://mysprykershop.com/agent/login`
{% endinfo_block %}

{% info_block warningBox "Verification" %}
Verify the `AgentWidgetControllerProvider` searching customers from Agent control bar after Agent login.
{% endinfo_block %}

### 4) Set up Widgets

Register the following global widget(s):

| Widget | Specification | Namespace |
| --- | --- | --- |
|  `AgentControlBarWidget` | Allows agents to select customers and impersonate. |  `SprykerShop\Yves\AgentWidget\Widget` |

 <details open><summary markdown='span'>src/Pyz/Yves/ShopApplication/ShopApplicationDependencyProvider.php</summary>

 ```php
 <?php

namespace Pyz\Yves\ShopApplication;

use SprykerShop\Yves\AgentWidget\Widget\AgentControlBarWidget;
use SprykerShop\Yves\ShopApplication\ShopApplicationDependencyProvider as SprykerShopApplicationDependencyProvider;

class ShopApplicationDependencyProvider extends SprykerShopApplicationDependencyProvider
{
 /**
 * @return string[]
 */
 protected function getGlobalWidgets(): array
 {
 return [
 AgentControlBarWidget::class,
 ];
 }
} 
```
<br>
</details>

Run the following command to enable Javascript and CSS changes.

In case if you have custom layout template, please place the agent widget above the site header:

```xml
{% raw %}{%{% endraw %} widget 'AgentControlBarWidget' only {% raw %}%}{% endraw %}{% raw %}{%{% endraw %} endwidget {% raw %}%}{% endraw %} 
```

{% info_block warningBox "Verification" %}
Make sure that the following widgets were registered:<table><thead><tr><th>Module</th><th>Test</th></tr></thead><tbody><tr><td>`AgentControlBarWidget`</td><td>Login as an Agent. The control bar widget should appear above the site header.</td></tr></tbody></table>
{% endinfo_block %}
