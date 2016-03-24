# Generating Credentials (Manually)
## Create credentials Ansible Vault

```bash
cat > openstack-creds.txt << EOF
ADMIN_PASS Password of user admin
CEILOMETER_DBPASS Database password for the Telemetry service
CEILOMETER_PASS Password of Telemetry service user ceilometer
CINDER_DBPASS Database password for the Block Storage service
CINDER_PASS Password of Block Storage service user cinder
DASH_DBPASS Database password for the dashboard
DEMO_PASS Password of user demo
GLANCE_DBPASS Database password for Image service
GLANCE_PASS Password of Image service user glance
HEAT_DBPASS Database password for the Orchestration service
HEAT_DOMAIN_PASS Password of Orchestration domain
HEAT_PASS Password of Orchestration service user heat
KEYSTONE_DBPASS Database password of Identity service
NEUTRON_DBPASS Database password for the Networking service
NEUTRON_PASS Password of Networking service user neutron
NOVA_DBPASS Database password for Compute service
NOVA_PASS Password of Compute service user nova
RABBIT_PASS Password of user guest of RabbitMQ
SAHARA_DBPASS Database password of Data processing service
SWIFT_PASS Password of Object Storage service user swift
TROVE_DBPASS Database password of Database service
TROVE_PASS Password of Database service user trove
MYSQL_PASS_ROOT MySQL root password
MYSQL_PASS_SST MySQL SST password for HAProxy
MYSQL_PASS_GALERA_HEALTH Galera Health for HAProxy
ADMIN_TOKEN Admin token for Openstack account
EOF
```

1. Create Ansible credentials Vault
```
gawk '{ print $1 }' openstack-creds.txt | while read -r line; do i=`openssl rand -hex 10`; echo $line: $i; done > openstack-liberty-creds.yml
```
1. Create vault pass:
```
pwgen 12 > .vault_pass.txt
```
1. Encrypt Ansible Vault:
```
ansible-vault encrypt openstack-liberty-creds.yml  --vault-password-file .vault_pass.txt
```
1. Open Encrypted file:
```
ansible-vault edit openstack-liberty-creds.yml  --vault-password-file .vault_pass.txt
```
