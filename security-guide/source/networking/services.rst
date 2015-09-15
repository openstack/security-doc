===================
Networking services
===================

In the initial architectural phases of designing your OpenStack Network
infrastructure it is important to ensure appropriate expertise is
available to assist with the design of the physical networking
infrastructure, to identify proper security controls and auditing
mechanisms.

OpenStack Networking adds a layer of virtualized network services which
gives tenants the capability to architect their own virtual networks.
Currently, these virtualized services are not as mature as their
traditional networking counterparts. Consider the current state of these
virtualized services before adopting them as it dictates what controls
you may have to implement at the virtualized and traditional network
boundaries.

L2 isolation using VLANs and tunneling
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack Networking can employ two different mechanisms for traffic
segregation on a per tenant/network combination: VLANs (IEEE 802.1Q
tagging) or L2 tunnels using GRE encapsulation. The scope and scale of
your OpenStack deployment determines which method you should utilize for
traffic segregation or isolation.

VLANs
-----

VLANs are realized as packets on a specific physical network containing
IEEE 802.1Q headers with a specific VLAN ID (VID) field value. VLAN
networks sharing the same physical network are isolated from each other
at L2, and can even have overlapping IP address spaces. Each distinct
physical network supporting VLAN networks is treated as a separate VLAN
trunk, with a distinct space of VID values. Valid VID values are 1
through 4094.

VLAN configuration complexity depends on your OpenStack design
requirements. In order to allow OpenStack Networking to efficiently use
VLANs, you must allocate a VLAN range (one for each tenant) and turn
each compute node physical switch port into a VLAN trunk port.

.. note::

    NOTE: If you intend for your network to support more than 4094
    tenants VLAN is probably not the correct option for you as multiple
    'hacks' are required to extend the VLAN tags to more than 4094
    tenants.

L2 tunneling
------------

Network tunneling encapsulates each tenant/network combination with a
unique "tunnel-id" that is used to identify the network traffic
belonging to that combination. The tenant's L2 network connectivity is
independent of physical locality or underlying network design. By
encapsulating traffic inside IP packets, that traffic can cross Layer-3
boundaries, removing the need for preconfigured VLANs and VLAN trunking.
Tunneling adds a layer of obfuscation to network data traffic, reducing
the visibility of individual tenant traffic from a monitoring point of
view.

OpenStack Networking currently supports both GRE and VXLAN
encapsulation.

The choice of technology to provide L2 isolation is dependent upon the
scope and size of tenant networks that will be created in your
deployment. If your environment has limited VLAN ID availability or will
have a large number of L2 networks, it is our recommendation that you
utilize tunneling.

Network services
~~~~~~~~~~~~~~~~

The choice of tenant network isolation affects how the network security
and control boundary is implemented for tenant services. The following
additional network services are either available or currently under
development to enhance the security posture of the OpenStack network
architecture.

Access control lists
--------------------

OpenStack Compute supports tenant network traffic access controls
directly when deployed with the legacy nova-network service, or may
defer access control to the OpenStack Networking service.

Note, legacy nova-network security groups are applied to all virtual
interface ports on an instance using iptables.

Security groups allow administrators and tenants the ability to specify
the type of traffic, and direction (ingress/egress) that is allowed to
pass through a virtual interface port. Security groups rules are
stateful L2-L4 traffic filters.

When using the Networking service, we recommend that you enable security
groups in this service and disable it in the Compute service.

L3 routing and NAT
------------------

OpenStack Networking routers can connect multiple L2 networks, and can
also provide a *gateway* that connects one or more private L2 networks
to a shared *external* network, such as a public network for access to
the Internet.

The L3 router provides basic Network Address Translation (NAT)
capabilities on *gateway* ports that uplink the router to external
networks. This router SNATs (Static NAT) all traffic by default, and
supports floating IPs, which creates a static one-to-one mapping from a
public IP on the external network to a private IP on one of the other
subnets attached to the router.

It is our recommendation to leverage per tenant L3 routing and Floating
IPs for more granular connectivity of tenant VMs.

Quality of Service (QoS)
------------------------

The ability to set QoS on the virtual interface ports of tenant
instances is a current deficiency for OpenStack Networking. The
application of QoS for traffic shaping and rate-limiting at the physical
network edge device is insufficient due to the dynamic nature of
workloads in an OpenStack deployment and can not be leveraged in the
traditional way. QoS-as-a-Service (QoSaaS) is currently in development
for the OpenStack Networking Icehouse release as an experimental
feature. QoSaaS is planning to provide the following services:

-  Traffic shaping through DSCP markings

-  Rate-limiting on a per port/network/tenant basis.

-  Port mirroring (through open source or third-party plug-ins)

-  Flow analysis (through open source or third-party plug-ins)

Tenant traffic port mirroring or Network Flow monitoring is currently
not an exposed feature in OpenStack Networking. There are third-party
plug-in extensions that do provide port mirroring on a per
port/network/tenant basis. If Open vSwitch is used on the networking
hypervisor, it is possible to enable sFlow and port mirroring, however
it will require some operational effort to implement.

Load balancing
--------------

Another feature in OpenStack Networking is Load-Balancer-as-a-service
(LBaaS). The LBaaS reference implementation is based on HA-Proxy. There
are third-party plug-ins in development for extensions in OpenStack
Networking to provide extensive L4-L7 functionality for virtual
interface ports.

Firewalls
---------

FW-as-a-Service (FWaaS) is considered an experimental feature for the
Kilo release of OpenStack Networking. FWaaS addresses the need to manage
and leverage the rich set of security features provided by typical
firewall products which are typically far more comprehensive than what
is currently provided by security groups. Both Freescale and Intel
developed third-party plug-ins as extensions in OpenStack Networking to
support this component in the Kilo release. Documentation for
administration of FWaaS is located at
http://docs.openstack.org/admin-guide-cloud/networking_introduction.html
#firewall-as-a-service-fwaas-overview

During the design of an OpenStack Networking infrastructure it is
important that you understand the current features and limitations of
available network services. Understanding the boundaries of your virtual
and physical networks will assist in adding required security controls
in your environment.

Network services extensions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

A list of known plug-ins provided by the open source community or by SDN
companies that work with OpenStack Networking is available at `OpenStack
neutron plug-ins and drivers wiki
page <https://wiki.openstack.org/wiki/Neutron_Plugins_and_Drivers>`__.

Networking services limitations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack Networking has the following known limitations:

Overlapping IP addresses
    If nodes that run either neutron-l3-agent or neutron-dhcp-agent use
    overlapping IP addresses, those nodes must use Linux network
    namespaces. By default, the DHCP and L3 agents use Linux network
    namespaces and run in their own respective namespaces. However,
    if the host does not support multiple namespaces, the DHCP and L3
    agents should be run on separate hosts. This is due to the fact that
    there is no isloation between the IP addresses created by the L3
    agent and the DHCP agent.

    If network namespace support is not present, a further limitation of
    the L3 agent is that only a single logical router is supported.

Multi-host DHCP-agent
    OpenStack Networking supports multiple L3 and DHCP agents with load
    balancing. However, tight coupling of the location of the virtual
    machine is not supported. In other words, the default Virtual Machine
    scheduler will not take the location of the agents into account when
    creating virtual machines.

No IPv6 support for L3 agents
    The neutron-l3-agent, used by many plug-ins to implement L3
    forwarding, supports only IPv4 forwarding.
