description fragmentation and reassembly

addrouter r1
int ser1 ser - $1a$ $1b$
!
vrf def v1
 rd 1:1
 exit
int ser1
 mtu 1500
 enforce-mtu both
 vrf for v1
 ipv4 addr 1.1.1.1 255.255.255.0
 ipv6 addr 1234::1 ffff::
 ipv4 reassembly 16
 ipv4 fragmentation 1400
 ipv6 reassembly 16
 ipv6 fragmentation 1400
 exit
!

addrouter r2
int ser1 ser - $1b$ $1a$
!
vrf def v1
 rd 1:1
 exit
int ser1
 mtu 1500
 enforce-mtu both
 vrf for v1
 ipv4 addr 1.1.1.2 255.255.255.0
 ipv6 addr 1234::2 ffff::
 ipv4 reassembly 16
 ipv4 fragmentation 1400
 ipv6 reassembly 16
 ipv6 fragmentation 1400
 exit
!

r1 tping 100 15 1.1.1.2 /vrf v1 /siz 222
r2 tping 100 15 1.1.1.1 /vrf v1 /siz 222
r1 tping 100 15 1234::2 /vrf v1 /siz 222
r2 tping 100 15 1234::1 /vrf v1 /siz 222

r1 tping 100 15 1.1.1.2 /vrf v1 /siz 2222
r2 tping 100 15 1.1.1.1 /vrf v1 /siz 2222
r1 tping 100 15 1234::2 /vrf v1 /siz 2222
r2 tping 100 15 1234::1 /vrf v1 /siz 2222
