description macsec with 3des

addrouter r1
int eth1 eth 0000.0000.1111 $1a$ $1b$
!
vrf def v1
 rd 1:1
 exit
crypto ipsec ips
 group 02
 cipher 3des
 hash md5
 key tester
 exit
int eth1
 vrf for v1
 macsec ips
 ipv4 addr 1.1.1.1 255.255.255.0
 ipv6 addr 1234::1 ffff::
 exit
!

addrouter r2
int eth1 eth 0000.0000.2222 $1b$ $1a$
!
vrf def v1
 rd 1:1
 exit
crypto ipsec ips
 group 02
 cipher 3des
 hash md5
 key tester
 exit
int eth1
 vrf for v1
 macsec ips
 ipv4 addr 1.1.1.2 255.255.255.0
 ipv6 addr 1234::2 ffff::
 exit
!


r1 tping 100 30 1.1.1.2 /vrf v1
r2 tping 100 30 1.1.1.1 /vrf v1
r1 tping 100 30 1234::2 /vrf v1
r2 tping 100 30 1234::1 /vrf v1
