FROM debian:bullseye-slim as build

MAINTAINER Kohei YOSHIKAWA <admin@marihome.org>

RUN set -ex; \
    \
    DEBIAN_FRONTEND=noninteractive apt -yq --allow-releaseinfo-change update && \
    DEBIAN_FRONTEND=noninteractive apt -yq install \
        supervisor \
        ca-certificates \
        openssl \
        postfix \
        postfix-pcre \
        sasl2-bin \
        opendkim \
        opendkim-tools \
        rsyslog \
        htop \
        pfqueue \
        procps \
    && \
    apt -yq autoremove && \
    apt -yq clean && \
    rm -rf /var/log/{apt/*,dpkg.log,alternatives.log} && \
    rm -rf /var/log/apt/* && \
    rm -rf /var/apt/lists/* && \
    rm -rf /usr/share/man/?? /usr/share/man/??_*

#EXPOSE 25 587 465

FROM build

ADD src /app

ENTRYPOINT ["/app/entrypoint.sh"]
