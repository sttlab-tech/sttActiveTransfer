FROM registry.access.redhat.com/ubi9/ubi:latest AS builder

ARG INSTALLER_USERNAME
ARG INSTALLER_PASSWORD
ARG INSTALLER_PRODUCTS
ARG INSTALLER_FIXES

RUN yum -y update ;\
    yum -y install \
        procps \
        ;\
    yum clean all ;\
    rm -rf /var/cache/yum ;\
    useradd -u 1724 -m -g 0 -d /opt/webmethods wm

RUN chmod 770 /opt/webmethods && mkdir /opt/source && chown wm:root /opt/source
ADD --chown=wm:root startContainer.sh /opt/source/startContainer.sh
ADD --chown=wm:root installer.bin /opt/source/installer.bin
ADD --chown=wm:root at.script /opt/source/at.script
RUN chmod u+x /opt/source/*.bin 

RUN echo "InstallProducts=${INSTALLER_PRODUCTS}" >> /opt/source/at.script
RUN echo "selectedFixes=${INSTALLER_FIXES}" >> /opt/source/at.script
RUN echo "Username=${INSTALLER_USERNAME}" >> /opt/source/at.script
RUN echo "Password=${INSTALLER_PASSWORD}" >> /opt/source/at.script

USER wm

RUN /opt/source/installer.bin -readScript /opt/source/at.script

USER root 

RUN cp /opt/source/startContainer.sh /opt/webmethods/IntegrationServer/bin/startContainer.sh && chmod +x /opt/webmethods/IntegrationServer/bin/startContainer.sh
ENV INSTANCE_NAME=default

RUN rm -rf /opt/webmethods/install 
RUN rm -rf /opt/webmethods/jvm/jvm*.bck
RUN rm -rf /opt/webmethods/IntegrationServer/instances/default/config/backup/*
RUN rm -rf /opt/webmethods/IntegrationServer/instances/default/packages/WmMFT/resources/backup/*
RUN rm -rf /opt/webmethods/SAGUpdateManager
RUN rm -rf /opt/webmethods/IntegrationServer/instances/default/config/backup/*
RUN rm -rf /opt/webmethods/IntegrationServer/instances/default/config/jdbc/pool/mft.xml
RUN rm -rf /opt/webmethods/IntegrationServer/instances/default/config/jdbc/pool/cds.xml
RUN rm -rf /opt/webmethods/IntegrationServer/instances/default/config/jdbc/properties/*

RUN find /opt/webmethods -type f -name '.lock' -exec rm {} \;

RUN chgrp -R root /opt/webmethods && chmod -R g=u /opt/webmethods


FROM registry.access.redhat.com/ubi9/ubi:latest

ENV JAVA_HOME=/opt/webmethods/jvm/jvm/ \
    JRE_HOME=/opt/webmethods/jvm/jvm/ \
    JDK_HOME=/opt/webmethods/jvm/jvm/ \
    INSTANCE_NAME=default

RUN yum -y update ;\
    yum -y install \
        procps \
        shadow-utils \
        findutils \
        nmap-ncat \
        ;\
    yum clean all ;\
    rm -rf /var/cache/yum ;\
    useradd -u 1724 -m -g 0 -d /opt/webmethods wm

RUN chmod 770 /opt/webmethods
COPY --from=builder /opt/webmethods /opt/webmethods

USER wm

EXPOSE 5555
EXPOSE 9999
EXPOSE 5553

ENTRYPOINT "/bin/bash" "-c" "/opt/webmethods/IntegrationServer/bin/startContainer.sh"