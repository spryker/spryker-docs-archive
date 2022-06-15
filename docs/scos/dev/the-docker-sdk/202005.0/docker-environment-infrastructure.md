---
title: Docker Environment Infrustructure
search: exclude
last_updated: Apr 3, 2020
template: howto-guide-template
originalLink: https://documentation.spryker.com/v5/docs/docker-environment-infrastructure
originalArticleId: 4522f09b-3adc-4703-af50-273fd7454939
redirect_from:
  - /v5/docs/docker-environment-infrastructure
  - /v5/docs/en/docker-environment-infrastructure
---

This document describes the infrustructure of Spryker in Docker environment.

Spryker containers  follow the rules:

1. **Single responsibility** - each container is responsible for a single role which must be defined in specification.
2. **Immutability** - container does not create or change files in its own file system. If container requires storage, a volume should be designated for the purpose. Temporary files are not covered by the rule.
3. **A single process or a process group** - there is a single process running as an entry point of container. The name of the process must be defined in specification.
4. **Process run without root permissions.**
5. **Only single-purpose ports are exposed** - the only exposed ports are the ones supporting the single responsibility of container. The port(s) must be defined in specification. Service ports are not covered by the rule.

Below, you can find the diagram of Spryker in Docker environment:

 ![Local docker environment diagram](https://spryker.s3.eu-central-1.amazonaws.com/docs/Developer+Guide/Installation/Spryker+in+Docker/docker-local-environment-diagram.png) 


