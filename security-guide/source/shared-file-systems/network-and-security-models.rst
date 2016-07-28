.. _shared_fs_network&security_models:

===========================
Network and security models
===========================
A share driver in the Shared File Systems service is a Python class that can
be set for the back end and run in it to manage share operations, some of
which are vendor-specific. The back end is an instance of manila-share
service. There are a big number of share drivers created by different vendors
in the Shared File Systems service. Each share driver supports one or more back
end modes: *share servers* and *no share servers*. An administrator
chooses which mode is used by specifying it in ``manila.conf`` configuration
file. An option ``driver_handles_share_servers`` is used for it.

The *share servers* mode can be configured with flat network, or with segmented
network. This depends on the network provider.

It is possible to have separate drivers for different modes use the same
hardware, if you want to have different configurations. Depending on which mode
is chosen, an administrator may need to provide more configuration details
through the configuration file.

.. _share-servers-vs-no-share-servers:

Share back ends modes
---------------------

Each share driver supports at least one of the possible driver modes:

* **share servers mode**
* **no share servers mode**

The configuration option in ``manila.conf`` that sets *share servers* mode or
*no share servers* mode is the ``driver_handles_share_servers``
option. It indicates whether a driver handles share servers by itself
or it expects the Shared File Systems service to do it.

.. list-table::
   :header-rows: 1
   :widths: 20 40 60

   * - Mode
     - Config option
     - Description

   * - share servers
     - driver_handles_share_servers = True
     - The share driver creates the share server and manages, or handles, the
       share server life cycle.

   * - no share servers
     - driver_handles_share_servers = False
     - An administrator rather than a share driver manages the bare metal
       storage with some net interface insteadof the presence of the share
       servers.

No share servers mode
   In this mode, drivers have basically no network requirements whatsoever.
   It's assumed that storage controller being managed by the
   driver has all of the network interfaces it's going to need. The Shared
   File Systems service will expect the driver to provision shares directly
   without creating any share server beforehand. This mode corresponds to
   what some existing drivers are already doing, but it makes the
   choice explicit for the administrator. In this mode, the share networks
   are not needed at share creation time and must not be provided.

.. note::

   In *no share servers mode* the Shared File Systems service will assume that
   the network interfaces through which any shares are exported are already
   reachable by all tenants.

In the *no share servers* mode a share driver does not handle storage
life cycle. An administrator is expected to handle the storage, network
interfaces, and other host configurations. In this mode an administrator can
set storage as a host which exports shares. The main characteristic
of this mode is that the storage is not handled by the Shared File Systems
service. Users in a tenant share common network, host, processor, and
network pipe. They can hinder each other if there is no correct balancing
adjustment on the storage configured by admin or proxy before it. In
public clouds it is possible that all network capacity is used by one client,
so an administrator should care for this not to happen. Balancing
adjustment can be done by any means, not necessarily with OpenStack tools.

Share servers mode
   In this mode, a driver is able to create share servers and plug them to
   existing networks. When providing a new share server, drivers expect
   an IP address and subnet from the Shared File Systems service.

Unlike *no share servers* mode, in *share servers* mode users have
a share network and a share server that is created for each share network.
Thus all users have separate CPU, amount of CPU time, network, capacity and
throughput.

You also can configure
:ref:`security services <shared_fs_security_services>` in both *share servers*
and *no share servers* back-end modes. But with *no share servers* back-end
mode, an administrator should set desired authentication services manually
on the host. And in *share servers* mode the Shared File
Systems service can be configured automatically with any existing security
services supported by the share driver.

Flat vs segmented networking
----------------------------
The Shared File Systems service allows to work with different types of a
network:

* ``flat``
* ``GRE``
* ``VLAN``
* ``VXLAN``

.. note::

    The Shared File Systems service is merely keeping the information about
    networks in the database, and real networks are provided by the
    network provider. In OpenStack it can be Legacy networking (nova-network)
    or Networking (neutron) services, but the Shared File Systems
    service can work even out of OpenStack. That is allowed by
    ``StandaloneNetworkPlugin`` that can be used with any network platform and
    does not require some specific network services in OpenStack like
    Networking or Legacy networking services. You can set the network
    parameters in its configuration file.

In :ref:`share servers <share-servers-vs-no-share-servers>` back-end mode
a share driver creates and manages a share server for each share network.
This mode can be divided in two variations:

* Flat network in *share servers* back-end mode
* Segmented network in *share servers* back-end mode

Initially, when creating a share network, you can set up either a network
and subnet of the OpenStack Networking (neutron) or a network of Legacy
networking (nova-network) services. The third approach is to configure the
networking without Legacy networking and Networking services.
``StandaloneNetworkPlugin`` can be used with any network platform. You can set
network parameters in its configuration file.

.. tip::

   All share drivers that use the OpenStack Compute service do not use
   network plug-ins. In Mitaka release it is Windows and Generic drivers.
   These share drives have other options and use different approach.

After a share network is created, the Shared File Systems service retrieves
network information determined by a network provider: network type,
segmentation identifier if the network uses segmentation and
IP block in CIDR notation from which to allocate the network.

**Flat network in share servers back-end mode**

In this mode, some storage controllers can create share servers but due to
various limitations of physical or logical network all of share servers
have to be on a flat network. In this mode, a share driver needs something to
provision IP addresses for share servers, but IPs will all come out of the
same subnet and that subnet itself is assumed to be reachable by all tenants.

The :ref:`security service part <shared_fs_security_services>` of
share networks specify security
requirements such as AD or LDAP domains or a Kerberos realm. The Shared File
Systems service assumes that any hosts referred to in security service are
reachable from a subnet where a share server is created, which limits the
number of cases where this mode could be used.

**Segmented network in share servers back-end mode**

In this mode, a share driver is able to create share servers and plug them to
an existing segmented network. Share drivers expect the Shared File Systems
service to provide a subnet definition for every new share server. This
definition should include segmentation type, segmentation ID, and any other
info relevant to the segmentation type.

.. note::

    Some share drivers may not support all types of segmentation, for details
    see specification for the driver in use.

.. _shared_fs_network_plugins:

Network plug-ins
----------------

The Shared File Systems service architecture defines an abstraction layer for
network resource provisioning. It allows administrators to choose from
different options for how network resources are assigned to their tenants’
networked storage. There are several network plug-ins that provide a variety
of integration approaches with the network services that are available with
OpenStack.

Network plug-ins allow to use any functions, configurations of the
OpenStack Networking and Legacy networking services. One can use
any network segmentation that the Networking service supports, you can use
flat networks or VLAN-segmented networks of the Legacy networking
(nova-network) service, or you can use plug-ins for specifying networks
independently from OpenStack networking services. For more information of how
to use different network plug-ins, see `Shared File Systems service Network
plug-ins
<http://docs.openstack.org/admin-guide/shared_file_systems_network_plugins.html#network-plug-ins>`_.
