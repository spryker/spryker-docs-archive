---
title: Overriding Webpack, JS, SCSS for ZED on project level
description: Learn how to override Webpack, JS, SCSS for ZED on a project level
last_updated: Jul 2, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/overriding-webpack-js-scss-for-zed-on-project-level
originalArticleId: 3b57ce80-48b2-47b1-afd0-cd14bf6e07fb
redirect_from:
  - /2021080/docs/overriding-webpack-js-scss-for-zed-on-project-level
  - /2021080/docs/en/overriding-webpack-js-scss-for-zed-on-project-level
  - /docs/overriding-webpack-js-scss-for-zed-on-project-level
  - /docs/en/overriding-webpack-js-scss-for-zed-on-project-level
  - /v6/docs/verriding-webpack-js-scss-for-zed-on-project-level
  - /v6/docs/en/verriding-webpack-js-scss-for-zed-on-project-level
  - /v5/docs/verriding-webpack-js-scss-for-zed-on-project-level
  - /v5/docs/en/verriding-webpack-js-scss-for-zed-on-project-level
  - /v4/docs/verriding-webpack-js-scss-for-zed-on-project-level
  - /v4/docs/en/verriding-webpack-js-scss-for-zed-on-project-level
  - /v3/docs/verriding-webpack-js-scss-for-zed-on-project-level
  - /v3/docs/en/verriding-webpack-js-scss-for-zed-on-project-level
  - /v2/docs/verriding-webpack-js-scss-for-zed-on-project-level
  - /v2/docs/en/verriding-webpack-js-scss-for-zed-on-project-level
  - /v1/docs/verriding-webpack-js-scss-for-zed-on-project-level
  - /v1/docs/en/verriding-webpack-js-scss-for-zed-on-project-level
---

To override or expand core JS and SCSS files, you need to expand the oryx-for-zed building system with an additional config:

* See [Webpack](#webpack) for details on how to adjust the Webpack config and create aliases for core modules.
* See [JS](#js) for details on creating a new entry point, file naming, extending core JS files, and path for entry points.
* See [SCSS](#scss) for details on how to create a new file with styles and how to build it with Webpack.
* See [TWIG](#twig) for details on how to add output JS and CSS on a page.

## Webpack

Create a new js file in `./frontend/zed/build.js`. Copy the code below to the file:

```js
const oryx = require("@spryker/oryx");
const oryxForZed = require("@spryker/oryx-for-zed");
const path = require('path');
const merge = require('webpack-merge');
const mergeWithStrategy = merge.smartStrategy({
    plugins: 'prepend'
});

const myCustomZedSettings = mergeWithStrategy(oryxForZed.settings, {
    entry: {
        dirs: [path.resolve('./src/Pyz/Zed/')] // Path for entry points on project level
    }
});

oryxForZed.getConfiguration(myCustomZedSettings).then(configuration => oryx.build(configuration));
```
`oryx-for-zed` building settings must be expanded with a path to ZED modules on the project level (line 11). Due to `mergeWithStrategy`, the default config with core paths is expanded with a path to the project level.

{% info_block infoBox %}

Use `merge` from Webpack (see the example above) instead  of `Object.assign(…)`. If you use `Object.assign(…)`, entry points config will be fully overwritten.

{% endinfo_block %}

If new packages have been installed for modules via `npm`, specify the path to the `resolveModules` option on the project level.

Example:

```js
const myCustomZedSettings = mergeWithStrategy(oryxForZed.settings, {
    ...,
    resolveModules: {
        dirs: [path.resolve('./src/Pyz/Zed/')]
    }
});
```
After you have created the new build for ZED, specify the new commands in root `package.json`.

Example:

```
{
  scripts: {
    ...,
    "zed": "node ./frontend/zed/build",
    "zed:watch": "node ./frontend/zed/build --dev",
    "zed:production": "node ./frontend/zed/build --prod"
  }
}
```
### Aliases

To extend the core JS, there should be Webpack aliases for the core modules. To make the new aliases available, extend the Webpack configuration with the new aliases:

```
oryxForZed.getConfiguration(myCustomZedSettings).then(configuration => oryx.build(mergeWithStrategy(configuration, {
    resolve: {
        alias: {
            {% raw %}{%{% endraw %}AliasName{% raw %}%}{% endraw %}: 'path/to/module/assets' // Example: 'Gui/assets/Zed/js/**'
        }
    }
})));
```
{% info_block infoBox %}

You can check the existing list of aliases in the [webpack.config.js](https://github.com/spryker/oryx-for-zed/blob/master/lib/webpack.config.js#L57) file of `oryx-for-zed`.

{% endinfo_block %}

## JS

The newly created entry points for JS files should have suffix `.entry`, for example, `my-module.entry.js`). Webpack collects all entry points with this suffix.

Use the following path to add all new entry points for your project: `./src/Pyz/Zed/{% raw %}{%{% endraw %}ModuleName{% raw %}%}{% endraw %}/assets/Zed/js/*.entry.js`.

To extend JS modules from the core level, use [aliases](#aliases). To add a JS module, follow the example:

```
require('{% raw %}{%{% endraw %}AliasName{% raw %}%}{% endraw %}/path/to/file.js');
// OR
var ModuleName = require('{% raw %}{%{% endraw %}AliasName{% raw %}%}{% endraw %}/path/to/file.js');
```
## SCSS

Use the following path to add all files with style:  `./src/Pyz/Zed/{% raw %}{%{% endraw %}ModuleName{% raw %}%}{% endraw %}/assets/Zed/sass/*.scs`.  Webpack collects only those styles that were provided in the entry point (JS).

Add style files by following the example:

```
require('path/to/file.scss') // Example: '../sass/*.scss'
```
{% info_block infoBox %}

The generated CSS file will have the same naming as the JS entry point. For example, if JS entry point’s name is *spryker-gui.entry.js*, then CSS output will be *spryker-gui.css*.

{% endinfo_block %}

## TWIG

Webpack generates each entry point as a separate JS file. If JS file is not added to the TWIG JS, it won’t work.
Keep in mind, that file generated by Webpack JS doesn’t have `.entry` suffix, so instead of, for example, *module-name.entry.js* the name will be *module-name.js*:

```
<script src="{% raw %}{{{% endraw %} assetsPath('js/*.js') {% raw %}}}{% endraw %}"></script>
```
The newly generated styles have to be added to the twig template too. Note that Webpack automatically renames the output css files with the JS entry point name:

```
<link rel="stylesheet" href="{% raw %}{{{% endraw %} assetsPath('css/*.css') {% raw %}}}{% endraw %}">
```
