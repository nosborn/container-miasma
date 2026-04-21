FROM debian:13.5-slim

ARG VERSION

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
        ca-certificates \
        curl \
        libicu76 \
        libssl3 \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /app \
    && chown 1000:1000 /app

USER 1000:1000
WORKDIR /app

RUN curl -fLsS --output miasma --url "https://github.com/austin-weeks/miasma/releases/download/v${VERSION:?}/miasma-linux-x86_64" \
    && chmod +x miasma

EXPOSE 9999

ENTRYPOINT ["/app/miasma", "--host=0.0.0.0"]
