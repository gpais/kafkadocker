#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ $# -lt 1 ];
then
        echo "USAGE: $0 [-daemon] server.properties [--override property=value]*"
        exit 1
fi
base_dir=$(dirname $0)

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:$base_dir/../config/log4j.properties"
fi

if [ "x$KAFKA_HEAP_OPTS" = "x" ]; then
    export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"
fi

EXTRA_ARGS=${EXTRA_ARGS-'-name kafkaServer -loggc'}

COMMAND=$1
case $COMMAND in
  -daemon)
    EXTRA_ARGS="-daemon "$EXTRA_ARGS
    shift
    ;;
  *)
    ;;
esac

echo "authorizer.class.name=kafka.security.auth.SimpleAclAuthorizer" >> $KAFKA_HOME/config/server.properties
echo "allow.everyone.if.no.acl.found=false" >> $KAFKA_HOME/config/server.properties
echo "sasl.enabled.mechanisms=PLAIN" >> $KAFKA_HOME/config/server.properties
echo "sasl.mechanism.inter.broker.protocol=PLAIN" >> $KAFKA_HOME/config/server.properties
echo "sasl.mechanism=PLAIN" >> $KAFKA_HOME/config/server.properties
echo "security.inter.broker.protocol=SASL_SSL" >> $KAFKA_HOME/config/server.properties
echo "super.users=User:admin" >> $KAFKA_HOME/config/server.properties
echo "security.protocol=PLAINTEXT" >> $KAFKA_HOME/config/server.properties
echo "listeners=SASL_PLAINTEXT://:9092" >> $KAFKA_HOME/config/server.properties
echo "security.inter.broker.protocol=SASL_PLAINTEXT" >> $KAFKA_HOME/config/server.properties
echo "advertised.listeners=SASL_PLAINTEXT://192.168.99.100:9092" >> $KAFKA_HOME/config/server.properties


exec $base_dir/kafka-run-class.sh $EXTRA_ARGS -Djava.security.auth.login.config=/config/kafka_server_jaas.conf kafka.Kafka "$@"
