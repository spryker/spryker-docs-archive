---
title: Controllers and Actions
description: Controllers are placed inside the Controllers folder in Yves; they provide an entry point to the system for requests submitted by the front-end users.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/yves-controllers-actions
originalArticleId: 807eb310-336a-46d8-8cfc-bcafe4d3a324
redirect_from:
  - /2021080/docs/yves-controllers-actions
  - /2021080/docs/en/yves-controllers-actions
  - /docs/yves-controllers-actions
  - /docs/en/yves-controllers-actions
  - /v6/docs/yves-controllers-actions
  - /v6/docs/en/yves-controllers-actions
  - /v5/docs/yves-controllers-actions
  - /v5/docs/en/yves-controllers-actions
  - /v4/docs/yves-controllers-actions
  - /v4/docs/en/yves-controllers-actions
  - /v3/docs/yves-controllers-actions
  - /v3/docs/en/yves-controllers-actions
  - /v2/docs/yves-controllers-actions
  - /v2/docs/en/yves-controllers-actions
  - /v1/docs/yves-controllers-actions
  - /v1/docs/en/yves-controllers-actions
---

Controllers are placed inside the Controllers folder in Yves; they provide an entry point to the system for requests submitted by the front-end users.

The methods inside of a controller are called actions. Usually an action reads the incoming request-data, maybe validates it with a form, delegates it to a client and writes the response.

The following controller provides two actions: `indexAction()` and `testAction()`.

```php
<?php
namespace Namespace\Yves\Bundle\Controller;

use Spryker\Yves\Kernel\Controller\AbstractController;

 
class IndexController extends AbstractController
{
    public function indexAction()
    {
        return $this->viewResponse([]);
    }
 
    public function testAction(Request $request)
    {
       return $this->viewResponse([]);
    }
}
```

## Input Parameters

You can define an input parameter `$request` that is automatically injected. This is a [Symfony\Component\HttpFoundation\Request](https://symfony.com/doc/2.3/components/http_foundation/introduction.html#request), so you will find methods to fetch the get and post parameters and the session.

```php
<?php
public function testAction(Request $request)
{
    $request->getSession(); // retrieve current session
    $request->query->get('a'); // retrieve get-parameter index?a=
    // ...
}
```

## Response Methods

There are several ways to send responses in different use cases. These methods are called at the end of the action and their return value is returned by the action. e.g. return `$this->redirectResponse('/my-module')`.

| Response Method                                              | Purpose                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| viewResponse(array $data = [])                               | Loads the related twig template and provides the data for the template. |
| jsonResponse($data = null, $status = 200, $headers = [])     | Sends a json response which is needed for ajax calls.        |
| redirectResponse($url, $status = 302, $headers = [])         | Performs a redirect to the given relative path or absolute url. |
| streamedResponse($callback = null, $status = 200, $headers = []) | ends binary data. This is used to draw the state machines    |

**Example of usage in an action**:

```php
<?php
public function testAction(Request $request)
{
    // ...
    return $this->viewResponse(['customer' => ['name' => 'John doe']]);
}
```

Now the data can be accessed in the twig template like this: `{% raw %}{{{% endraw %}customer.name{% raw %}}}{% endraw %} `.

## Controllers and Paths in Yves

URL routing in Yves is not the same as URL routing in Zed. You can route a custom URL to a module-controller-action triple.

To learn more about URL routing in Yves, check out [Implementing URL Routing in Yves](/docs/scos/dev/back-end-development/yves/implementing-url-routing-in-yves.html).

## Twig Template in Yves

Each action which returns `$this->viewResponse()` must have a dedicated Twig template:

* Controller and action:

```php
MyNamespace/Yves/MyBundle/Controller/TestController::doSomethingAction()
```

* Expected path of template:

```php
MyNamespace/Yves/MyBundle/Theme/{ThemeName}/Test/do-something.twig
```
