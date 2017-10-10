"# kafkadocker" 
export KAFKA_OPTS="-Djava.security.auth.login.config=/config/kafka_client_jaas_alice.conf"
export KAFKA_OPTS="-Djava.security.auth.login.config=/config/kafka_client_jaas_alice.conf"
$KAFKA_HOME/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test --producer.config=/config/producer.properties 


export KAFKA_OPTS="-Djava.security.auth.login.config=/config/kafka_client_jaas_alice.conf"
$KAFKA_HOME/bin/kafka-console-consumer.sh  --zookeeper 192.168.99.100:2181 --topic test --from-beginning --consumer.config=/config/consumer.properties  --bootstrap-server=localhost:9092 --broker-list localhost:9092

export KAFKA_OPTS="-Djava.security.auth.login.config=/config/kafka_client_jaas_alice.conf"
$KAFKA_HOME/bin/kafka-console-consumer.sh  --bootstrap-server localhost:9092 --topic test --consumer.config /config/consumer.properties --from-beginning

export KAFKA_OPTS="-Djava.security.auth.login.config=/config/kafka_client_jaas_alice.conf"
$KAFKA_HOME/bin/kafka-console-consumer.sh  --bootstrap-server localhost:9092 --topic test  --from-beginning


export KAFKA_OPTS="-Djava.security.auth.login.config=/config/kafka_server_jaas.conf"

$KAFKA_HOME/bin/kafka-acls.sh --topic test-topic --add -allow-host localhost --allow-principal User:alice --operation Write --authorizer-properties zookeeper.connect=192.168.99.100:2181


$KAFKA_HOME/bin/kafka-acls.sh --authorizer kafka.security.auth.SimpleAclAuthorizer --authorizer-properties zookeeper.connect=192.168.99.100:2181 --add --allow-principal User:alice --operation Write --topic test


$KAFKA_HOME/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test

export KAFKA_OPTS="-Djava.security.auth.login.config=/config/kafka_server_jaas.conf"
$KAFKA_HOME/bin/kafka-acls.sh --authorizer kafka.security.auth.SimpleAclAuthorizer --authorizer-properties zookeeper.connect=192.168.99.100:2181 --add --allow-principal User:alice --operation ALL --topic test
$KAFKA_HOME/bin/kafka-acls.sh --authorizer kafka.security.auth.SimpleAclAuthorizer --authorizer-properties zookeeper.connect=192.168.99.100:2181 --list

export KAFKA_OPTS="-Djava.security.auth.login.config=/config/kafka_server_jaas.conf"

$KAFKA_HOME/bin/kafka-acls.sh --authorizer kafka.security.auth.SimpleAclAuthorizer --authorizer-properties zookeeper.connect=192.168.99.100:2181 --add --allow-principal User:admin --operation ALL --topic test
$KAFKA_HOME/bin/kafka-acls.sh --authorizer kafka.security.auth.SimpleAclAuthorizer --authorizer-properties zookeeper.connect=192.168.99.100:2181 --add --allow-principal User:alice --operation ALL --topic test


$KAFKA_HOME/bin/kafka-acls.sh --authorizer kafka.security.auth.SimpleAclAuthorizer --authorizer-properties zookeeper.connect=192.168.99.100:2181 --add --allow-principal User:admin --operation ALL --topic transaction
$KAFKA_HOME/bin/kafka-acls.sh --authorizer kafka.security.auth.SimpleAclAuthorizer --authorizer-properties zookeeper.connect=192.168.99.100:2181 --add --allow-principal User:alice --operation ALL --topic transaction


$KAFKA_HOME/bin/kafka-acls.sh --authorizer kafka.security.auth.SimpleAclAuthorizer --authorizer-properties zookeeper.connect=192.168.99.100:2181 --add --allow-principal User:admin --operation ALL --topic transaction
$KAFKA_HOME/bin/kafka-topics.sh --describe --zookeeper 192.168.99.100:2181  --topic transaction

$KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper 192.168.99.100:2181 --topic transaction --replication-factor 1 --partitions 1

$KAFKA_HOME//bin/kafka-topics.sh --alter --zookeeper 192.168.99.100:2181 --topic transaction --partitions 2
