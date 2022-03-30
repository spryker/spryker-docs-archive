---
title: Implementing a REST API Resource
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/implementing-rest-api-resource
originalArticleId: 051a0adb-bfcf-4a36-a137-eb1151797d57
redirect_from:
  - /2021080/docs/implementing-rest-api-resource
  - /2021080/docs/en/implementing-rest-api-resource
  - /docs/implementing-rest-api-resource
  - /docs/en/implementing-rest-api-resource
  - /v6/docs/implementing-rest-api-resource
  - /v6/docs/en/implementing-rest-api-resource
  - /v5/docs/implementing-rest-api-resource
  - /v5/docs/en/implementing-rest-api-resource
  - /v4/docs/implementing-rest-api-resource
  - /v4/docs/en/implementing-rest-api-resource
  - /v2/docs/implementing-rest-api-resource
  - /v2/docs/en/implementing-rest-api-resource
  - /v1/docs/implementing-rest-api-resource
  - /v1/docs/en/implementing-rest-api-resource
---

The following guide provides step-by-step instructions on how to implement a REST API resource in your project.

{% info_block warningBox %}

Consider studying the following documents before you begin:
* [JSON API Specification](https://jsonapi.org/format/) implemented in Spryker;
* [Swagger Tools Reference](https://swagger.io/) to know how to document your API;
* [REST API Modelling Reference](https://www.thoughtworks.com/insights/blog/rest-api-design-resource-modeling).

{% endinfo_block %}

## 1. Create a Glue Resource Module
The first step is to create an empty Glue Resource Module. For naming convention, all the resource module names have to consist of the feature name in plural followed by the **RestApi** suffix. For example, the `WishlistsRestApi` module represents a resource for managing the wishlists feature.

To create a module:

* Create a new module in `src/Pyz/Glue/{YOUR_RESOURCE}sRestApi` if you want to have a project-level resource.
* Create the following folder and file structure:

| {YOUR_RESOURCE}sRestApi | Description |
| --- | --- |
| `/Controller` | Folder for resource controllers. Controllers are used to handle JSON requests and responses. |
| `/Dependency` | Bridges to other clients. |
| `/Plugin` |Glue API plugins.  |
| `/Processor` | Folder where all the resource processing logic, data mapping code and calls to other clients are located. |
| `{YOUR_RESOURCE}sRestApiConfig.php` | Contains resource-related configuration, such as the resource type, error code constants etc. |
|`{YOUR_RESOURCE}sRestApiFactory.php`  |  Factory to construct objects.|
| `ResourcesDependencyProvider.php` | Provides external dependencies to this module. |
| `{YOUR_RESOURCE}sRestApiResource.php` |  Locatable class that provides resource objects to other modules as a dependency.|
{% info_block infoBox %}

You can also use a [Spryk](/docs/scos/dev/glue-api-guides/{{site.version}}/glue-spryks.html) to create a basic structure. Run the following command:
```bash
console spryk:run AddGlueBasicStructure --mode=project --module=ResourcesRestApi --organization=Pyz --resourceType=resources
```
You'll need to agree to all the default values when prompted.

{% endinfo_block %}

* Add a transfer file that will be used to automatically map JSON data. Transfers are defined in the Shared layer (e.g. `src/Pyz/Shared/{YOUR_RESOURCE}sRestApi/Transfer`) as it needs to be accessible to any layer, including Glue. The name of the transfer file is `resources_rest_api.transfer.xml` where the first part is the name of your resource.

{% info_block infoBox %}

You can also use a [Spryk](/docs/scos/dev/glue-api-guides/{{site.version}}/glue-spryks.html) to add a transfer file. Run the following command:  
```bash
console spryk:run AddSharedRestAttributesTransfer --mode=project --module=ResourcesRestApi --organization=Pyz --name=RestResourcesAttributes
```
{% endinfo_block %}

The resulting folder structure in the example of the Wishlists REST API module:
![Wishlists REST API module](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/Introduction/Glue+API/wishlists-rest-api-module.png)

## 2. Create a Configuration Class

It is a good practice to create a configuration class that provides general module information. The class can be used to store types of resources, custom error codes used in your module, and other configuration data. Let us open the `WishlistsRestApiConfig.php` file and provide some initial configuration:

**WishlistsRestApiConfig.php**

```php
<?php
namespace Spryker\Glue\WishlistsRestApi;

use Spryker\Glue\Kernel\AbstractBundleConfig;

class WishlistsRestApiConfig extends AbstractBundleConfig
{
    // Define names of resources handled by this module
    public const RESOURCE_WISHLISTS = 'wishlists';

    // Define names of related resources used in this module
    public const RESOURCE_RELATION_PRODUCTS = 'products';

    // Define business validation response codes
    // The codes will be set manually when building error responses
    public const RESPONSE_CODE_WISHLIST_NOT_FOUND = '101';
    public const RESPONSE_CODE_WISHLIST_VALIDATION = '102';
}
```

{% info_block infoBox %}

You can also use a [Spryk](/docs/scos/dev/glue-api-guides/{{site.version}}/glue-spryks.html) to create a configuration class. Run the following command:

```bash
console spryk:run AddGlueConfig --mode=project --module=ResourcesRestApi --organization=Pyz
```
{% endinfo_block %}

## 3. Create a Factory

Factory is used for instantiating module classes and dependencies and provides access to the resource builder.

The factory must be inherited from `Spryker\Glue\Kernel\AbstractFactory`. This abstract factory exposes the `getResourceBuilder()` method that is used to construct resource and response objects. The following example shows how to correctly instantiate a resource reader using the `getResourceBuilder()` method:

**WishlistRestApiFactory.php**

```php
<?php
namespace Spryker\Glue\WishlistsRestApi;

use Spryker\Glue\Kernel\AbstractFactory;

class WishlistsRestApiFactory extends AbstractFactory
{
    /**
     *
     * @return \Spryker\Glue\WishlistsRestApi\Processor\Wishlists\WishlistsReaderInterface
     */
    public function createWishlistsReader(): WishlistsReaderInterface
    {
        return new WishlistsReader($this->getResourceBuilder());
    }
}
```

{% info_block infoBox %}

You can also use a [Spryk](/docs/scos/dev/glue-api-guides/{{site.version}}/glue-spryks.html) to create a factory. Run the following command:  

```bash
console spryk:run AddGlueFactory --mode=project --module=ResourcesRestApi --organization=Pyz
```
{% endinfo_block %}

## 4. Create a Resource Controller
The next step in implementing a resource module is creating a controller for it. The controller is a PHP class that receives all the requests, calls business logic and returns responses. To implement a controller:

1. Create a new class in the `Controller` folder. The naming convention is that the class name must start with the name of the resource it controls and end with the `ResourceController` suffix.
2. Inherit from the `\Spryker\Glue\Kernel\Controller\AbstractController` class.
3. Add a use clause to include `RestResponseInterface`. It will give you the possibility to pass responses to Glue. Any action method in a resource controller has to take `\Spryker\Glue\GlueApplication\Rest\Request\Data\RestRequestInterface` as a parameter and return `\Spryker\Glue\GlueApplication\Rest\JsonApi\RestResponseInterface`.
4. Implement actions that will be used to handle all the possible HTTP verbs (GET, POST, DELETE, PATCH) for the given resource.

{% info_block errorBox %}
The controller must only provide the request handling flow and must not contain any actual business logic. All operations must be delegated to the corresponding layers.
{% endinfo_block %}

{% info_block warningBox %}

Requests will be passed to the controller as instances of `RestRequestInterface`, and responses must be provided as `RestResponseInterface` objects.

{% endinfo_block %}

Sample controller implementation:

WishlistsResourceController.php

```php
<?php
namespace Spryker\Glue\WishlistsRestApi\Controller;

use Generated\Shared\Transfer\RestWishlistsAttributesTransfer;
use Spryker\Glue\GlueApplication\Rest\JsonApi\RestResponseInterface;
use Spryker\Glue\Kernel\Controller\AbstractController;

/**
 * @method \Spryker\Glue\WishlistsRestApi\WishlistsRestApiFactory getFactory()
 */
class WishlistsResourceController extends AbstractController
{
    /**
     * Handles the GET verb.
     *
     * @return \Spryker\Glue\GlueApplication\Rest\JsonApi\RestResponseInterface
     */
    public function getAction(): RestResponseInterface
    {
        //TODO: call factory, do data handling
    }

    /**
     * Handles the POST verb.
     *
     * @param \Generated\Shared\Transfer\RestWishlistsAttributesTransfer $restWishlistsAttributesTransfer
     *
     * @return \Spryker\Glue\GlueApplication\Rest\JsonApi\RestResponseInterface
     */
    public function postAction(RestWishlistsAttributesTransfer $restWishlistsAttributesTransfer): RestResponseInterface
    {
        $restWishlistsAttributesTransfer; //This variable is automatically mapped from request POST data

        //TODO: call factory, do data handling
    }

    /**
     * Handles the DELETE verb.
     *
     * @return \Spryker\Glue\GlueApplication\Rest\JsonApi\RestResponseInterface
     */
    public function deleteAction(): RestResponseInterface
    {
        //TODO: call factory, do data handling
    }

    /**
     * Handles the PATCH verb.
     *
     * @param \Generated\Shared\Transfer\RestWishlistsAttributesTransfer $restWishlistsAttributesTransfer
     *
     * @return \Spryker\Glue\GlueApplication\Rest\JsonApi\RestResponseInterface
     */
     public function patchAction(RestWishlistsAttributesTransfer $restWishlistsAttributesTransfer): RestResponseInterface
     {
          $restWishlistsAttributesTransfer; //This variable is automatically mapped from request PATCH data

          //TODO: call factory, do data handling
     }
}
```
{% info_block infoBox %}

You can also use a [Spryk](/docs/scos/dev/glue-api-guides/{{site.version}}/glue-spryks.html) to create a resource controller. Run the following command:  
```bash
console AddGlueController  --mode=project --module=ResourcesRestApi --organization=Pyz --controller=ResourcesController
```

{% endinfo_block %}

## 5. Describe Fields for Post and Patch Calls
The **POST** and the **PATCH** verbs allow you to pass the body in your request. Such parameters can be used in your resource module to manipulate Spryker entities. For example, when changing an entity via REST API, you can pass the modified values as fields of a **POST** or a **PATCH** request.

The same as with any other data source, you can use containers called **Transfer Objects** for the convenience of dealing with data retrieved from POST requests. The objects are defined in the XML transfer file located in the Shared layer. The names of the transfer objects need to start with **Rest**.

{% info_block infoBox %}

For information on how to define the objects and syntax, see [How to create transfer objects](/docs/scos/dev/back-end-development/data-manipulation/data-ingestion/structural-preparations/creating-using-and-extending-the-transfer-objects.html).

{% endinfo_block %}

In the example below, the `RestWishlistsAttributesTransfer` Transfer Object will have three string attributes automatically mapped from a POST request:

**wishlists_rest_api.transfer.xml**

```xml
<?xml version="1.0"?>
<transfers xmlns="spryker:transfer-01"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation="spryker:transfer-01 http://static.spryker.com/transfer-01.xsd">

           <transfer name="RestWishlistsAttributesTransfer">
               <property name="attribute1" type="string" />
               <property name="attribute2" type="string" />
               <property name="attribute3" type="string" />
            </transfer>
    </transfers>
```

To generate the respective transfer objects, run `vendor/bin/console transfer:generate`
{% info_block infoBox %}

You can also use a [Spryk](/docs/scos/dev/glue-api-guides/{{site.version}}/glue-spryks.html) to describe fields for post and patch calls. Run the following command:
```bash
console spryk:run AddSharedRestAttributesTransfer --mode=project --module=ResourcesRestApi --organization=Pyz --name=RestResourcesAttributes
```

{% endinfo_block %}

## 6. Route Requests to Your Controller
Now you need to route requests to your module. For this purpose, you need to create a route plugin that calls a certain function of the resource controller depending on the method configured in your resource. Then you need to add the plugin to the Glue Module dependency provider.

**Resource Route Plugin**
The route plugin must be inherited from `AbstractPlugin` and implement `ResourceRoutePluginInterface`. Let us create one in the Plugin folder:

WishlistsResourceRoutePlugin.php

```php
<?php
namespace Spryker\Glue\WishlistsRestApi\Plugin;

use Spryker\Glue\GlueApplication\Dependency\Plugin\ResourceRoutePluginInterface;

/**
 * @method \Spryker\Glue\WishlistsRestApi\WishlistsRestApiFactory getFactory()
 */

class WishlistsResourceRoutePlugin extends AbstractPlugin implements ResourceRoutePluginInterface
{
}
```

Now, we can map the controller actions to the verbs they implement. For this purpose, implement function `ResourceRoutePluginInterface::configure()`. To map the actions, you can use such methods as `addPost`, `addDelete`, `addPatch`, and `addGet` supported by `ResourceRouteCollectionInterface`. Each function has 3 parameters:

1. **action** — specifies the action name to map the verb to the Resource controller method;
2. **protected** (optional) — specifies whether authentication is required to access the resource. If this parameter is not specified, then the verb requires authentication;
3. **context** (optional) — an array of additional parameters that can be passed to the action. Use this parameter if you want to perform additional configuration of your actions.

In the following example, the plugin maps the **GET**, **POST**, **DELETE** and **PATCH** verbs to the controller actions we created in step 4. All the verbs except GET require authentication. This means that unauthenticated users will be able to read the resource, but will not be able to create, modify or delete items.

```php
...
class WishlistsResourceRoutePlugin extends AbstractPlugin implements ResourceRoutePluginInterface
{
    /**
     * @api
     *
     * @param \Spryker\Glue\GlueApplication\Dependency\Plugin\ResourceRouteCollectionInterface  $resourceRouteCollection
     *
     * @return \Spryker\Glue\GlueApplication\Dependency\Plugin\ResourceRouteCollectionInterface
     */
     public function configure(ResourceRouteCollectionInterface $resourceRouteCollection): ResourceRouteCollectionInterface
     {
          $resourceRouteCollection->addPost('post')
               ->addDelete('delete')
               ->addPatch('patch')
               ->addGet('get', false);

          return $resourceRouteCollection;
     }
     ...
```

Now, implement the function `ResourceRoutePluginInterface::getResourceType()`. It must return the name of your resource in plural (which is a resource URI):

```php
/**

		* @api
		*
		* @return string
		*/
		public function getResourceName(): string
		{
			return WishlistsRestApiConfig::RESOURCE_WISHLISTS;
		}
```

Then you need to specify the name of the controller class for your resource. We created it in step 4. The name must be specified in lowercase, separated by hyphens, and without the Controller suffix. Thus, for example, if you named the controller class `WishlistsResourceController`, you need to implement a function as follows:

```php
/**
     * @api
     *
     * @return string
     */
public function getController(): string
{
    return 'wishlists-resource';
}
```

Finally, you need to specify a fully-qualified class name of the Transfer Object created in step 5. It will be used by Glue to map attributes from the REST API calls (works with the **POST** and the **PATCH** actions only).

```php
/**
     * @api
     *
     * @return string
     */
    public function getResourceAttributesClassName(): string
    {
        return RestWishlistsAttributesTransfer::class;
    }
```

Now the plugin is complete. It should look something like this:

WishlistsResourceRoutePlugin.php

```php
<?php

namespace Spryker\Glue\WishlistsRestApi\Plugin;

use Generated\Shared\Transfer\RestWishlistsAttributesTransfer;
use Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRouteCollectionInterface;
use Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface;
use Spryker\Glue\WishlistsRestApi\WishlistsRestApiConfig;
use Spryker\Glue\Kernel\AbstractPlugin;

/**
 * @method \Spryker\Glue\WishlistsRestApi\WishlistsRestApiFactory getFactory()
 */
class WishlistsResourceRoutePlugin extends AbstractPlugin implements ResourceRoutePluginInterface
{
    /**
     * {@inheritdoc}
     *
     * @api
     *
     * @param \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRouteCollectionInterface $resourceRouteCollection
     *
     * @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRouteCollectionInterface
     */
    public function configure(ResourceRouteCollectionInterface $resourceRouteCollection): ResourceRouteCollectionInterface
    {
        $resourceRouteCollection->addPost('post')
            ->addDelete('delete')
            ->addPatch('patch')
            ->addGet('get');

        return $resourceRouteCollection;
    }

    /**
     * {@inheritdoc}
     *
     * @api
     *
     * @return string
     */
    public function getResourceType(): string
    {
        return WishlistsRestApiConfig::RESOURCE_WISHLISTS;
    }

    /**
     * {@inheritdoc}
     *
     * @api
     *
     * @return string
     */
    public function getController(): string
    {
        return 'wishlists-resource';
    }

    /**
     * {@inheritdoc}
     *
     * @api
     *
     * @return string
     */
    public function getResourceAttributesClassName(): string
    {
        return RestWishlistsAttributesTransfer::class;
    }
}
```
{% info_block infoBox %}

You can also use a [Spryk](/docs/scos/dev/glue-api-guides/{{site.version}}/glue-spryks.html) to route requests to your controller. Run the following command:
```bash
console spryk:run AddGlueResourceRoute --mode=project --module=ResourcesRestApi --organization=Pyz --resourceType=resources --resourceRouteMethod=get
```

{% endinfo_block %}

## 7. Process REST Requests
After you've routed requests to your module, you can process them. For this purpose, you can make use of the `Spryker\Glue\Kernel\AbstractFactory::getResourceBuilder()` method. It returns `Spryker\Glue\GlueApplication\Rest\JsonApi\RestResourceBuilderInterface`. This builder interface instantiates the `RestResourceInterface` and `RestResponseInterface` objects that are necessary to build the REST responses correctly.

To build the responses, you need to create classes responsible for the request processing. You can place them in the **Processor** folder. You can create various separate models for reading, creating, updating, and deleting modules.

## 8. Invoke Processors in Your Code
Finally, when you have a processor in place, you can use it in your code. For the processor invoking, use the factory created in step 3. Let us reopen the resource controller created in step 4 (`WishlistsResourceController.php`) and add code that handles GET requests:

```php
public function getAction(RestRequestInterface $restRequest): RestResponseInterface
    {
        return $this->getFactory()->createWishlistsReader()->readByIdentifier($restRequest);
        // This line passes the request to the actual class that handles data. It will return an instance of RestResponseInterface
    }
```

## 9. Register Resources in GlueApplicationDependencyProvider
You need to register your resource route plugin in Glue:

1. Open the `src/Pyz/Glue/GlueApplication/GlueApplicationDependencyProvider.php` file.
2. Add the route plugin to `getResourceRoutePlugins()`.

**Code sample**

```php
<?php
namespace Pyz\Glue\GlueApplication;

use Spryker\Glue\GlueApplication\GlueApplicationDependencyProvider as SprykerGlueApplicationDependencyProvider;
use Spryker\Glue\WishlistsRestApi\Plugin\WishlistsResourceRoutePlugin;

class GlueApplicationDependencyProvider extends SprykerGlueApplicationDependencyProvider
{
    /**
     * @return \Spryker\Glue\GlueApplicationExtension\Dependency\Plugin\ResourceRoutePluginInterface[]
     */
    protected function getResourceRoutePlugins(): array
    {
        return [
            ...
            new WishlistsResourceRoutePlugin(),
        ];
    }
```

3. Save the file.
