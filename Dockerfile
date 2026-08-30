FROM ubuntu:26.04 AS build
RUN apt-get update \
    && apt-get install --yes --no-install-recommends gnucobol3 \
    && find /var/lib/apt/lists -mindepth 1 -delete
WORKDIR /src
COPY src/stakeholder.cob src/stakeholder.cob
COPY tests/test_cli.sh tests/test_cli.sh
RUN cobc -fsyntax-only -free -Wall -Wextra src/stakeholder.cob \
    && mkdir -p /out \
    && cobc -x -free -Wall -Wextra -o /out/stakeholder src/stakeholder.cob \
    && BIN=/out/stakeholder tests/test_cli.sh
FROM ubuntu:26.04
RUN apt-get update \
    && apt-get install --yes --no-install-recommends libcob4 \
    && find /var/lib/apt/lists -mindepth 1 -delete \
    && groupadd --system stakeholder \
    && useradd --system --gid stakeholder --home-dir /nonexistent --shell /usr/sbin/nologin stakeholder
COPY --from=build /out/stakeholder /usr/local/bin/stakeholder
USER stakeholder
ENTRYPOINT ["/usr/local/bin/stakeholder"]
CMD ["--list-values"]
