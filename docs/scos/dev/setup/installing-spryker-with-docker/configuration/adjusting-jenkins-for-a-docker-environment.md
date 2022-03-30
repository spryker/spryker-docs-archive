---
title: Adjusting Jenkins for a Docker environment
description: DevOPS guidelines for running Spryker in Docker.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/additional-devops-guidelines
originalArticleId: 9ffe0d4c-9910-46c8-97f2-e3b51c5a1e82
redirect_from:
  - /2021080/docs/additional-devops-guidelines
  - /2021080/docs/en/additional-devops-guidelines
  - /docs/additional-devops-guidelines
  - /docs/en/additional-devops-guidelines
  - v6/docs/additional-devops-guidelines
  - v6/docs/en/additional-devops-guidelines
  - v5/docs/additional-devops-guidelines
  - v5/docs/en/additional-devops-guidelines
  - v4/docs/additional-devops-guidelines
  - v4/docs/en/additional-devops-guidelines
  - /v3/docs/additional-devops-information-201907
  - /v3/docs/en/additional-devops-information-201907
---


Follow the steps to adjust the Jenkins scheduler to docker like environments:
1. Update the scheduler configuration settings in `src/Pyz/Zed/Scheduler/SchedulerDependencyProvider.php`:

```php
// ---------- Scheduler
$config[SchedulerConstants::ENABLED_SCHEDULERS] = [
    SchedulerConfig::SCHEDULER_JENKINS,
];
$config[SchedulerJenkinsConstants::JENKINS_CONFIGURATION] = [
    SchedulerConfig::SCHEDULER_JENKINS => [
        SchedulerJenkinsConfig::SCHEDULER_JENKINS_BASE_URL => 'http://' . getenv('SPRYKER_SCHEDULER_HOST') . ':' . getenv('SPRYKER_SCHEDULER_PORT') . '/',
    ],
];

$config[SchedulerJenkinsConstants::JENKINS_TEMPLATE_PATH] = getenv('SPRYKER_JENKINS_TEMPLATE_PATH');
```

2. Using the example in `src/Pyz/Zed/Scheduler/SchedulerDependencyProvider.php`, put the template where  `SPRYKER_JENKINS_TEMPLATE_PATH ` points to:

```php
{% raw %}{%{% endraw %} extends 'jenkins-job.default.xml.twig' {% raw %}%}{% endraw %}

{% raw %}{%{% endraw %} block setup {% raw %}%}{% endraw %}{% raw %}{%{% endraw %} endblock setup {% raw %}%}{% endraw %}

{% raw %}{%{% endraw %} block command {% raw %}%}{% endraw %}<![CDATA[
    docker run -i --rm \
        your-image \
        -e APPLICATION_STORE={% raw %}{{{% endraw %} job.store {% raw %}}}{% endraw %} \
        bash -c \
        "{% raw %}{{{% endraw %} job.command {% raw %}}}{% endraw %}"
]]>{% raw %}{%{% endraw %} endblock command {% raw %}%}{% endraw %}

```

{% info_block infoBox %}

You can define additional store-specific variables if needed.

{% endinfo_block %}

3. Set up deployment, so that the following environment variables are set in the container where  `console scheduler:setup ` is run:
*  `SPRYKER_SCHEDULER_HOST `
*   `SPRYKER_SCHEDULER_PORT `
*    `SPRYKER_JENKINS_TEMPLATE_PATH `
