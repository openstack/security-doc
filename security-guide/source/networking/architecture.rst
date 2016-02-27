=======================
Networking architecture
=======================

OpenStack Networking is a standalone service that often deploys several
processes across a number of nodes. These processes interact with each other
and other OpenStack services. The main process of the OpenStack Networking
service is *neutron-server*, a Python daemon that exposes the OpenStack
Networking API and passes tenant requests to a suite of plug-ins for
additional processing.

The OpenStack Networking components are:

neutron server (*neutron-server* and *neutron-\*-plugin*)
   This service runs on the network node to service the Networking API and its
   extensions. It also enforces the network model and IP addressing of each
   port. The neutron-server and plugin agents require access to a database for
   persistent storage and access to a message queue for inter-communication.

plugin agent (*neutron-\*-agent*)
   Runs on each compute node to manage local virtual switch (vswitch)
   configuration. The plug-in that you use determine which agents run. This
   service requires message queue access and depends on the plugin used. *Some
   plugins like OpenDaylight(ODL) and Open Virtual Network (OVN) do not
   require any python agents on compute nodes.*

DHCP agent (*neutron-dhcp-agent*)
   Provides DHCP services to tenant networks. This agent is the same across all
   plug-ins and is responsible for maintaining DHCP configuration. The
   *neutron-dhcp-agent* requires message queue access. *Optional depending on
   plug-in.*

L3 agent (*neutron-l3-agent*)
   Provides L3/NAT forwarding for external network access of VMs on tenant
   networks. Requires message queue access. *Optional depending on plug-in.*

network provider services (SDN server/services)
   Provides additional networking services to tenant networks. These SDN
   services may interact with *neutron-server*, *neutron-plugin*, and
   plugin-agents through communication channels such as REST APIs.

The following figure shows an architectural and networking flow diagram of the
OpenStack Networking components:

.. image:: ../figures/sdn-connections.png
   :width: 100%

OpenStack Networking service placement on physical servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This guide focuses on a standard architecture that includes a *cloud
controller* host, a *network* host, and a set of *compute* hypervisors for
running VMs.

Network connectivity of physical servers
----------------------------------------

.. image:: ../figures/1aa-network-domains-diagram.png
   :width: 100%

A standard OpenStack Networking setup has up to four distinct physical data
center networks:

Management network
   Used for internal communication between OpenStack Components. The IP
   addresses on this network should be reachable only within the data center
   and is considered the Management Security Domain.

Guest network
   Used for VM data communication within the cloud deployment. The IP
   addressing requirements of this network depend on the OpenStack Networking
   plug-in in use and the network configuration choices of the virtual
   networks made by the tenant. This network is considered the Guest Security
   Domain.

External network
   Used to provide VMs with Internet access in some deployment scenarios. The
   IP addresses on this network should be reachable by anyone on the Internet.
   This network is considered to be in the Public Security Domain.

API network
   Exposes all OpenStack APIs, including the OpenStack Networking API, to
   tenants. The IP addresses on this network should be reachable by anyone on
   the Internet. This may be the same network as the external network, as it
   is possible to create a subnet for the external network that uses IP
   allocation ranges to use only less than the full range of IP addresses in an
   IP block. This network is considered the Public Security Domain.

For additional information see the `OpenStack Cloud Administrator Guide
<http://docs.openstack.org/admin-guide-cloud/networking.html>`__.
