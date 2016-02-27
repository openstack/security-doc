===========================================
Networking services security best practices
===========================================

To secure OpenStack Networking, you must understand how the workflow
process for tenant instance creation needs to be mapped to security
domains.

There are four main services that interact with OpenStack Networking. In
a typical OpenStack deployment these services map to the following
security domains:

-  OpenStack dashboard: Public and management

-  OpenStack Identity: Management

-  OpenStack compute node: Management and guest

-  OpenStack network node: Management, guest, and possibly public
   depending upon neutron-plugin in use.

-  SDN services node: Management, guest and possibly public depending
   upon product used.

.. image:: ../figures/1aa-logical-neutron-flow.png
   :width: 100%

To isolate sensitive data communication between the OpenStack Networking
services and other OpenStack core services, configure these
communication channels to only allow communication over an isolated
management network.

OpenStack Networking service configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Restrict bind address of the API server: neutron-server
-------------------------------------------------------

To restrict the interface or IP address on which the OpenStack
Networking API service binds a network socket for incoming client
connections, specify the bind\_host and bind\_port in the neutron.conf
file as shown:

.. code:: ini

    # Address to bind the API server
    bind_host = IP ADDRESS OF SERVER

    # Port the bind the API server to
    bind_port = 9696

Restrict DB and RPC communication of the OpenStack Networking services
----------------------------------------------------------------------

Various components of the OpenStack Networking services use either the
messaging queue or database connections to communicate with other
components in OpenStack Networking.

It is recommended that you follow the guidelines provided in
:ref:`database-authentication-and-access-control` for all components
which require direct DB connections.

It is recommended that you follow the guidelines provided in
:ref:`queue-authentication-and-access-control` for all components which
require RPC communication.
