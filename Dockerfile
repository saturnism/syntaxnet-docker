# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:wily

RUN mkdir /syntaxnet
WORKDIR /syntaxnet

RUN apt-get -q update && \
  apt-get install --no-install-recommends -y --force-yes -q \
    build-essential \
    ca-certificates \
    wget \
    git \
    swig \
    openjdk-8-jdk \
    pkg-config zip g++ zlib1g-dev unzip \
    python python-pip \
    python-dev libpython-dev \
    python-numpy \
  && apt-get clean && \
  rm /var/lib/apt/lists/*_*
RUN update-ca-certificates -f

RUN pip install -U protobuf==3.0.0b2 asciitree && rm -rf /tmp/*
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.2.2/bazel-0.2.2-installer-linux-x86_64.sh -O bazel-install.sh && chmod a+x bazel-install.sh && ./bazel-install.sh && rm bazel-install.sh

RUN git clone --recursive https://github.com/tensorflow/models.git

RUN cd models/syntaxnet/tensorflow && ./configure && cd .. && bazel --batch test --genrule_strategy=standalone --spawn_strategy=standalone syntaxnet/... util/utf8/...

WORKDIR /syntaxnet/models/syntaxnet

ENTRYPOINT ["syntaxnet/demo.sh"]
