# VSCode ROS2 Workspace Template

This template is a complete setup for developing ROS2 jazzy packages with [Visual Studio Code](https://code.visualstudio.com/) and [the Remote Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) on Ubuntu.

I modeled my template on [athackst's vscode_ros2_workspace](https://github.com/athackst/vscode_ros2_workspace/tree/humble) with some modifications like:

- richer set of devcontainer extensions,
- use of compose.yaml in the devcontainer setup,
- `osrf/ros:jazzy-desktop-full` as the base image,
- use of nvidia runtime,
- cleaner workspace setup,
- other minor changes.

## Development

See [DEVELOPMENT.md](DEVELOPMENT.md) for some devcontainer development instructions.
