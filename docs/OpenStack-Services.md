# OpenStack Services
## Controllers
### Nova
Services:

```
nova-api
nova-cert
nova-consoleauth
nova-scheduler
nova-conductor
nova-novncproxy
```

Restart all:

```
service nova-api restart
service nova-cert restart
service nova-consoleauth restart
service nova-scheduler restart
service nova-conductor restart
service nova-novncproxy restart

OR

service nova-api restart && service nova-cert restart && service nova-consoleauth restart && service nova-scheduler restart && service nova-conductor restart && service nova-novncproxy restart
```

### Keystone
Services:

```
keystone
apache2
```

Restart:

```
service keystone restart
service apache2 restart

OR

service keystone restart && service apache2 restart
```

### Cinder API
Services:

```
cinder-scheduler
cinder-api
```

Restart:

```
service cinder-scheduler restart
service cinder-api restart

OR

service cinder-scheduler restart && service cinder-api restart
```

### Ceilometer
Services:

```
ceilometer-agent-central
ceilometer-agent-notification
ceilometer-api
ceilometer-collector
ceilometer-alarm-evaluator
ceilometer-alarm-notifier
```

Restart:

```
service ceilometer-agent-central restart
service ceilometer-agent-notification restart
service ceilometer-api restart
service ceilometer-collector restart
service ceilometer-alarm-evaluator restart
service ceilometer-alarm-notifier restart

OR

service ceilometer-agent-central restart && service ceilometer-agent-notification restart && service ceilometer-api restart && service ceilometer-collector restart && service ceilometer-alarm-evaluator restart && service ceilometer-alarm-notifier restart
```

### Galera MySQL Cluster
**IMPORTANT!!** Do not restart this service on all nodes at once, or it could destroy the cluster!

Service:

```
mysql
```

Restart:

```
service mysql restart
```

Cluster Restart Procedure:
	
```
# On Master Node
service mysql bootstrap

# Non-master Nodes
service mysql restart
```
	
### RabbitMQ Cluster
**IMPORTANT!!** Do not restart this service on all nodes at once, or it could destroy the cluster!

Service:

```
rabbitmq-server
```

Restart:

```
service rabbitmq-server restart
```

Cluster Restart Procedure:

```
## All nodes:
service rabbitmq-server restart

# Master node:
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl stop

# Non-master nodes
rabbitmqctl stop_app
rabbitmqctl join_cluster rabbit@<master_node_hostname>
rabbitmqctl start_app
```

### Horizon

Service:

```
memcached
apache2
```

Restart:

```
service memcached restart
service apache2 restart

OR

service keystone stop && service memcached restart && service apache2 restart && service keystone start
```

## Neutron Network Node
Services:

```
openvswitch-switch
neutron-plugin-openvswitch-agent
neutron-l3-agent
neutron-dhcp-agent
neutron-metadata-agent
```

Restart:

```
service openvswitch-switch restart
service neutron-plugin-openvswitch-agent restart
service neutron-l3-agent restart
service neutron-dhcp-agent restart
service neutron-metadata-agent restart

OR

service openvswitch-switch restart && service neutron-plugin-openvswitch-agent restart && service neutron-l3-agent restart && service neutron-dhcp-agent restart && service neutron-metadata-agent restart
```

## Compute Nodes
Services:

```
openvswitch-switch
neutron-plugin-openvswitch-agent
neutron-l3-agent
neutron-metadata-agent
```

Restart:

```
service openvswitch-switch restart
service neutron-plugin-openvswitch-agent restart
service neutron-l3-agent restart
service neutron-metadata-agent restart

OR

service openvswitch-switch restart && service neutron-plugin-openvswitch-agent restart && service neutron-l3-agent restart && service neutron-metadata-agent restart
```

## Glance
Services:

```
glance-registry
glance-api
```

Restart:

```
service glance-registry restart
service glance-api restart

OR

service glance-registry restart && service glance-api restart
```

## Cinder Storage
Services:

```
tgt
cinder-volume
```

Restart:

```
service tgt restart
service cinder-volume restart
```

## HAProxy
Service:

```
haproxy
```

Restart:

```
service haproxy restart
```