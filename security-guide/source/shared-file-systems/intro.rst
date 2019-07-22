.. _shared_fs_intro:

Introduction
------------
The Shared File Systems service (manila) is intended to be ran on a single-node
or across multiple nodes. The Shared File Systems service consists of four
main services, which are similar to those of the Block Storage service:

- ``manila-api``
- ``manila-scheduler``
- ``manila-share``
- ``manila-data``

``manila-api``
   The service that provides a stable RESTful API. The service
   authenticates and routes requests throughout the Shared Filesystem
   service. There is python-manilaclient to interact with the API.
   For more details on the Shared File Systems API, see the `OpenStack
   Shared File Systems API <https://docs.openstack.org/api-ref/shared-file-system/>`_.
``manila-share``
   Responsible for managing Shared File Service devices, specifically the
   back-end devices.
``manila-scheduler``
   Responsible for scheduling and routing requests to the appropriate
   ``manila-share`` service. It does that by picking one back-end while
   filtering all except one back-end.
``manila-data``
   This service is responsible for managing data operations which may take a
   long time to complete and block other services if not handled separately.

The Shared File Systems service uses an SQL-based central database that is
shared by all Shared File Systems services in the system. It can use any SQL
dialect supported by ORM SQLALchemy, but is tested only with MySQL and
PostgreSQL data bases.

Using SQL, the Shared File Systems service is similar to other OpenStack
services and can be used with any OpenStack deployment. For more details on
the API, see the `OpenStack Shared File Systems API
<https://docs.openstack.org/api-ref/shared-file-system/>`_ description. For more
details on the CLI usage and configuration, see `Shared File Systems Cloud
Administrative Guide
<https://docs.openstack.org/admin-guide/shared_file_systems.html>`_.

On the image below you can see how different parts of the Shared File System
service interact with each other.

.. image:: ../figures/manila-intro.png

Besides already described services you can see two other entities on the
image: ``python-manilaclient`` and ``storage controller``.

``python-manilaclient``
   Command line interface to interact with the Shared File Systems service
   via ``manila-api`` and also a Python module to interact programmatically
   with the Shared File Systems service.
``Storage controller``
   Typically a metal box with spinning disks, ethernet ports, and some
   kind of software that allows network clients to read and write files on
   the disks. There are also software-only storage controllers that run on
   arbitrary hardware, clustered controllers which may run allow a
   multiple physical devices to appear as a single storage controller, or
   purely virtual storage controllers.

A share is a remote, mountable file system. You can mount a share to and access
a share from several hosts by several users at a time.

The Shared File Systems service can work with different network types:
flat, VLAN, VXLAN, or GRE, and supports segmented networking. There are
also different :ref:`network plug-ins <shared_fs_network_plugins>` that provide
a variety of integration approaches with the network services that are
available with OpenStack.

There are a large number of share drivers created by different vendors which
support different hardware storage solutions, for example, NetApp Clustered
Data ONTAP (cDOT) Driver, Huawei NAS Driver or GlusterFS Driver. Each share
driver is a Python class that can be set for a back end and run in the back
end to manage share operations, some of which can be vendor-specific. The back
end is an instance of the manila-share service.

Clients' configuration data for authentication and authorization
can be stored by :ref:`security services <shared_fs_security_services>`.
Such protocols as LDAP, Kerberos, or Microsoft Active Directory authentication
service can be configured and used.

Unless it is not explicitly changed in the ``policy.json``, either an
administrator or the tenant that owns a share are able to manage
:ref:`access to the shares <shared_fs_share_acl>`. Access management is done by
creating access rules with authentication through IP address, user, group, or
TLS certificates. Available authentication methods depend on which share
driver and security service you configure and use.

.. note::

    Different drivers support different access options depending on which
    shared file system protocol is used. Supported shared file system protocols
    are NFS, CIFS, GlusterFS, and HDFS. For example, the Generic (Block Storage
    as a back end) driver does not support user and certificate authentication
    methods. It also does not support any of the security services, such as
    LDAP, Kerberos, or Active Directory. For details of features supported by
    different drivers, see `Manila share features support mapping
    <https://docs.openstack.org/manila/latest/contributor/share_back_ends_feature_support_mapping.html>`_.

As an administrator, you can create share types that enable the scheduler to
filter back ends before you create a share. Share types have extra
specifications that you can set for the scheduler to filter and weigh back
ends so that an appropriate one is selected for a user that requests
share creation. Shares and share types can be created as public or private.
This level of visibility defines whether other tenants are able to see these
objects and operate with them, or not. An administrator can add
:ref:`access to the private share types <shared_fs_share_types_acl>` for
specific users or tenants in the Identity service. Thus users which you have
granted access can see available share types and create shares using them.

Permissions for API calls for different users and their roles are determined
by :ref:`policies <shared_fs_policies>` like in other OpenStack services.

The Identity service can be used for authentication in the Shared File
Systems service. See details of the Identity service security in
:doc:`../identity` section.

General security information
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Similar to other OpenStack projects, the Shared File Systems service is
registered with the Identity service, so you can find API endpoints of the
share service v1 and v2 using **manila endpoints** command:

.. code:: console

 $ manila endpoints
 +-------------+-----------------------------------------+
 | manila      | Value                                   |
 +-------------+-----------------------------------------+
 | adminURL    | http://172.18.198.55:8786/v1/20787a7b...|
 | region      | RegionOne                               |
 | publicURL   | http://172.18.198.55:8786/v1/20787a7b...|
 | internalURL | http://172.18.198.55:8786/v1/20787a7b...|
 | id          | 82cc5535aa444632b64585f138cb9b61        |
 +-------------+-----------------------------------------+

 +-------------+-----------------------------------------+
 | manilav2    | Value                                   |
 +-------------+-----------------------------------------+
 | adminURL    | http://172.18.198.55:8786/v2/20787a7b...|
 | region      | RegionOne                               |
 | publicURL   | http://172.18.198.55:8786/v2/20787a7b...|
 | internalURL | http://172.18.198.55:8786/v2/20787a7b...|
 | id          | 2e8591bfcac4405fa7e5dc3fd61a2b85        |
 +-------------+-----------------------------------------+

By default, the Shared File Systems API service listens only on the port
``8786`` with ``tcp6`` type that supports both IPv4 and IPv6.

.. note::

    The port ``8786`` is the default port for the Shared File Systems service.
    It may be changed to any other port, but this change should also be made
    in the configuration file to option ``osapi_share_listen_port`` which
    defaults to ``8786``.

In the ``/etc/manila/`` directory you can find several configuration files:

.. code:: console

 api-paste.ini
 manila.conf
 policy.json
 rootwrap.conf
 rootwrap.d

 ./rootwrap.d:
 share.filters

It is recommended that you configure the Shared File Systems service to run
under a non-root service account, and change file permissions so that only
the system administrator can modify them. The Shared File Systems service
expects that only administrators can write to configuration files and services
can only read them through their group membership in ``manila`` group. Others
must not be able to read these files because the files contain admin passwords
for different services.

Apply checks :ref:`check_shared_fs_01` and :ref:`check_shared_fs_02`
from the checklist to verify that permissions are set properly.

.. note::

    The configuration for manila-rootwrap in file ``rootwrap.conf`` and the
    manila-rootwrap command filters for share nodes in file
    ``rootwrap.d/share.filters`` should be owned by, and only-writeable by, the
    root user.

.. tip::

    The manila configuration file ``manila.conf`` may be placed anywhere.
    The path ``/etc/manila/manila.conf`` is expected by default.
