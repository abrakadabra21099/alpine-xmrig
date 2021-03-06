FROM  alpine:3.13
RUN   adduser -S -D -H -h /xmrig miner && \
      echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
      apk --no-cache -U upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base \
        hwloc-dev \
        openssl-dev && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER miner
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig", "--donate-level=1"]
