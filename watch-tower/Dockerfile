ARG UPSTREAM_VERSION

FROM ghcr.io/cowprotocol/watch-tower:pr-112

RUN apk add --no-cache bash
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 8080

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
