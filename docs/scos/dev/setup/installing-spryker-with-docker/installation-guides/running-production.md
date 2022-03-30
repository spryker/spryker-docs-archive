---
title: Running production
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/running-production-mode
originalArticleId: 73489708-d2d7-4b44-a353-f8972ac45ede
redirect_from:
  - /2021080/docs/running-production-mode
  - /2021080/docs/en/running-production-mode
  - /docs/running-production-mode
  - /docs/en/running-production-mode
  - /v6/docs/running-production-mode
  - /v6/docs/en/running-production-mode
  - /v5/docs/running-production-mode
  - /v5/docs/en/running-production-mode
  - /v4/docs/running-production-mode
  - /v4/docs/en/running-production-mode
---

This document describes the procedure of generating images and assets suitable for a production environment. After going through all the steps, it's up to you how to proceed further.

{% info_block infoBox %}
This functionality is available in the Docker SDK from version 1.7.2.
{% endinfo_block %}

Follow the steps to generate Docker images and assests for a production environment:

1. Clone or update the Docker SDK repository to version 1.7.2.

```bash
git clone https://github.com/spryker/docker-sdk.git -b 1.7.2 --single-branch docker
```

2. Bootstrap docker setup:

```bash
docker/sdk bootstrap
```
{% info_block warningBox "Bootstrap" %}

Once you finish the setup, you don't need to run `bootstrap` to start the instance. You only need to run it after:
* Docker SDK version update;
* Deploy file update.

{% endinfo_block %}
3. Run the command to generate docker images for each application:

```
docker/sdk export images [tag]
```

* The `[tag]` argument is an alphanumerical value used for patching the images. The value will be added to the name of each generated image.
* After running the command, you will see the list of created images in the output.

4. Run the command to generate archives with assets for each application:

```
docker/sdk export assets [tag] [path]
```

* The `[tag]` argument is an alphanumerical value used for patching the archives. The value will be added to the name of each generated archive.
* The `[path]` argument defines the folder into which the generated archives are placed.
* After running the command, you will see the list of created archives in the output.
