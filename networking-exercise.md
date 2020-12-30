```
for i in $( ip a | grep ^[0-9] | cut -d: -f2 ) ; do sudo tcpdump -i $i -w tcp.$i & done

sudo sysctl net.ipv4.ip_forward=1
ssh cirros@10.20.20.XXX 'ping -c1 8.8.8.8'

for pid in $( ps -afww | grep ^root.*tcpdump | awk '{ print $2 }' ) ; do sudo kill -9 $pid ; done
for file in tcp.* ; do sudo chown ssm-user. $file ; done
for file in tcp.* ; do echo ; echo $file ; tcpdump -XXn -r $file | grep -A1 '> 8\.8\.8\.8' ; done
for file in tcp.* ; do echo ; echo $file ; tcpdump -XXn -r $file | grep -A1 '8\.8\.8\.8 >' ; done
```
