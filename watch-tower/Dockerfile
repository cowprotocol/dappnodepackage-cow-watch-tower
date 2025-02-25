ARG UPSTREAM_VERSION

FROM ghcr.io/cowprotocol/watch-tower:v2.10.0

RUN apk add --no-cache bash
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 8080

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
