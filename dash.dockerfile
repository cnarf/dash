ARG TAG=latest

FROM cnarf/stretch:${TAG}

LABEL maintainer="cnarf@charline"
LABEL description="A static (da)sh"

ARG VERSION=v0.5.10.2

RUN apt-get install --no-install-recommends -y \
    git \
    autotools-dev make autoconf automake \
    gcc libc-dev \
&& apt-get clean \
&& /root/finalize.sh;

WORKDIR /usr/src
# @see http://gondor.apana.org.au/~herbert/dash/
RUN git clone git://git.kernel.org/pub/scm/utils/dash/dash.git

WORKDIR /usr/src/dash
RUN git checkout tags/${VERSION} \
&& ./autogen.sh \
&& ./configure --enable-static \
&& make \
&& strip src/dash
#  \
# && cp src/dash /bin/sh

# WORKDIR /usr/src
# RUN rm -rf dash

CMD ["/usr/src/dash/src/dash"]
