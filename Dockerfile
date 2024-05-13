# syntax=docker/dockerfile:1
FROM ros:humble-ros-core-jammy

WORKDIR /project
# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# setup colcon mixin and metadata
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-ros-base=0.10.0-1* \
    && rm -rf /var/lib/apt/lists/*

#RUN apt-get install ros-humble-joy ros-humble-joy-drivers

#COPY . ~/project
RUN git clone https://github.com/GreetingsAvil/Pioneers

RUN sudo apt-get update && sudo apt install -y joystick jstest-gtk evtest 
RUN sudo apt install -y ros-humble-joy*
RUN git clone https://github.com/reedhedges/AriaCoda.git
#RUN cd AriaCoda && make && make install 

