# add the platform to avoid problems related to apple silicon processors
FROM --platform=linux/amd64 ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ARG USER_ID=root
ENV USER_ID $USER_ID
RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*
## Change user to $USER_ID
USER $USER_ID
WORKDIR /home/$USER_ID
ENV HOME /home/$USER_ID
## Git install
RUN apt-get -y update
RUN apt-get -y install git

####### R
RUN apt-get update && apt-get install -y --no-install-recommends build-essential r-base 
## enable R package install
RUN chmod a+w /usr/local/lib/R/site-library

RUN apt-get update && apt-get install -y --no-install-recommends \
  libgit2-dev \
  libssl-dev \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  zlib1g-dev \
  libharfbuzz-dev \
  libfribidi-dev  \
  libfreetype6-dev \
  libpng-dev \
  libtiff5-dev \
  libjpeg-dev \
  libxml2-dev \
  libbz2-dev \
  liblapack-dev \
  gfortran \
  cmake \
  libnlopt-dev 

RUN R -e 'install.packages("optparse")'
RUN R -e 'install.packages("devtools")'
RUN R -e 'install.packages("stringr")'
RUN R -e 'install.packages("dplyr")'
RUN R -e 'install.packages("readr")'
RUN R -e 'install.packages("ade4")'
RUN R -e 'devtools::install_github("im3sanger/dndscv")'
