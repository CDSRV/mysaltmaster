FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

LABEL maintainer="CDSRV TechSupport <support@coastaldataservices.net>"
LABEL name="salt-develop"

# Add Tini
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ADD . /root/mysaltmaster

RUN (cd /root/mysaltmaster; ./setup)

## persistent data
VOLUME /etc/salt
VOLUME /var/cache/salt
VOLUME /var/logs/salt

## optional
VOLUME /etc/ssl/certs/

## standard ports required
EXPOSE 4505 4506 

## web interface optional
EXPOSE 8080

ENTRYPOINT ["/tini", "-s", "--"]

CMD ["/root/mysaltmaster/bin/start-services" , "--tail"]

