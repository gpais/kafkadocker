FROM anapsix/alpine-java

ARG kafka_version=0.11.0.1
ARG scala_version=2.12

MAINTAINER wurstmeister

RUN apk add --update unzip wget curl docker jq coreutils

ENV KAFKA_VERSION=$kafka_version SCALA_VERSION=$scala_version
ADD download-kafka.sh /tmp/download-kafka.sh
ADD zookeeper.properties /config/zookeeper.properties
ADD zookeeper_jaas.conf /config/zookeeper_jaas.conf



RUN chmod a+x /tmp/download-kafka.sh && sync && /tmp/download-kafka.sh && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka
ENV PATH ${PATH}:${KAFKA_HOME}/bin
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
ADD create-topics.sh /usr/bin/create-topics.sh
ADD kafka-server-start.sh ${KAFKA_HOME}/bin/kafka-server-start.sh
ADD sasl-kafka-console-producer-alice.sh  ${KAFKA_HOME}/bin/sasl-kafka-console-producer-alice.sh
ENV KAFKA_OPTS -Djava.security.auth.login.config=/config/zookeeper_jaas.conf

# The scripts need to have executable permission
RUN chmod a+x /usr/bin/start-kafka.sh && \
    chmod a+x /usr/bin/broker-list.sh && \
    chmod a+x /usr/bin/create-topics.sh &&\
	chmod a+x ${KAFKA_HOME}/bin/kafka-server-start.sh  &&\
	chmod a+x /config/zookeeper_jaas.conf  &&\
	chmod a+x /config/zookeeper.properties

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]

expose 2181:2181