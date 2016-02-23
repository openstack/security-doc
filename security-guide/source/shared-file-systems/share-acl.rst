.. _shared_fs_share_acl:

====================
Share access control
====================
The Shared File Systems service allows to grant or deny access to different
entities of the service for other clients.

Having a share as remote mountable instance of a file system, you can manage
access to a specified share, and list the permissions for a specified share.

The share can be *public* and *private*. This is a level of visibility for the
share that defines whether other tenants can or cannot see the share. By
default, the shares are created as private. While creating a share, use a key
:option:`--public` to make your share public for other tenants to see it in a
list of shares and see its detailed information.

According to a :ref:`policy.json <shared_fs_policies>` file, an administrator
and the users as share owners can manage the access to the shares by means of
creating access rules. Using :command:`manila access-allow`,
:command:`manila access-deny` and :command:`manila access-list` commands,
you can grant, deny and list access to a specified share correspondingly.

.. tip::

    By default, when a share is created and has its export location, the Shared
    File Systems service expects that nobody can access the share by mounting
    it. Pay attention that the share driver you use can change this
    configuration, or it can be directly changed on the share storage. To
    ensure the access to the share, check the mounting config for the export
    protocol.

When the share is just created there are no created access rules and expected
permission to mount a share. This is obtained by the mounting config for the
certain export protocol. For example, for the NFS protocol there is
``exportfs`` command or ``/etc/exports`` file on the storage which controls
each remote share and the hosts that can access it. It is empty if nobody can
mount a share. For the remote CIFS server there is ``net conf list`` command
which shows the configuration. The parameter ``hosts deny`` should be set by
the share driver to ``0.0.0.0/0`` which means that that hosts are denied to
mount the share.

Using the Shared File Systems service, you can grant or deny access to a share
by specifying one of these supported share access levels:

- **rw**. Read and write (RW) access. This is the default value.

- **ro**. Read-only (RO) access.

.. tip::

    The RO access level can be helpful in the public shares when the
    administrator gives read and write (RW) access for some certain editors or
    contributors and gives read-only (RO) access for the rest of users
    (viewers).

You must also specify one of these supported authentication methods:

* **ip**. Authenticates an instance through its IP address. A valid format is
  XX.XX.XX.XX or XX.XX.XX.XX/XX. For example 0.0.0.0/0.

* **cert**. Authenticates an instance through a TLS certificate. Specify the
  TLS identity as the IDENTKEY. A valid value is any string up to 64 characters
  long in the common name (CN) of the certificate.

* **user**. Authenticates by a specified user or group name. A valid value is
  an alphanumeric string that can contain some special characters and is from 4
  to 32 characters long.

.. note::

    The supported authentication methods depend on which share driver, security
    service and shared file system protocol you configure and use. Supported
    shared file system protocols are NFS, CIFS, GlusterFS, and HDFS. Supported
    security services are LDAP, Kerberos protocols, or Microsoft Active
    Directory service. For details of supporting of features by different
    drivers, see `Manila share features support mapping <http://docs.openstack.
    org/developer/manila/devref/share_back_ends_feature_support_
    mapping.html>`_.

To verify that the access rules (ACL) were configured correctly for a share,
you can list permissions for a share.

.. tip::

    You also can choose and add the :ref:`security service
    <shared_fs_security_services>` that is supported by the share driver to
    create access rules with authentication methods for clients that are
    appropriate for your share. The supported security services are LDAP,
    Kerberos and Microsoft Active Directory.

Below is an example of the NFS share with the Generic driver. After the share
was created it has export location
``10.254.0.3:/shares/share-b2874f8d-d428-4a5c-b056-e6af80a995de``. If you try
to mount it on the host with ``10.254.0.4`` IP address, you'll get the
*"Permission denied"* message.

.. code:: console

 # mount.nfs -v 10.254.0.3:/shares/share-b2874f8d-d428-4a5c-b056-e6af80a995de /mnt
 mount.nfs: timeout set for Mon Oct 12 13:07:47 2015
 mount.nfs: trying text-based options 'vers=4,addr=10.254.0.3,clientaddr=10.254.0.4'
 mount.nfs: mount(2): Permission denied
 mount.nfs: access denied by server while mounting 10.254.0.3:/shares/share-b2874f8d-...

As an administrator, you can connect through SSH to a host with ``10.254.0.3``
IP address, check the ``/etc/exports`` file on it and see that it is empty:

.. code:: console

 # cat /etc/exports
 #

The Generic driver we use in example does not support any of the security
services, thus with NFS shared file system protocol we can grant access only
through the IP address:

.. code:: console

 $ manila access-allow Share_demo2 ip 10.254.0.4
 +--------------+--------------------------------------+
 | Property     | Value                                |
 +--------------+--------------------------------------+
 | share_id     | e57c25a8-0392-444f-9ffc-5daadb9f756c |
 | access_type  | ip                                   |
 | access_to    | 10.254.0.4                           |
 | access_level | rw                                   |
 | state        | new                                  |
 | id           | 62b8e453-d712-4074-8410-eab6227ba267 |
 +--------------+--------------------------------------+

After the rule has status ``active`` we can connect to the ``10.254.0.3`` host
again and check the ``/etc/exports`` file and see that the line with rule
was added:

.. code:: console

 # cat /etc/exports
 /shares/share-b2874f8d-d428-4a5c-b056-e6af80a995de	10.254.0.4(rw,sync,wdelay,hide,nocrossmnt,secure,root_squash,no_all_squash,no_subtree_check,secure_locks,acl,anonuid=65534,anongid=65534,sec=sys,rw,root_squash,no_all_squash)
 #

Now we can mount a share on the host with IP address ``10.254.0.4`` and have
``rw`` permissions to the share:

.. code:: console

 # mount.nfs -v 10.254.0.3:/shares/share-b2874f8d-d428-4a5c-b056-e6af80a995de /mnt
 # ls -a /mnt
 .  ..  lost+found
 # echo "Hello!" > /mnt/1.txt
 # ls -a /mnt
 .  ..  1.txt  lost+found
 #

You also can list the access rules to each share and deny the access using the
Shared File Systems service CLI.

.. tip::

    To ensure that the granted or denied access with Shared File Systems
    service CLI is correct, check the mount config file on the storage before
    releasing a share to the production.
