ARG version

FROM alpine/curl as installer
ARG version

RUN curl -sSL https://rover.apollo.dev/nix/${version} | sh

FROM alpine as runner

COPY --from=installer /root/.rover/bin/rover /root/.rover/bin/rover
ENV PATH="/root/.rover/bin:${PATH}"

ENTRYPOINT [ "/root/.rover/bin/rover" ]