# Example: loss detection

## **Topology diagram**

![topology](/img/conn-eth16.tst.png)

## **Configuration**

**r1:**
```
hostname r1
buggy
!
logging file debug ../binTmp/zzz36r1-log.run
!
vrf definition tester
 exit
!
vrf definition v1
 rd 1:1
 exit
!
interface ethernet1
 no description
 macaddr 0000.0000.1111
 loss-detection
 vrf forwarding v1
 ipv4 address 1.1.1.1 255.255.255.0
 ipv6 address 1234::1 ffff::
 no shutdown
 no log-link-change
 exit
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
server telnet tester
 security protocol telnet
 no exec authorization
 no login authentication
 vrf tester
 exit
!
!
end
```

**r2:**
```
hostname r2
buggy
!
logging file debug ../binTmp/zzz36r2-log.run
!
vrf definition tester
 exit
!
vrf definition v1
 rd 1:1
 exit
!
interface ethernet1
 no description
 macaddr 0000.0000.2222
 loss-detection
 vrf forwarding v1
 ipv4 address 1.1.1.2 255.255.255.0
 ipv6 address 1234::2 ffff::
 no shutdown
 no log-link-change
 exit
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
server telnet tester
 security protocol telnet
 no exec authorization
 no login authentication
 vrf tester
 exit
!
!
end
```
