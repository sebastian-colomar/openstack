```
sudo snap install microstack --beta --devmode

sudo microstack init --auto --control
sudo microstack add-compute

sudo microstack init --auto --compute --join <connection-string>

microstack.openstack hypervisor list
sudo snap get microstack config.credentials.keystone-password
microstack.openstack service list
sudo microstack launch cirros --name test

sudo systemctl restart snap.microstack.*

for i in $( ip a | grep ^[0-9] | cut -d: -f2 ) ; do sudo tcpdump -i $i -w tcp.$i & done

sudo sysctl net.ipv4.ip_forward=1
ssh cirros@10.20.20.28 'ping -c1 8.8.8.8'

for pid in $( ps -afww | grep ^root.*tcpdump | awk '{ print $2 }' ) ; do sudo kill -9 $pid ; done
for file in tcp.* ; do sudo chown ssm-user. $file ; done
for file in tcp.* ; do echo ; echo $file ; tcpdump -XXn -r $file | grep -A1 '> 8\.8\.8\.8' ; done
for file in tcp.* ; do echo ; echo $file ; tcpdump -XXn -r $file | grep -A1 '8\.8\.8\.8 >' ; done
```
