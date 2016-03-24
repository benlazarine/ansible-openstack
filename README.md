# Ansible-OpenStack
Deploy OpenStack on Bare Metal using Ansible

## Host Configuration
All machines are installed and configured using a combination of MaaS and Ansible.  Please note that `LVM` should NOT be used in this configuration, as it will break `cinder`, as it has special rules for exclusions that will break the host operating system.  See the warning [here.](http://docs.openstack.org/liberty/install-guide-ubuntu/cinder-storage-install.html)

## Generating Credentials
### Create credentials Ansible Vault
1. Create Ansible credentials Vault
	1. Generating clear-text
	
		```
		./generate-credentials.sh
		```
	
	1. Generating encrypted
		
		```
		./generate-credentials.sh -y
		```

1. Open Encrypted file:
```
ansible-vault edit openstack-liberty-creds.yml  --vault-password-file .vault_pass.txt
```

If one instead prefers to do this manaully, see the instructions [here.](docs/Generating-Credentials-Manually.md)


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

## OpenStack Services

For a list of services and how to restart them, refer to the document [here.](docs/OpenStack-Services.md)

## Network Troubleshooting

See the network troubleshooting documentation [here.](docs/Network-Troubleshooting.md)

## References

For a list of helpful links and references, see them [here.](docs/Helpful-Sites.md)
