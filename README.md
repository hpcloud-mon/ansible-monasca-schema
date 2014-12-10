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
- influxdb_users - dictionary of user/password pairs
- influxdb_url - URL of the influxdb server
- mysql_users - dictionary of user/password pairs

Optionally for defining topics, define kafka_topics for example
    kafka_topics:
      metrics: { replicas: 1, partitions: 4 }
      events: { replicas: 1, partitions: 4 }

## TODO
- The notification engine user could be given readonly access to the db but in the current setup there is no way
  to specify that so it gets full access like the rest of the users.

##License
Apache

##Author Information
Tim Kuhlman
Monasca Team email monasca@lists.launchpad.net
