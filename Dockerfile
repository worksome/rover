ARG version

FROM debian:stable-slim as installer
ARG version

RUN apt update && apt install -y curl

RUN curl -sSL https://rover.apollo.dev/nix/${version} > installscript.sh
RUN sed -i 's/set -u/set -eoux pipefail/g' installscript.sh
#RUN cat installscript.sh
#COPY installscript.sh .
RUN chmod +x installscript.sh
#RUN pwd && ls -al
#RUN env



RUN ./installscript.sh

FROM debian:stable-slim as runner

COPY --from=installer /root/.rover/bin/rover /root/.rover/bin/rover
ENV PATH="/root/.rover/bin:${PATH}"

ENTRYPOINT [ "/root/.rover/bin/rover" ]
