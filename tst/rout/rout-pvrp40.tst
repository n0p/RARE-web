description pvrp peer metric

addrouter r1
int eth1 eth 0000.0000.1111 $1a$ $1b$
int eth2 eth 0000.0000.1111 $2a$ $2b$
!
vrf def v1
 rd 1:1
 label-mode per-prefix
 exit
router pvrp4 1
 vrf v1
 router 4.4.4.1
 label
 red conn
 exit
router pvrp6 1
 vrf v1
 router 6.6.6.1
 label
 red conn
 exit
int lo1
 vrf for v1
 ipv4 addr 2.2.2.1 255.255.255.255
 ipv6 addr 4321::1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
 exit
int eth1
 vrf for v1
 ipv4 addr 1.1.1.1 255.255.255.0
 ipv6 addr 1234::1 ffff::
 router pvrp4 1 ena
 router pvrp4 1 metric-in 100
 router pvrp6 1 ena
 router pvrp6 1 metric-in 100
 exit
int eth2
 vrf for v1
 ipv4 addr 1.1.2.1 255.255.255.0
 ipv6 addr 1235::1 ffff::
 mpls enable
 router pvrp4 1 ena
 router pvrp4 1 metric-in 1
 router pvrp6 1 ena
 router pvrp6 1 metric-in 1
 exit
!

addrouter r2
int eth1 eth 0000.0000.2222 $1b$ $1a$
int eth2 eth 0000.0000.2222 $2b$ $2a$
!
vrf def v1
 rd 1:1
 label-mode per-prefix
 exit
router pvrp4 1
 vrf v1
 router 4.4.4.2
 label
 red conn
 exit
router pvrp6 1
 vrf v1
 router 6.6.6.2
 label
 red conn
 exit
int lo1
 vrf for v1
 ipv4 addr 2.2.2.2 255.255.255.255
 ipv6 addr 4321::2 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
 exit
int eth1
 vrf for v1
 ipv4 addr 1.1.1.2 255.255.255.0
 ipv6 addr 1234::2 ffff::
 mpls enable
 router pvrp4 1 ena
 router pvrp4 1 metric-in 2
 router pvrp4 1 accept-met
 router pvrp6 1 ena
 router pvrp6 1 metric-in 2
 router pvrp6 1 accept-met
 exit
int eth2
 vrf for v1
 ipv4 addr 1.1.2.2 255.255.255.0
 ipv6 addr 1235::2 ffff::
 mpls enable
 router pvrp4 1 ena
 router pvrp4 1 metric-in 200
 router pvrp4 1 accept-met
 router pvrp6 1 ena
 router pvrp6 1 metric-in 200
 router pvrp6 1 accept-met
 exit
!



r1 tping 100 20 2.2.2.2 /vrf v1 /int lo1
r2 tping 100 20 2.2.2.1 /vrf v1 /int lo1
r1 tping 100 20 4321::2 /vrf v1 /int lo1
r2 tping 100 20 4321::1 /vrf v1 /int lo1

r2 output show ipv4 pvrp 1 sum
r2 output show ipv6 pvrp 1 sum
r2 output show ipv4 pvrp 1 rou
r2 output show ipv6 pvrp 1 rou
r2 output show ipv4 route v1
r2 output show ipv6 route v1
