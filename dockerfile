## enterprise linux
FROM fedora:latest

LABEL maintainer="CDSRV TechSupport <support@coastaldataservices.net>"
LABEL name="salt-develop"

## .. Init Tini Init ..
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ADD . /root/mysaltmaster

RUN (cd /root/mysaltmaster; ./setup)

## runtime data
VOLUME /etc/salt
VOLUME /etc/salt/pki
VOLUME /var/cache/salt
VOLUME /var/logs/salt
VOLUME /etc/ssl/certs

## runtime code
VOLUME /usr/local/src

## temp
#VOLUME /root/.cache    # python
#VOLUME /var/cache/dnf  # fedora
#VOLUME /tmp

## standard ports required
EXPOSE 4505 4506 

## web interface optional
EXPOSE 8080

ENTRYPOINT ["/tini", "-sv", "--"]

CMD ["/root/mysaltmaster/bin/start-services" , "--tail"]

