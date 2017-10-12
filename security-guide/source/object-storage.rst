==============
Object Storage
==============

OpenStack Object Storage (swift) service provides software that
stores and retrieves data over HTTP. Objects (blobs of data) are stored in an
organizational hierarchy that offers anonymous read-only access, ACL defined
access, or even temporary access. Object Storage supports multiple token-based
authentication mechanisms implemented via middleware.

Applications store and retrieve data in Object Storage via an
industry-standard HTTP RESTful API. Back end components of Object Storage
follow the same RESTful model, although some APIs, such as those managing
durability, are kept private to the cluster.
For more details on the API see the
`OpenStack Storage API
<https://developer.openstack.org/api-ref/object-storage/>`_.

The components of Object Storage are grouped into the following primary groups:

#. Proxy services
#. Auth services
#. Storage services

   -  Account service
   -  Container service
   -  Object service

.. figure:: figures/swift_network_diagram-1.png
   :width: 100%

   An example diagram from the OpenStack Object Storage Administration Guide
   (2013)

.. note::

   An Object Storage installation does not have to be on the
   Internet and could also be a private cloud with the public switch a
   part of the organization's internal network infrastructure.

Network security
~~~~~~~~~~~~~~~~

Securing the Object Storage service begins with securing the networking
component. If you skipped the networking chapter, return to :doc:`networking`.

The rsync protocol is used between storage service nodes to replicate data for
high availability. In addition, the proxy service communicates with the storage
service when relaying data back and forth between the client end-point and the
cloud environment.

.. caution::

    Object Storage does not employ encryption or authentication with inter-node
    communications. This is why you see a private switch or private network
    ([V]LAN) in the architecture diagrams. This data domain should be separate
    from other OpenStack data networks as well. For further discussion on
    security domains please see :doc:`introduction/security-boundaries-and-threats`.

.. tip::

    Use a private (V)LAN network segment for your storage nodes in the
    data domain.

This necessitates that the proxy nodes have dual interfaces (physical or
virtual):

#. One as a public interface for consumers to reach.
#. Another as a private interface with access to the storage nodes.

The following figure demonstrates one possible network architecture.

.. figure:: figures/swift_network_diagram-2.png
   :width: 100%

   Object Storage network architecture with a management node (OSAM)

General service security
~~~~~~~~~~~~~~~~~~~~~~~~

Run services as non-root user
-----------------------------

We recommend that you configure the Object Storage service to run under a
non-root (UID 0) service account. One recommendation is the user name ``swift``
with the primary group ``swift``. Object Storage services include, for example,
``proxy-server``, ``container-server``, ``account-server``. Detailed steps
for setup and configuration can be found in the `Add Object Storage chapter
<https://docs.openstack.org/project-install-guide/object-storage/ocata/>`_
of the Installation Guide in the `OpenStack Documentation index
<https://docs.openstack.org>`_.

.. note::

   The above link defaults to the Ubuntu version.

File permissions
----------------

The ``/etc/swift`` directory contains information about the ring topology
and environment configuration. The following permissions are recommended:

.. code-block:: console

   # chown -R root:swift /etc/swift/*
   # find /etc/swift/ -type f -exec chmod 640 {} \;
   # find /etc/swift/ -type d -exec chmod 750 {} \;

This restricts only root to be able to modify configuration files while
allowing the services to read them through their group membership in the
``swift`` group.

Securing storage services
~~~~~~~~~~~~~~~~~~~~~~~~~

The following are the default listening ports for the various storage services:

.. list-table::
   :header-rows: 1
   :widths: 30 10 10

   * - Service name
     - Port
     - Type
   * - Account service
     - 6002
     - TCP
   * - Container service
     - 6001
     - TCP
   * - Object Service
     - 6000
     - TCP
   * - Rsync [1]_
     - 873
     - TCP

.. [1]
   If ssync is used instead of rsync, the object service port is used for
   maintaining durability.

.. important::

   Authentication does not take place at the storage nodes. If you are able to
   connect to a storage node on one of these ports, you can access or modify
   data without authentication. In order to secure against this issue you should
   follow the recommendations given previously about using a private storage
   network.

Object Storage account terminology
----------------------------------

An Object Storage account is not a user account or credential. The following
explains the relations:

.. list-table::
   :widths: 30 30

   * - OpenStack Object Storage account
     - Collection of containers; not user accounts or authentication. Which
       users are associated with the account and how they may access it
       depends on the authentication system used. See
       :ref:`Object_Storage_authentication`.
   * - OpenStack Object Storage containers
     - Collection of objects. Metadata on the container is available for
       ACLs. The meaning of ACLs is dependent on the authentication system
       used.
   * - OpenStack Object Storage objects
     - The actual data objects. ACLs at the object level are also possible
       with metadata and are dependent on the authentication system used.

At each level, you have ACLs that dictate who has what type of access. ACLs
are interpreted based on what authentication system is in use. The two most
common types of authentication providers used are Identity service (keystone)
and TempAuth. Custom authentication providers are also possible. See
:ref:`object_storage_authentication` for more information.

Securing proxy services
~~~~~~~~~~~~~~~~~~~~~~~

A proxy node should have at least two interfaces (physical or virtual): one
public and one private. Firewalls or service binding might protect the public
interface. The public facing service is an HTTP web server that processes
end-point client requests, authenticates them, and performs the appropriate
action. The private interface does not require any listening services, but is
instead used to establish outgoing connections to storage nodes on the private
storage network.

HTTP listening port
-------------------

You should configure your web service as a non-root (no UID 0) user such as
``swift`` mentioned before. The use of a port greater than 1024 is required to
make this easy and avoid running any part of the web container as root.
Normally, clients using the HTTP REST API and performing authentication
automatically retrieve the full REST API URL they require from the
authentication response. OpenStack's
REST API allows for a client to authenticate to one URL and then be told to
use a completely different URL for the actual service. For example, a Client
authenticates to
https://identity.cloud.example.org:55443/v1/auth and gets a response with
their authentication key and Storage URL (the URL of the proxy nodes or load
balancer) of https://swift.cloud.example.org:44443/v1/AUTH_8980.

The method for configuring your web server to start and run as a non-root user
varies by web server and operating system.

Load balancer
-------------

If the option of using Apache is not feasible, or for performance you wish to
offload your TLS work, you may employ a dedicated network device load balancer.
This is a common way to provide redundancy and load balancing when using
multiple proxy nodes.

If you choose to offload your TLS, ensure that the network link between the
load balancer and your proxy nodes are on a private (V)LAN segment such that
other nodes on the network (possibly compromised) cannot wiretap (sniff) the
unencrypted traffic. If such a breach were to occur, the attacker could gain
access to end-point client or cloud administrator credentials and access the
cloud data.

The authentication service you use, such as Identity service (keystone) or
TempAuth, will determine how you configure a different URL in the responses to
end-point clients so they use your load balancer instead of an individual proxy
node.

.. _object_storage_authentication:

Object Storage authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Object Storage uses a WSGI model to provide for a middleware capability that
not only provides general extensibility, but is also used for authentication of
end-point clients. The authentication provider defines what roles and user
types exist. Some use traditional user name and password credentials, while
others may leverage API key tokens or even client-side x.509 certificates.
Custom providers can be integrated in using custom middleware.

Object Storage comes with two authentication middleware modules by default,
either of which can be used as sample code for developing a custom
authentication middleware.

TempAuth
--------

TempAuth is the default authentication for Object Storage. In contrast to
Identity, it stores the user accounts, credentials, and metadata in object
storage itself. More information can be found in the section `The Auth System
<https://docs.openstack.org/swift/latest/overview_auth.html>`_ of the Object
Storage (swift) documentation.

Keystone
--------

Keystone is the commonly used Identity provider in OpenStack. It may also be
used for authentication in Object Storage. Coverage of securing keystone is
already provided in :doc:`identity`.

Other notable items
~~~~~~~~~~~~~~~~~~~

In ``/etc/swift``, on every node, there is a ``swift_hash_path_prefix``
setting and a ``swift_hash_path_suffix`` setting. These are provided to reduce
the chance of hash collisions for objects being stored and avert one user
overwriting the data of another user.

This value should be initially set with a cryptographically secure random
number generator and consistent across all nodes. Ensure that it is protected
with proper ACLs and that you have a backup copy to avoid data loss.
