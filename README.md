# Ansible-OpenStack
Deploy OpenStack on Bare Metal using Ansible

## Host Configuration
All machines are installed and configured using a combination of MaaS and Ansible.  Please note that `LVM` should NOT be used in this configuration, as it will break `cinder`, as it has special rules for exclusions that will break the host operating system.  See the warning [here.](http://docs.openstack.org/liberty/install-guide-ubuntu/cinder-storage-install.html)

## Generating Credentials
### Create credentials Ansible Vault (Automatically)
1. Create Ansible credentials Vault (clear-text)
```
./generate-credentials.sh
```

OR


1. Create Ansible credentials Vault (encrypted)
```
./generate-credentials.sh -y
```
1. Open Encrypted file:
```
ansible-vault edit openstack-liberty-creds.yml  --vault-password-file .vault_pass.txt
```

### Create credentials file using Ansible Vault (Manually)

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

## Ansible Install

### Ansible Commands to run
1. Ping maas hosts:
	
	`ansible maas -m ping`
	
1. Run cloud-init cleanup:

	`ansible-playbook playbooks/maas-cloud-harden.yml`

1. Manually update hosts:

	`ansible maas -m raw -a "apt-get update"`

1. Ping all hosts:

	`ansible openstack -m ping`

1. Harden and remove cloud packages from MAAS nodes:

	`ansible-playbook playbooks/cloud-init-harden.yml -u ubuntu`

1. Perform minimal linux hardening:
	1. Update `group_vars/maas` to reflect your site's settings
	1. Prepare the hosts

		`ansible-playbook playbooks/liberty-host-prep.yml --vault-password-file .vault_pass.txt -e @openstack-liberty-creds.yml`

1. Install OpenStack Liberty (Do one tag at a time):

	`ansible-playbook playbooks/liberty-install.yml --vault-password-file .vault_pass.txt -e @openstack-liberty-creds.yml` --tags "<service-to-deploy>"
