ARG version

FROM debian:stable-slim as installer
ARG version
ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDOS
ARG BUILDARCH
ARG BUILDVARIANT

RUN echo $TARGETPLATFORM - platform of the build result. Eg linux/amd64, linux/arm/v7, windows/amd64.
RUN echo $TARGETOS - OS component of TARGETPLATFORM
RUN echo $TARGETARCH - architecture component of TARGETPLATFORM
RUN echo $TARGETVARIANT - variant component of TARGETPLATFORM
RUN echo $BUILDPLATFORM - platform of the node performing the build.
RUN echo $BUILDOS - OS component of BUILDPLATFORM
RUN echo $BUILDARCH - architecture component of BUILDPLATFORM
RUN echo $BUILDVARIANT - variant component of BUILDPLATFORM

RUN curl -sSL https://rover.apollo.dev/nix/${version} > installscript.sh
RUN sed -i 's/set -u/set -eoux pipefail/g' installscript.sh
#RUN cat installscript.sh
#COPY installscript.sh .
RUN chmod +x installscript.sh
#RUN pwd && ls -al
#RUN env

RUN apt update && apt install -y curl

RUN ./installscript.sh

FROM debian:stable-slim as runner

COPY --from=installer /root/.rover/bin/rover /root/.rover/bin/rover
ENV PATH="/root/.rover/bin:${PATH}"

ENTRYPOINT [ "/root/.rover/bin/rover" ]
