## ROS Nuttx STM32
-------------

[![ros-nuttx-stm32](https://img.shields.io/badge/build-passing-blue.svg)]()
[![license](https://img.shields.io/badge/license-NewBSD-blue.svg)]()
[![ros-nuttx-stm32](https://img.shields.io/badge/platform-embedded-blue.svg)]()

ROS 2.0 for embedded systems using NuttX, Tinq and the STM32F4 IC with follow modular blocks:

```
----------------------------------
|           application           |
----------------------------------
|               rcl               |
----------------------------------
|            DDS (Tinq)           |
----------------------------------
|          RTOS (NuttX)           |
__________________________________

|        Hardware (STM32F4)       |
----------------------------------

```

## build in docker

----

build and install the docker gcc avr toolchain

```bash

git clone https://github.com/Lembed/ROS-Nuttx-STM32
cd ROS-Nuttx-STM32/tools/docker
docker build -t="ros-nuttx" .
cd ../../

```

to build skeleton, the first is to start up the docker and map the skeleton.c to docker

```bash

docker run  -v $(pwd):/opt/ros -it ros-nuttx bash

```

then build the source with docker tools use make

```bash
cd /opt/ros/nuttx/tools
./configure.sh stm3240g-eval/dds
cd ../nuttx/
make 
```


## File structure

---

- **apps**: NuttX applications. The subdirectory `examples` contains some of the DDS apps.
- **tinq-core**: Tinq's DDS implementation hacked to work with NuttX.
- **misc**: Variety of things.
- **nuttx**: The NuttX RTOS.
- **NxWidgets**: a special graphical user interface.
- **rcl**: ROS 2 Client Library (Ros Client Library) for embedded.
- **README.md**: this file.
- **tools**: a set of useful tools for development.


### ROS Client Library
The [ROS Client Library](rcl/README.md) (rcl) for embedded (implemented under the `rcl` directory) allows to code ROS applications using the ROS 2 API. Refer to [rcl.h](rcl/rcl.h) for a list of functions.

A simple ROS publisher can be coded with:

```c

#include "rcl.h"

int ros_main(int argc, char *argv[])
{
    /* Init the ROS Client Library */
    rcl_init();
    
    /* Create a ROS node */
    create_node();

    /* Init the dynamic types 
        TODO: abstract this code
    */
    init_types();

    /* Create a publisher
        TODO: specify message types, topics, etc.
    */
    create_publisher();

    int i;
    for (i=0; i<10; i++){
        publish("Hello ROS 2");
    }
}

```

Refer to the [rcl/README.md](rcl/README.md) for further instructions on how to use the ROS 2 API to code applications.

## Applications
Applications are coded at `apps/ros`. Refer to `apps/ros/publisher` for an example.


## license
Much of the code and documentation enclosed is copyright by the Free Software Foundation, Inc.
See the file copyright/license in the various directories