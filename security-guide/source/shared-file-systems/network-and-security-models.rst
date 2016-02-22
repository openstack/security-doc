.. _shared_fs_network&security_models:

===========================
Network and security models
===========================
The share driver in the Shared File Systems service is a Python class that can
be set for the back end and run in it to manage the share operations, some of
which are vendor-specific. The back end is an instance of the manila-share
service. There are big number of the share drivers created by different vendors
in the Shared File Systems service. Each share driver supports one or more back
end modes: *share servers* and *no share servers*, but the administrator
chooses which mode is used by specifying it in the configuration file
``manila.conf``.

The *share servers* mode can be configured with flat network, or with segmented
network. This depends on the network provider.

It is possible to have separate drivers for different modes on the same
hardware, if you want to have different configurations. Depending on which mode
is chosen, the administrator needs to provide additional details in the
configuration file as well.

.. _share-servers-vs-no-share-servers:

Share back ends modes
---------------------

Each share driver supports one or two of possible driver modes to configure the
back ends. Initially there are two driver modes for the back ends:

* **share servers mode**
* **no share servers mode**

The configuration option in the ``manila.conf`` file that set the share
servers mode or no share servers mode is the ``driver_handles_share_servers``
option, that defines the driver mode for share storage life cycle management:

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

This is the share types which have the extra specifications that help scheduler
to filter back ends and choose the appropriate back end for the user that
requested to create a share. For details of managing the share types and
configuration the back ends, see `Share types <http://docs.openstack.org/admin-
guide-cloud/shared_file_systems_share_types.html>`_ and `Multi-storage
configuration <http://docs.openstack.org/admin-guide-cloud/shared_file_systems_
multi_backend.html>`_ documentation.

No share servers mode
   In this mode, drivers have basically no network requirements whatsoever.
   It's assumed that the actual storage controller(s) being managed by the
   driver has all of the network interfaces it's going to need. The Shared
   File Systems service will expect the driver to provision shares directly
   without creating any share server beforehand. This mode corresponds to
   what some existing drivers are already doing, but it makes explicit the
   choice for the administrator. In this mode, the share networks are not
   needed at share creation time and must not be provided.

.. note::
   In *no share servers mode* the Shared File Systems service will assume that
   the network interfaces through which any shares are exported are already
   reachable by all tenants.

In the *no share servers* mode the share driver does not handle the storage
life cycle. The administrator is expected to handle the storage, network
interfaces, and other host configurations. In this mode an administrator can
have the storage(s) as a host which exports the shares. The main characteristic
of this mode is that the storage is not handled by the Shared File Systems
service. The users in tenants share the common network(s), host, processor, and
network pipe. The users can hinder each other if there is no correct balancing
adjustment on the storage configured by admin or proxy before it. In the
public clouds it is possible that all the network pipe is used by one client,
so the administrator should handle this case not to happen. The balancing
adjustment can be configured by any means, not only OpenStack tools.

Share servers mode
   In this mode, the driver is able to create share servers and join them to
   an existing network. When providing a new share server, the drivers expect
   an IP address and subnet from the Shared File Systems service.

Unlike the no share servers mode, in the *share servers* mode the users have
the share network and the share server that is created for each share network.
Thus all users have separate CPU, amount of CPU time, network, capacity and
throughput.

You also can configure the
:ref:`security services <shared_fs_security_services>` in both *share servers*
and *no share servers* back-end modes. But with *no share servers* back-end
mode, an administrator should set the desired authentication services manually
on the host. And in the *share servers* mode of the back end The Shared File
Systems service can be configured automatically with any of existing security
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
    The Shared File Systems service is just keeping the information about the
    networks in the database, and the real networks are available due to the
    network provider. In OpenStack it can be Legacy networking (nova-network)
    or Networking (neutron) services, but actually the Shared File Systems
    service can work even out of OpenStack. That is due to the
    ``StandaloneNetworkPlugin`` that can be used with any network platform and
    does not require some specific network services in OpenStack like
    Networking or Legacy networking services. You can set the network
    parameters in its configuration file.

In the :ref:`share servers <share-servers-vs-no-share-servers>` back-end mode
the share driver creates and manages the share server for each share network.
This mode can be divided on two variations:

* Flat network in *share servers* back-end mode
* Segmented network in *share servers* back-end mode

Initially, while creating the share network, you can set up either a network
and subnet of the OpenStack Networking (neutron) or a network of Legacy
networking (nova-network) services. The third approach is to configure the
networking without Legacy networking and Networking services. The
``StandaloneNetworkPlugin`` can be used with any network platform. You can set
the network parameters in its configuration file.

.. tip::
   All the share drivers that use the OpenStack Compute service do not use the
   network plug-ins. In Liberty release it is Windows and Generic drivers, so
   these share drives have other options and use different approach.

After the share network is created, the Shared File Systems service retrieves
the network information determined by the network provider, for example, the
network type, the segmentation identifier if the network uses segmentation, the
IP block in Classless Inter-Domain Routing (CIDR) notation from which to
allocate the network.

Below you can see the comparison of the flat network with segmented
network in *share servers* back-end mode.

**Flat network in share servers back-end mode**

In this mode, some storage controllers can create share servers but due to
various limitations of the physical or logical network all of the share servers
have to be on a flat network. In this mode, the share driver needs something to
provision IP addresses for the share servers, but the IPs all come out of the
same subnet and that subnet itself is assumed to be reachable by all tenants.

In this mode, the :ref:`security service part <shared_fs_security_services>` of
the share networks is important because it allows tenants to specify security
requirements such as AD or LDAP domains or a Kerberos realm. The Shared File
Systems service assumes that any hosts referred to in the security service are
reachable from the subnet where the share server is created, which limits the
situations where this mode makes sense.

**Segmented network in share servers back-end mode**

In this mode, the share driver is able to create share servers and join them to
an existing segmented network. The share drivers expect the Shared File systems
to provide for every new share server a subnet definition including a
segmentation type which is VLAN, VXLAN, or GRE, segmentation ID, and any other
info relevant to the segmentation type.

The security aspects of the configured networks depends on the configuration
itself and the network provider.

.. note::
    The share drivers may not support every type of segmentation, for details
    see the specification for each driver.

.. _shared_fs_network_plugins:

Network plug-ins
----------------

The Shared File Systems service architecture defines an abstraction layer for
network resource provisioning and allowing administrators to choose from a
different options for how network resources are assigned to their tenants’
networked storage. There are a set of network plug-ins that provide a variety
of integration approaches with the network services that are available with
OpenStack.

The network plug-ins allow to use any functions, configurations of the
OpenStack Networking and Legacy networking services, for example, you can use
any network segmentation that the Networking service supports, you can use
flat networks or VLAN-segmented networks of the Legacy networking
(nova-network) service, or you can use the plug-in for specifying networks
independently from OpenStack networking services. For more information of how
to use different network plug-ins, see `Shared File Systems service Network
plug-ins <http://docs.openstack.org/admin-guide-cloud/shared_file_systems_
network_plugins.html#network-plug-ins>`_. The security in using different
network plug-ins depends on the specific network configuration.
