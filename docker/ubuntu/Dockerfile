FROM ubuntu:disco
RUN apt-get update && apt-get -q -y install cmake clang bison flex xz-utils libfuse-dev libudev-dev \
pkg-config libc6-i386 linux-headers-generic gcc-multilib libcap2-bin libcairo2-dev libgl1-mesa-dev \
libtiff5-dev libfreetype6-dev libfreetype6 git libelf-dev libxml2-dev libegl1-mesa-dev libfontconfig1-dev libbsd-dev
RUN git clone --recurse-submodules https://github.com/darlinghq/darling.git && cd /darling && mkdir build && cd build && cmake ..
RUN cd /darling/build && make && make install && make lkm && make lkm_install
RUN apt-get purge -y --auto-remove <packages> && apt-get clean && rm -rf /var/lib/apt/lists
EXPOSE 22
#ENTRYPOINT darling shell
ENTRYPOINT bash