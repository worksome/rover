ARG version

# We would rather use Alpine, but we want ARM64 and misses
# aarch64 musl binaries from the Rover project.
FROM debian:stable-slim AS installer
ARG version

# install script needs curl or wget
RUN apt update && apt install -y curl

RUN curl -sSL https://rover.apollo.dev/nix/${version} | sh

FROM debian:stable-slim AS runner

COPY --from=installer /root/.rover/bin/rover /root/.rover/bin/rover
ENV PATH="/root/.rover/bin:${PATH}"

# We also need ca-certificates to trust certs
RUN apt update && apt install -y ca-certificates && rm -rf /var/lib/apt/lists/* && apt-get clean

ENTRYPOINT [ "/root/.rover/bin/rover" ]
