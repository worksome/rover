ARG version

FROM alpine/curl as installer
ARG version

RUN curl -sSL https://rover.apollo.dev/nix/${version} > installscript.sh
RUN sed -i 's/set -u/set -eoux pipefail/g' installscript.sh
RUN /bin/bash installscript.sh

FROM alpine as runner

COPY --from=installer /root/.rover/bin/rover /root/.rover/bin/rover
ENV PATH="/root/.rover/bin:${PATH}"

ENTRYPOINT [ "/root/.rover/bin/rover" ]
