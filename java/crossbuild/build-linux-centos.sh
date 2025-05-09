#!/usr/bin/env bash
# Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.

set -e

# remove fixed relesever variable present in the hanscode boxes
sudo rm -f /etc/yum/vars/releasever

# enable EPEL
sudo yum -y install epel-release

# install all required packages for rocksdb that are available through yum
sudo yum -y install openssl java-1.7.0-openjdk-devel zlib-devel bzip2-devel lz4-devel snappy-devel libzstd-devel jemalloc-devel cmake3

# set up cmake3 as cmake binary
sudo alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake 10 --slave /usr/local/bin/ctest ctest /usr/bin/ctest --slave /usr/local/bin/cpack cpack /usr/bin/cpack --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake
sudo alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake3 20 --slave /usr/local/bin/ctest ctest /usr/bin/ctest3 --slave /usr/local/bin/cpack cpack /usr/bin/cpack3 --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake3

# install gcc/g++ 4.8.2 from tru/devtools-2
sudo wget -O /etc/yum.repos.d/devtools-2.repo https://people.centos.org/tru/devtools-2/devtools-2.repo
sudo yum -y install devtoolset-2-binutils devtoolset-2-gcc devtoolset-2-gcc-c++

# install gflags
wget https://github.com/gflags/gflags/archive/v2.0.tar.gz -O gflags-2.0.tar.gz
tar xvfz gflags-2.0.tar.gz; cd gflags-2.0; scl enable devtoolset-2 ./configure; scl enable devtoolset-2 make; sudo make install
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# set java home so we can build rocksdb jars
export JAVA_HOME=/usr/lib/jvm/java-1.7.0

export PATH=$JAVA_HOME:/usr/local/bin:$PATH

# build rocksdb
cd /rocksdb
scl enable devtoolset-2 'make clean-not-downloaded'
scl enable devtoolset-2 'PORTABLE=1 make -j8 rocksdbjavastatic'
cp /rocksdb/java/target/libforstjni-* /rocksdb-build
cp /rocksdb/java/target/forstjni-* /rocksdb-build
