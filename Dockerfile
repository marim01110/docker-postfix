FROM debian:buster-slim as build

LABEL maintainer="source@kingsquare.nl"

RUN set -ex; \
    \
    #https://github.com/hackafake/hackafake-backend/issues/32#issuecomment-735602580
    #https://exerror.com/repository-http-deb-debian-org-debian-buster-updates-inrelease-changed-its-suite-value-from-stable-updates-to-oldstable-updates/
    DEBIAN_FRONTEND=noninteractive apt-get -yq --allow-releaseinfo-change update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
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
    apt-get -yq autoremove && \
    apt-get -yq clean && \
    rm -rf /var/log/{apt/*,dpkg.log,alternatives.log} && \
    rm -rf /var/log/apt/* && \
    rm -rf /var/apt/lists/* && \
    rm -rf /usr/share/man/?? /usr/share/man/??_*

#EXPOSE 25 587 465

FROM build

ADD src /app

ENTRYPOINT ["/app/entrypoint.sh"]
