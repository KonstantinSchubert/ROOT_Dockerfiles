FROM ubuntu:14.04

MAINTAINER Konstantin Schubert <schubert.konstantin@gmail.com>
# based on a Dockerfile by Sebastian Neubert


# install basic libraries
USER root
RUN apt-get -y update && apt-get -y install     build-essential     cmake     gfortran     git     graphviz-dev     libafterimage0     libafterimage-dev     libavahi-compat-libdnssd-dev     libxpm-dev     libxft-dev     libxext-dev     libpng3     libjpeg8     libssl-dev     libpcre3-dev     libgl1-mesa-dev     libglew1.5-dev     libgsl0-dev     libftgl-dev     libmysqlclient-dev     libfftw3-dev libcfitsio3-dev     libldap2-dev     libxml2-dev     libx11-dev     vim

# install boost
RUN apt-get -y install  libboost-all-dev


WORKDIR /tmp


# install ROOT 
RUN git clone --depth 1 --branch v5-99-03 http://root.cern.ch/git/root.git
RUN mkdir root-build     && cd root-build     && cmake ../root -Dmathmore=ON -Dminuit2=ON -Droofit=ON -Dhdfs=OFF  -Dbuiltin_xrootd=ON -DCMAKE_INSTALL_PREFIX=/usr/local     && make -j3     && cmake --build . --target install     && cd ..     && rm -rf root root-build


ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH /usr/local/lib:$PYTHONPATH
