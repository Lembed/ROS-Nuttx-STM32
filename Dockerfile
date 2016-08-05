FROM ubuntu:trusty
MAINTAINER Vinicius Tinti <viniciustinti@gmail.com>

RUN apt-get update
RUN apt-get install -y git-core
RUN apt-get install -y build-essential gperf flex bison libncurses5-dev libncursesw5-dev
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y binutils-arm-none-eabi gcc-arm-none-eabi gdb-arm-none-eabi libnewlib-arm-none-eabi
RUN apt-get clean

RUN mkdir /work

RUN git clone https://bitbucket.org/nuttx/apps.git /work/apps
RUN git clone https://bitbucket.org/patacongo/nuttx.git /work/nuttx
RUN cd /work/nuttx; \
    git submodule update --init

RUN mkdir /work/nuttx/misc
RUN git clone https://bitbucket.org/nuttx/buildroot.git /work/nuttx/misc/buildroot
RUN git clone https://bitbucket.org/nuttx/tools.git /work/nuttx/misc/tools

RUN cd /work/nuttx/misc/tools/kconfig-frontends; \
    ./configure --enable-mconf -prefix=/usr; \
    make; \
    make install

WORKDIR /work

CMD [ "/bin/bash" ]
