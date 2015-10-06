.. _shared_fs_security_services:

=================
Security services
=================

For authentication and authorization of the clients, the Shared File Systems
Storage service can optionally be configured with different network
authentication protocols. Supported authentication protocols are LDAP,
Kerberos, or Microsoft Active directory authentication service.

Introduction to security services
---------------------------------
After creating the share and getting its export location users have no
permissions to mount it and operate with files. The Shared File System service
allows to grant or deny access to the shares.

The configuration information for clients for authentication and authorization
(AuthN/AuthZ) can be stored by ``security services``. This means that such
protocols as LDAP and Kerberos, or with Microsoft Active directory
authentication service can be used by the Shared File Systems service if they
exist and are supported by the drivers and back ends. These authentication
services also can be configured without the Shared File Systems service.

.. note::
    In some cases, it is required to add one of the security services. For
    example, NetApp, EMC and Windows drivers require Active Directory for the
    creation of shares with CIFS protocol.

Security services management
----------------------------
A *security service* is the Shared File Systems service (manila) term that
means a set of options that defines a security domain for a particular shared
file system protocol, such as an Active Directory domain or a Kerberos domain.
The security service contains all of the information necessary for the Shared
File Systems to create a server that joins the given domain.

Using the API users can create, update, view, delete a security service.
The security services are realized in the Shared File Systems API with such
key concepts:

* Tenants provide the details for the security service.
* Administrators care about security services: they configure the server side
  of such security services.
* Inside The Shared File Systems API, a ``security_service`` is associated with
  the ``share_networks``.
* The share drivers use the information in the security service to configure
  newly created share servers.

While creating a security service, you can select one of these authentication
services:

.. list-table::
   :header-rows: 1
   :widths: 20 70

   * - Authentication service
     - Description

   * - LDAP
     - The Lightweight Directory Access Protocol. An application protocol for
       accessing and maintaining distributed directory information services
       over an IP network.

   * - Kerberos
     - The network authentication protocol which works on the basis of tickets
       to allow nodes communicating over a non-secure network to prove their
       identity to one another in a secure manner.

   * - Active Directory
     - A directory service that Microsoft developed for Windows domain
       networks. Uses LDAP, Microsoft's version of Kerberos, and DNS.

The Shared File Systems allows you to configure a security service with these
options:

* A DNS IP address that is used inside the tenant network.
* An IP address or host name of a security service.
* A domain of a security service.
* A user or group name that is used by the tenant.
* The password for the user, if you specify a user name.

An existing security service entity can be associated with the share network
entities that inform the Shared File Systems service about the security and
network configuration for a group of shares. You can also see the list of all
security services for a specified share network and disassociate them from
a share network.

For details of managing the security services via API, see the `Security
services API <http://developer.openstack.org/api-ref-share-v2.html#share-security-
services>`_. You also can manage the security services via python-manilaclient,
see `Security services CLI managing <http://docs.openstack.org/admin-guide-
cloud/shared_file_systems_security_services.html>`_.

An administrator and the users as share owners can manage the
:ref:`access to the shares <shared_fs_share_acl>` by means of creating access
rules with authentication though ip address, user or group, or TLS
certificates. The authentication methods depend on which share driver and
security service you configure and use.

Thus as an administrator you can configure the backend to use the definite
authentication service via network and it will store the users. The
authentication service can operate with clients without the Shared File System
and the Identity service.

.. note::
    Different authentication services are supported by different share drivers.
    For details of supporting of features by different drivers, see
    `Manila share features support mapping <http://docs.openstack.org/developer
    /manila/devref/share_back_ends_feature_support_mapping.html>`_.
    The support of definite authentication service by the driver also doesn't
    mean that it can be configured with any shared file system protocol.
    Supported shared file systems protocols are NFS, CIFS, GlusterFS, and HDFS.
    See the driver vendor's documentation for the specific driver and its
    configuration for the security services.

Some drivers support the security services and other drivers do not support any
of the hereinabove security services.

The Generic Driver with NFS or CIFS shared file system protocol supports only
authentication method through the IP address.

.. tip::

    * Those drivers that support CIFS shared file system protocol in most
      cases can be configured to use Active Directory and manage access through
      user authentication.
    * Drivers that support GlusterFS protocol can be used with authentication
      via TLS certificates.
    * With drivers that support NFS protocol the authentication via IP address
      is the only supported.
    * Since the HDFS shared file system protocol uses NFS access it also can be
      configured to authenticate via IP address.

    The authentication via IP is the most weak.

The recommended configuration for the Shared File Systems service real usage
is to create a share with CIFS share protocol and add to it the Microsoft
Active Directory directory service. In this configuration you'll get the
centralized data base and the service that unites Kerberos and LDAP approaches.
This is a real use case that is convenient for the real production shared file
systems.
