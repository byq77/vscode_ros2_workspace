# Development

## Docks

- <https://code.visualstudio.com/docs/devcontainers/containers>

## Docker

To build the docker image:

```shell
docker build -f docker/Dockerfile \
-t ros2_jazzy_nvidia:latest \
--build-arg \
BASE_DOCKER_IMAGE=osrf/ros:jazzy-desktop-full \
WORKSPACE=/ros_ws \
--target app  \
.
```

To build the docker image and run bash command in the container:

```shell
docker compose -f docker/compose.yaml \
run --remove-orphans --build --rm \
ros2_jazzy_nvidia bash
```
