ARG BASE_DOCKER_IMAGE=osrf/ros:kilted-desktop-full
FROM $BASE_DOCKER_IMAGE AS base

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

# Create a non-root user if necessary

# ARG USERNAME=ros
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID

# I assume there is already a user created in the base image
ARG USERNAME=ubuntu
ENV USERNAME=$USERNAME

# RUN groupadd --gid $USER_GID $USERNAME \
#   && useradd -m \
#   -s /bin/bash \
#   -G sudo,plugdev,dialout \
#   --uid $USER_UID \
#   --gid $USER_GID \
#   $USERNAME \
#   # Add sudo support for the non-root user
#   && apt-get update \
#   && apt-get install -y sudo \
#   && echo "$USERNAME ALL=\(root\) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME\
#   && chmod 0440 /etc/sudoers.d/$USERNAME \
#   && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# Basic tools
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-argcomplete \
    python3-rosdoc2 \
    htop \
    git \
    vim \
    gdb \
    rsync \
    strace \
    ros-dev-tools \
    bash-completion \
    && rm -rf /var/lib/apt/lists/*

USER ubuntu

# Set up autocompletion for user
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /home/$USERNAME/.bashrc \
    && echo "if [ -f /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash ]; then source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash; fi" >> /home/$USERNAME/.bashrc \
    && echo "if [ -f /usr/share/colcon_cd/function/colcon_cd.sh ]; then source /usr/share/colcon_cd/function/colcon_cd.sh; export _colcon_cd_root=/opt/ros/${ROS_DISTRO}; fi" >> /home/$USERNAME/.bashrc 

ENV DEBIAN_FRONTEND=

FROM base AS app

ENV DEBIAN_FRONTEND=noninteractive

# Install ROS 2 big packages
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \ 
    # Does not exist yet for kilted?
    # ros-${ROS_DISTRO}-plotjuggler-ros \
    ros-${ROS_DISTRO}-rqt* \
    ros-${ROS_DISTRO}-ament-* \
    ros-${ROS_DISTRO}-rviz2 \
    && sudo rm -rf /var/lib/apt/lists/*

ARG WORKSPACE=/ros_ws
ENV WORKSPACE=$WORKSPACE
WORKDIR $WORKSPACE

RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/$USERNAME/.bashrc

ENV DEBIAN_FRONTEND=
