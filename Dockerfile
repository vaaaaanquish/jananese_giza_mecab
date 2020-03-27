# The MIT License (MIT)

FROM ubuntu:16.04
MAINTAINER Shunsuke Kawai <6syun9@gmail.com>

# apt update
RUN apt-get update &&\
    rm -rf ~/.cache &&\
    apt-get clean all &&\
    apt-get upgrade -y

# install pyenv + python 3.6
WORKDIR /app/
ENV PYTHON_VERSION 3.6.8
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV HOME /app
ENV PYTHON_ROOT $HOME/local/python-$PYTHON_VERSION
ENV PATH $PYTHON_ROOT/bin:/opt/pyenv/shims:/opt/pyenv/bin:$PATH
ENV PYENV_ROOT $HOME/.pyenv
RUN apt-get install -y \
    git \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    libpq-dev \
    sudo \
    file
RUN git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
RUN $PYENV_ROOT/plugins/python-build/install.sh
RUN /usr/local/bin/python-build -v $PYTHON_VERSION $PYTHON_ROOT
RUN rm -rf $PYENV_ROOT

# install mecab
WORKDIR /app/
RUN apt-get install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8
RUN mkdir -p /usr/lib/x86_64-linux-gnu/mecab
RUN ln -s /var/lib/mecab/dic /usr/lib/x86_64-linux-gnu/mecab/dic
RUN git clone https://github.com/neologd/mecab-ipadic-neologd.git
RUN cd mecab-ipadic-neologd && ( echo yes | ./bin/install-mecab-ipadic-neologd )

# install python modules
WORKDIR /app/
COPY ./requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /app/requirements.txt

# install GIZA++
WORKDIR /app/
RUN apt-get install -q -y --no-install-recommends \
    unzip \
    g++ \
    mercurial \
    bzip2 \
    autotools-dev \
    automake \
    libtool \
    zlib1g-dev \
    libbz2-dev \
    libboost-all-dev \
    libxmlrpc-core-c3-dev \
    libxmlrpc-c++8-dev \
    locales
RUN dpkg-reconfigure locales
RUN wget -O giza-pp.zip http://github.com/moses-smt/giza-pp/archive/master.zip 
RUN unzip giza-pp.zip
RUN rm giza-pp.zip
RUN mv giza-pp-master giza-pp
WORKDIR /app/giza-pp
RUN make
# https://stackoverflow.com/questions/22580467/cygwin-occures-an-error-segmentation-fault-core-dumped-when-running-giza?rq=1
ENV USER Anything

# copy example script
COPY ./train.sh /app/train.sh
COPY ./mecab_tokenize_example.py /app/mecab_tokenize_example.py
COPY ./make_example_data.py /app/make_example_data.py

WORKDIR /app/
ENTRYPOINT [ "/bin/bash" ]
