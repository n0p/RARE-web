description olsr over point2point ethernet

addrouter r1
int eth1 eth 0000.0000.1111 $1a$ $1b$
!
vrf def v1
 rd 1:1
 exit
router olsr4 1
 vrf v1
 exit
router olsr6 1
 vrf v1
 exit
int lo0
 vrf for v1
 ipv4 addr 2.2.2.1 255.255.255.255
 ipv6 addr 4321::1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
 router olsr4 1 ena
 router olsr6 1 ena
 exit
int eth1
 vrf for v1
 ipv4 addr 1.1.1.3 255.255.255.254
 ipv6 addr 1234:1::3 ffff:ffff:ffff:ffff:ffff:ffff:ffff:fffe
 router olsr4 1 ena
 router olsr6 1 ena
 exit
!

addrouter r2
int eth1 eth 0000.0000.2222 $1b$ $1a$
!
vrf def v1
 rd 1:1
 exit
router olsr4 1
 vrf v1
 exit
router olsr6 1
 vrf v1
 exit
int lo0
 vrf for v1
 ipv4 addr 2.2.2.2 255.255.255.255
 ipv6 addr 4321::2 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
 router olsr4 1 ena
 router olsr6 1 ena
 exit
int eth1
 vrf for v1
 ipv4 addr 1.1.1.2 255.255.255.254
 ipv6 addr 1234:1::2 ffff:ffff:ffff:ffff:ffff:ffff:ffff:fffe
 router olsr4 1 ena
 router olsr6 1 ena
 exit
!



r1 tping 100 130 2.2.2.2 /vrf v1
r1 tping 100 130 4321::2 /vrf v1

r2 tping 100 130 2.2.2.1 /vrf v1
r2 tping 100 130 4321::1 /vrf v1

r2 output show ipv4 olsr 1 sum
r2 output show ipv6 olsr 1 sum
r2 output show ipv4 olsr 1 dat
r2 output show ipv6 olsr 1 dat
r2 output show ipv4 route v1
r2 output show ipv6 route v1
