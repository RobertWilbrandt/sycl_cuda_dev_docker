FROM nvidia/cuda:10.1-devel-ubuntu18.04
LABEL maintainer="Robert Wilbrandt <robert@stamm-wilbrandt.de>"
LABEL description="Development environment for using hipSYCL with cuda 10.1"

ARG HIPSYCL_TARGETS

# Install basic tools
RUN apt update \
 && apt install -y vim git wget ninja-build lsb-release software-properties-common

# Install current compiler toolchain
RUN wget https://apt.llvm.org/llvm.sh \
 && chmod +x llvm.sh \
 && ./llvm.sh 11 \
 && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-11 11 \
 && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-11 11 \
 && update-alternatives --install /usr/bin/cc cc /usr/bin/clang 30 \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 30 \
 && apt install -y libstdc++-8-dev

# Install cmake
RUN mkdir system \
 && cd system \
 && wget https://cmake.org/files/v3.20/cmake-3.20.4-linux-x86_64.tar.gz \
 && tar xf cmake-3.20.4-linux-x86_64.tar.gz

ENV PATH="/system/cmake-3.20.4-linux-x86_64/bin:${PATH}"

# Install current boost from source
RUN cd system \
 && wget https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.gz \
 && tar xf boost_1_76_0.tar.gz \
 && cd boost_1_76_0 \
 && ./bootstrap.sh --prefix=/usr \
 && ./b2 link=static,shared install -j$(nproc)

# Install hipSYCL dependencies
RUN apt install -y python3 libclang-11-dev

# Get hipSYCL
RUN cd system \
 && git clone https://github.com/illuhad/hipSYCL.git \
 # Ugly hack, but this is needed as we have a libstdc++ 8 which requires this for <filesystem> and newer
 # libstdc++ versions irritate CUDA
 && echo "target_link_libraries(hipSYCL-rt PUBLIC stdc++fs)" >> /system/hipSYCL/src/runtime/CMakeLists.txt

# Build hipSYCL
RUN cd system/hipSYCL \
 && mkdir build \
 && cd build \
 && cmake .. -GNinja -DWITH_CUDA_BACKEND=ON \
 && cmake --build . --target install

# Get, build and install syclinfo
RUN cd system \
 && git clone https://github.com/illuhad/syclinfo.git \
 && cd syclinfo \
 && mkdir build \
 && cd build \
 && HIPSYCL_TARGETS=${HIPSYCL_TARGETS} cmake .. -GNinja -DCMAKE_CXX_COMPILER=syclcc \
 && cmake --build . \
 && ln -s $(pwd)/syclinfo /usr/local/bin

CMD ["bash"]
