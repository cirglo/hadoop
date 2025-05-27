FROM ubuntu:noble AS builder

ARG HADOOP_VERSION=3.4.1

ENV HADOOP_TAR="hadoop-${HADOOP_VERSION}-src.tar.gz"
ENV HADOOP_URL="https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_TAR}"

# Set the working directory
WORKDIR /opt/hadoop-src

# Install necessary dependencies
RUN apt-get -y update
RUN apt-get -y upgrade 

RUN apt-get install -y bash

RUN apt-get -y install openjdk-11-jdk

RUN apt-get install -y maven curl

RUN apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    cmake \
    zlib1g-dev \
    pkg-config \
    libssl-dev \
    libsasl2-dev \
    software-properties-common

RUN apt-get -y install g++ gcc

RUN curl -L https://github.com/protocolbuffers/protobuf/archive/refs/tags/v3.21.12.tar.gz > protobuf-3.21.12.tar.gz
RUN tar -zxvf protobuf-3.21.12.tar.gz
RUN cd protobuf-3.21.12 && \
    ./autogen.sh && \
    ./configure && \
    make -j$(nproc) && \
    make install

#RUN curl -L https://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.bz2/download > boost_1_72_0.tar.bz2
#RUN tar --bzip2 -xf boost_1_72_0.tar.bz2
#RUN cd boost_1_72_0 && \
#    bash ./bootstrap.sh --prefix=/usr/ && \
#    ./b2 --without-python && \
#    ./b2 --without-python install

RUN apt-get -y install libsnappy-dev
RUN apt-get -y install bzip2 libbz2-dev
RUN apt-get -y install fuse libfuse-dev
RUN apt-get -y install libzstd-dev 

# Get the source code for Hadoop
RUN curl -O ${HADOOP_URL} 

# Extract the downloaded tarball
RUN tar xzf ${HADOOP_TAR}

# Build the Hadoop sources
RUN cd "hadoop-${HADOOP_VERSION}-src" && \
    mvn dependency:resolve
RUN cd "hadoop-${HADOOP_VERSION}-src" && \
    mvn install -DskipTests -Drequire.snappy -Drequire.zstd -Drequire.bzip2 -Drequire.fuse
RUN cd "hadoop-${HADOOP_VERSION}-src" && \
    mvn package -Pdist -Pnative -Dtar -Pyarn-ui -DskipTests -Drequire.snappy -Drequire.zstd -Drequire.bzip2 -Drequire.fuse


# Set the entrypoint for the container
ENTRYPOINT ["bash"]