description ospf address suppression

addrouter r1
int eth1 eth 0000.0000.1111 $1a$ $1b$
!
vrf def v1
 rd 1:1
 exit
router ospf4 1
 vrf v1
 router 4.4.4.1
 area 0 ena
 exit
router ospf6 1
 vrf v1
 router 6.6.6.1
 area 0 ena
 exit
int lo1
 vrf for v1
 ipv4 addr 2.2.2.1 255.255.255.255
 ipv6 addr 4321::1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
 router ospf4 1 ena
 router ospf4 1 passiv
 router ospf6 1 ena
 router ospf6 1 passiv
 exit
int lo2
 vrf for v1
 ipv4 addr 2.2.2.2 255.255.255.255
 ipv6 addr 4321::2 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
 router ospf4 1 ena
 router ospf4 1 passiv
 router ospf4 1 suppress
 router ospf6 1 ena
 router ospf6 1 passiv
 router ospf6 1 suppress
 exit
int lo3
 vrf for v1
 ipv4 addr 2.2.2.3 255.255.255.255
 ipv6 addr 4321::3 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
 router ospf4 1 ena
 router ospf4 1 passiv
 router ospf6 1 ena
 router ospf6 1 passiv
 exit
int eth1
 vrf for v1
 ipv4 addr 1.1.1.1 255.255.255.252
 ipv6 addr 1234:1::1 ffff:ffff::
 router ospf4 1 ena
 router ospf6 1 ena
 exit
!

addrouter r2
int eth1 eth 0000.0000.2222 $1b$ $1a$
!
vrf def v1
 rd 1:1
 exit
router ospf4 1
 vrf v1
 router 4.4.4.2
 area 0 ena
 exit
router ospf6 1
 vrf v1
 router 6.6.6.2
 area 0 ena
 exit
int eth1
 vrf for v1
 ipv4 addr 1.1.1.2 255.255.255.252
 ipv6 addr 1234:1::2 ffff:ffff::
 router ospf4 1 ena
 router ospf6 1 ena
 exit
!




r2 tping 100 40 2.2.2.1 /vrf v1
r2 tping 0 40 2.2.2.2 /vrf v1
r2 tping 100 40 2.2.2.3 /vrf v1
r2 tping 100 40 4321::1 /vrf v1
r2 tping 0 40 4321::2 /vrf v1
r2 tping 100 40 4321::3 /vrf v1

r2 output show ipv4 ospf 1 nei
r2 output show ipv6 ospf 1 nei
r2 output show ipv4 ospf 1 dat 0
r2 output show ipv6 ospf 1 dat 0
r2 output show ipv4 ospf 1 tre 0
r2 output show ipv6 ospf 1 tre 0
r2 output show ipv4 route v1
r2 output show ipv6 route v1
