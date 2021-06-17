FROM nvidia/cuda:10.1-devel-ubuntu18.04
LABEL maintainer="Robert Wilbrandt <robert@stamm-wilbrandt.de>"
LABEL description="Development environment for using hipSYCL with cuda 10.1"

# Install basic tools
RUN apt update \
 && apt install -y vim git wget ninja-build

# Install cmake
RUN mkdir system \
 && cd system \
 && wget https://cmake.org/files/v3.20/cmake-3.20.4-linux-x86_64.tar.gz \
 && tar xf cmake-3.20.4-linux-x86_64.tar.gz

ENV PATH="/system/cmake-3.20.4-linux-x86_64/bin:${PATH}"

CMD ["bash"]
