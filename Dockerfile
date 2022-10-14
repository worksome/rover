ARG version

FROM alpine/curl as installer
ARG version

RUN echo $TARGETPLATFORM - platform of the build result. Eg linux/amd64, linux/arm/v7, windows/amd64.
RUN echo $TARGETOS - OS component of TARGETPLATFORM
RUN echo $TARGETARCH - architecture component of TARGETPLATFORM
RUN echo $TARGETVARIANT - variant component of TARGETPLATFORM
RUN echo $BUILDPLATFORM - platform of the node performing the build.
RUN echo $BUILDOS - OS component of BUILDPLATFORM
RUN echo $BUILDARCH - architecture component of BUILDPLATFORM
RUN echo $BUILDVARIANT - variant component of BUILDPLATFORM

#RUN curl -sSL https://rover.apollo.dev/nix/${version} > installscript.sh
#RUN sed -i 's/set -u/set -eoux pipefail/g' installscript.sh
#RUN cat installscript.sh
COPY installscript.sh .
RUN ./installscript.sh

FROM alpine as runner

COPY --from=installer /root/.rover/bin/rover /root/.rover/bin/rover
ENV PATH="/root/.rover/bin:${PATH}"

ENTRYPOINT [ "/root/.rover/bin/rover" ]
