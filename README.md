#Monasca-Schema
Adds schema to mysql and influxdb, creates db users and creates kafka topics.

## Tags
These tags can be used to specify just sections of the role
- kakfa_topics
- mysql_schema
- influxdb_schema

##Requirements
The monasca services for mysql, influxdb and kafka must be up and running.
- zookeeper_hosts - comma separated list of host:port pairs.

Optionally for defining topics, define kafka_topics for example
    kafka_topics:
      metrics: { replicas: 1, partitions: 4 }
      events: { replicas: 1, partitions: 4 }

## Future work
- At this point insecure users/passwords are used for mysql.

##License
Apache

##Author Information
Tim Kuhlman
Monasca Team email monasca@lists.launchpad.net
