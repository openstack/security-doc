.. _shared_fs_security_services:

=================
Security services
=================

For authentication and authorization of clients, the Shared File Systems
Storage service can optionally be configured with different network
authentication protocols. Supported authentication protocols are LDAP,
Kerberos, and Microsoft Active directory authentication service.

Introduction to security services
---------------------------------
After creating a share and getting its export location, users have no
permissions to mount it and operate with files. The Shared File System service
requires to explicitly grant access to the new share.

The client configuration data for authentication and authorization
(AuthN/AuthZ) can be stored by ``security services``. LDAP, Kerberos, or
Microsoft Active directory can be used by the Shared File Systems service if
they are supported by used drivers and back ends. Authentication
services can also be configured without the Shared File Systems service.

.. note::

    In some cases, it is required to explicitly specify one of the security
    services, for example, NetApp, EMC and Windows drivers require Active
    Directory for the creation of shares with the CIFS protocol.

Security services management
----------------------------
A *security service* is the Shared File Systems service (manila) entity that
abstracts a set of options that defines a security domain for a particular
shared file system protocol, such as an Active Directory domain or a Kerberos
domain. The security service contains all of the information necessary for
the Shared File Systems to create a server that joins a given domain.

Using the API, users can create, update, view and delete a security service.
Security Services are designed basing on the following assumptions:

* Tenants provide details for the security service.
* Administrators care about security services: they configure the server side
  of such security services.
* Inside The Shared File Systems API, a ``security_service`` is associated with
  the ``share_networks``.
* Share drivers use data in the security service to configure
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

The Shared File Systems service allows you to configure a security service
with these options:

* A DNS IP address that is used inside the tenant network.
* An IP address or host name of a security service.
* A domain of a security service.
* A user or group name that is used by a tenant.
* A password for a user, if you specify a user name.

An existing security service entity can be associated with share network
entities that inform the Shared File Systems service about security and
network configuration for a group of shares. You can also see the list of all
security services for a specified share network and disassociate them from
a share network.

For details of managing security services via API, see the `Security
services API <https://docs.openstack.org/api-ref/shared-file-system/index.html#security-services>`_.
You also can manage security services via python-manilaclient,
see `Security services CLI managing <https://docs.openstack.org/admin-guide/shared_file_systems_security_services.html>`_.

An administrator and users as share owners can manage the
:ref:`access to the shares <shared_fs_share_acl>` by creating access
rules with authentication though an IP address, user, group, or TLS
certificates. Authentication methods depend on which share driver and
security service you configure and use.

Thus, as an administrator, you can configure a back end to use specific
authentication service via network and it will store users. The
authentication service can operate with clients without the Shared File System
and the Identity service.

.. note::

    Different authentication services are supported by different share drivers.
    For details of supporting of features by different drivers, see
    `Manila share features support mapping <https://docs.openstack.org/manila/latest/contributor/share_back_ends_feature_support_mapping.html>`_.
    Support for a specific authentication service by a driver does not
    mean that it can be configured with any shared file system protocol.
    Supported shared file systems protocols are NFS, CIFS, GlusterFS, and HDFS.
    See the driver vendor's documentation for information on a specific driver
    and its configuration for security services.

Some drivers support security services and other drivers do not support any
of the security services mentioned above. For example, Generic Driver with
the NFS or the CIFS shared file system protocol supports only authentication
method through the IP address.

.. tip::

    * Those drivers that support the CIFS shared file system protocol in most
      cases can be configured to use Active Directory and manage access through
      the user authentication.
    * Drivers that support the GlusterFS protocol can be used with
      authentication via TLS certificates.
    * With drivers that support NFS protocol authentication via IP address
      is the only supported option.
    * Since the HDFS shared file system protocol uses NFS access it also can be
      configured to authenticate via IP address.

    Note, however, that authentication via IP is the least secure type of
    authentication.

The recommended configuration for the Shared File Systems service real usage
is to create a share with the CIFS share protocol and add to it the Microsoft
Active Directory directory service. In this configuration you will get the
centralized data base and the service that unites Kerberos and LDAP approaches.
This is a real use case that is convenient for production shared file
systems.
