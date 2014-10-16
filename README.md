#Monasca-Schema
Adds schema to mysql and influxdb, creates db users and creates kafka topics.

##Requirements
The monasca services for mysql, influxdb and kafka must be up and running.
- zookeeper_hosts - comma separated list of host:port pairs.

Optionally for defining topics, define kafka_topics for example
    kafka_topics:
      metrics: { replicas: 1, partitions: 4 }
      events: { replicas: 1, partitions: 4 }

##License
Apache

##Author Information
Tim Kuhlman
Monasca Team email monasca@lists.launchpad.net
