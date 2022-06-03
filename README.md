# GRPC Gateway

[![publish to docker hub](https://github.com/fonoster/grpc-gateway/actions/workflows/gh-docker.yml/badge.svg)](https://github.com/fonoster/grpc-gateway/actions/workflows/gh-docker.yml)

This repository contains a dockerized distribution of Fonoster GRPC Gateway for use in [Fonoster](https://github.com/fonoster/fonoster). For more documentation on how Fonoster images are constructed and how to work with them, please see the [documentation](https://github.com/fonoster/fonoster).

## Available Versions

You can see all images available to pull from Docker Hub via the [Tags](https://hub.docker.com/repository/docker/fonoster/grpc-gateway/tags?page=1) page. Docker tag names that begin with a "change type" word such as task, bug, or feature are available for testing and may be removed at any time.

> The version is the same of the Asterisk this is image is based on

## Installation

You can clone this repository and manually build it.

```
cd fonoster/grpc-gateway\:%%VERSION%%
docker build -t fonoster/grpc-gateway:%%VERSION%% .
```

Otherwise you can pull this image from docker index.

```
docker pull fonoster/grpc-gateway:%%VERSION%%
```

## Usage Example

The following is a basic example of using this image.

```
docker run -it \
  -p 8080:8080 \
  -e APISERVER_ENDPOINT="localhost:50052" \
  fonoster/grpc-gateway
```

## Environment Variables

Environment variables are used in the entry point script to render configuration templates. You can specify the values of these variables during `docker run`, `docker-compose up`, or in Kubernetes manifests in the `env` array.

- `APISERVER_ENDPOINT` - GRPC endpoint. Defaults to `localhost:50051`
- `DEBUG` - Set to "true" send debug information to the terminal. Defaults to "false"

## Exposed ports

- `8080` - Default SIP port

## Contributing

Please read [CONTRIBUTING.md](https://github.com/fonoster/fonoster/blob/main/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

- [Pedro Sanders](https://github.com/psanders)

See also the list of contributors who [participated](https://github.com/fonoster/grpc-gateway/contributors) in this project.

## License

Copyright (C) 2022 by Fonoster Inc. MIT License (see [LICENSE](https://github.com/fonoster/fonoster/blob/main/LICENSE) for details).
