ARG version

# We would rather use Alpine, but we want ARM64 and misses
# aarch64 musl binaries from the Rover project.
FROM debian:stable-slim as installer
ARG version

# install script needs curl or wget
RUN apt update && apt install -y curl

RUN curl -sSL https://rover.apollo.dev/nix/${version} | sh

FROM debian:stable-slim as runner

COPY --from=installer /root/.rover/bin/rover /root/.rover/bin/rover
ENV PATH="/root/.rover/bin:${PATH}"

ENTRYPOINT [ "/root/.rover/bin/rover" ]
