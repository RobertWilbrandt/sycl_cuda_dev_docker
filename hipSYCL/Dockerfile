FROM nvidia/cuda:10.1-devel-ubuntu18.04
LABEL maintainer="Robert Wilbrandt <robert@stamm-wilbrandt.de>"
LABEL description="Development environment for using hipSYCL with cuda 10.1"

# Install basic tools
RUN apt update \
 && apt install -y vim git wget ninja-build

# Update to newer gcc for <filesystem> support
RUN apt install -y gcc-8 g++-8 libstdc++-8-dev \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7 \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

# Install cmake
RUN mkdir system \
 && cd system \
 && wget https://cmake.org/files/v3.20/cmake-3.20.4-linux-x86_64.tar.gz \
 && tar xf cmake-3.20.4-linux-x86_64.tar.gz

ENV PATH="/system/cmake-3.20.4-linux-x86_64/bin:${PATH}"

# Install hipSYCL dependencies
RUN apt install -y python3 libboost-fiber-dev libboost-context-dev llvm-10 clang-10 libclang-10-dev

# Get hipSYCL
RUN cd system \
 && git clone https://github.com/illuhad/hipSYCL.git

# Compile hipSYCL
RUn cd system/hipSYCL \
 && mkdir build \
 && cd build \
 && cmake .. -GNinja \
 && cmake --build . --target install

CMD ["bash"]
