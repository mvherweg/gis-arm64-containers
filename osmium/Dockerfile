ARG alpine_version
ARG boost_version
ARG osmium_version

FROM docker.io/arm64v8/alpine:$alpine_version as builder
ARG alpine_version
ARG boost_version
ARG osmium_version
RUN apk add --no-cache \
        boost$boost_version-dev \
        boost$boost_version-program_options \
        cmake \
        curl \
        g++ \
        git \
        expat-dev \
        libbz2 \
        libosmium-dev \
        lz4 \
        make \
        nlohmann-json \
        protozero-dev

WORKDIR /osmium-git
RUN git clone https://github.com/osmcode/osmium-tool \
        --branch v$osmium_version \
        --depth 1 \
        --quiet \
        -c advice.detachedHead=false
WORKDIR /osmium
RUN mv /osmium-git/osmium-tool/* /osmium/

WORKDIR /osmium/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release
RUN make \
        CFLAGS="-D_GNU_SOURCE -D_LARGEFILE64_SOURCE" \
        CXXFLAGS="-D_GNU_SOURCE -D_LARGEFILE64_SOURCE"
RUN make install


FROM docker.io/arm64v8/alpine:$alpine_version
ARG alpine_version
ARG boost_version
ARG osmium_version
WORKDIR /osmium/build
RUN apk add --no-cache \
        boost$boost_version-program_options \
        expat \
        libbz2 \
        lz4 \
        nlohmann-json \
        protozero
COPY --from=builder /osmium/build /osmium/build
ENV PATH="/osmium/build/osmium:${PATH}"

WORKDIR /data
ENTRYPOINT ["/osmium/build/osmium"]
CMD ["--help"]

