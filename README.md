# rover

_A docker wrapper for rover CLI [https://www.apollographql.com/docs/rover/getting-started](https://www.apollographql.com/docs/rover/getting-started)_.

Our small little project to build a Docker Image for [Apollo Rover](https://github.com/apollographql/rover), as no official images are supplied.

Images pushed to our Docker Hub as [`worksome/rover`](https://hub.docker.com/r/worksome/rover).

## Tags

Our image tags follows [rover release versions](https://github.com/apollographql/rover/releases) without the `v` prefix.

We apply the mutable tag `latest` to most recent image we built based on a _non-prelease_ version of Rover.

## ARM architecture support

AMD/ARM multi-architecture image are built based on Debian stable-slim base images, and Rover binaries installed through official install script which fetches from their Github releases. ARM 64-bit is expected to install `aarch64-unknown-linux-gnu` releases, while ARM 64-bit is expected to install `x86_64-unknown-linux-gnu`.

We can't build smaller Alpine Linux bases images, due to Rover not releasing `musl` binaries for `aarch64`, which would be requires for Alpine Linux that don't have glibc support.

Notice it was first with the version [`v0.9.2-rc.1`](https://github.com/apollographql/rover/releases/tag/v0.9.2-rc.1) of Rover, ARM 64-bit was supported with release binaries[[1]][[2]] and our Docker Image support ARM 64-bit as architecture was wrongly detected in our project as we based images on Alpine.

[1]: https://github.com/apollographql/rover/pull/1137
[2]: https://github.com/apollographql/rover/pull/1356

