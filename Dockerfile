FROM schubertkonstantin/root:dependencies

MAINTAINER Konstantin Schubert <schubert.konstantin@gmail.com>
# based on a Dockerfile by Sebastian Neubert

USER root

#trying to fix failing installs
RUN apt-get -y install  ncurses-dev libncurses5


WORKDIR /tmp


# clone ROOT
# By cloning all branches, we get the same base image for all builds
RUN git clone --depth 1 http://root.cern.ch/git/root.git
# install ROOT 
RUN git checkout tag/v5-34-23 http://root.cern.ch/git/root.git
RUN mkdir root-build     && cd root-build     && cmake ../root -Dmathmore=ON -Dminuit2=ON -Droofit=ON -Dhdfs=OFF  -Dbuiltin_xrootd=ON -DCMAKE_INSTALL_PREFIX=/usr/local     && make -j3     && cmake --build . --target install     && cd ..     && rm -rf root root-build


ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH /usr/local/lib:$PYTHONPATH
