FROM ubuntu:24.04

ARG SKIA_ZIP_URL
ARG ASEPRITE_ZIP_URL

ENV SKIA_ZIP_URL=${SKIA_ZIP_URL}
ENV ASEPRITE_ZIP_URL=${ASEPRITE_ZIP_URL}
ENV CC=clang
ENV CXX=clang++

RUN apt-get update && apt-get install -y \
    g++ clang libc++-dev libc++abi-dev \
    cmake ninja-build libx11-dev libxcursor-dev libxi-dev \
    libgl1-mesa-dev libfontconfig1-dev wget unzip && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget $SKIA_ZIP_URL && \
    mkdir skia && \
    unzip Skia-Linux-Release-x64-libc++.zip -d /skia && \
    rm Skia-Linux-Release-x64-libc++.zip

RUN wget $ASEPRITE_ZIP_URL && \
    mkdir aseprite && \
    unzip Aseprite-v1.3.8.1-Source.zip -d /aseprite && \
    rm Aseprite-v1.3.8.1-Source.zip

RUN mkdir /aseprite/build

WORKDIR /aseprite/build

RUN cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_CXX_FLAGS:STRING=-stdlib=libc++ \
    -DCMAKE_EXE_LINKER_FLAGS:STRING=-stdlib=libc++ \
    -DLAF_BACKEND=skia \
    -DSKIA_DIR=/skia \
    -DSKIA_LIBRARY_DIR=/skia/out/Release-x64 \
    -DSKIA_LIBRARY=/skia/out/Release-x64/libskia.a \
    -G Ninja \
    -B /aseprite/build /aseprite

RUN ninja aseprite
