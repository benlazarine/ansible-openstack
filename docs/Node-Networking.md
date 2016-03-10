# Configure Networking on Hosts

## Helpful Manual Commands

1. Get MAC addresses and determine ports
	
	```
	ip link show
	```
	
1. Temporarily set networking to verify connectivity

	```
	ifconfig eth0 192.168.99.14 netmask 255.255.255.0 up
	```

1. Configure network on hosts

	1. Disable network adapters (that were temporarily enabled before)
	
		```
		ifdown eth0 && ifup eth0
		```

## Troubleshooting Networking
* Ping out of specific interfaces:
	
	```
	ping -I ethX xxx.xxx.xxx.xxx
	```

* Detecting if networking has been unplugged via Dmesg
	* <https://wiki.archlinux.org/index.php/Network_configuration#Check_the_status>
	* <http://serverfault.com/questions/366392/how-to-convert-dmesg-time-format-to-real-time-format>

	```
	ut=`cut -d' ' -f1 </proc/uptime`
	ts=`date +%s`
	date -d"70-1-1 + $ts sec - $ut sec + 280951.371486  sec" +"%F %T"
	```
* Detect which VLAN is being tagged for the interface:
	* <https://wiki.archlinux.org/index.php/VLAN>
	
	```
	ip -d link show eth0.100
	```
	
* Flush settings for interface
  
  ```
  ip addr flush eth1
  ```
* ip commands: <https://wiki.archlinux.org/index.php/Network_configuration#Manual_assignment>

	```
	ip link set up ethX
	ip link set down ethX
	ip route show
	ip addr show ethX
	
	```
* Display link status
	
	```
	ethtool ethX
	```
	
* <https://wiki.archlinux.org/index.php/Network_bridge>
* <http://askubuntu.com/questions/549200/adding-virtual-interfaces-in-etc-network-interfaces-is-not-permanent>
* <http://www.tecmint.com/ip-command-examples/>
* <http://www.computerhope.com/unix/uifconfi.htm>
* <http://docs.openstack.org/developer/openstack-ansible/install-guide/overview-hostnetworking.html>
* <https://github.com/openstack/openstack-ansible/blob/master/etc/network/README.rst>
* <http://docs.openstack.org/developer/openstack-ansible/install-guide/targethosts-networkexample.html>

