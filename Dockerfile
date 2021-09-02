FROM andyshinn/alpine-abuild:latest AS build_stage
# Use as an alpine image with most build essentials already installed, for speed

ARG ProjectName=starship-technologies/bag_rdr

USER root
RUN apk add lz4-dev lz4-libs cmake meson ninja

WORKDIR /tmp/build

RUN git clone https://github.com/$ProjectName --recurse-submodules

RUN mkdir -p /built/usr/local/ 
RUN meson -Dcommon_cxx_fetch=false --prefix /built/usr/local/  bag_rdr .
RUN ninja install

FROM scratch
COPY --from=build_stage /built/ /


