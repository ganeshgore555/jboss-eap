FROM ubi8/ubi

USER root

ENV JBOSS_HOME=/opt/jboss/jboss-eap-7.2 

RUN yum install -y java-1.8.0-openjdk-devel unzip && yum clean all

RUN groupadd -r -g 1100 jboss && useradd -u 1100 -r -m -g jboss -d /opt/jboss -s /sbin/nologin jboss

ADD jboss-eap-7.2.0.zip /opt/jboss

WORKDIR /opt/jboss

RUN unzip -q jboss-eap-7.2.0.zip

#RUN ls -ltr ${JBOSS_HOME}/bin

RUN chown -R jboss:root $JBOSS_HOME && chmod -R ug+rwX $JBOSS_HOME

RUN ${JBOSS_HOME}/bin/add-user.sh admin admin123! --silent

USER jboss

EXPOSE 8080

ENTRYPOINT ["/opt/jboss/jboss-eap-7.2/bin/standalone.sh", "-b", "0.0.0.0", "-c", "standalone-full-ha.xml"]

