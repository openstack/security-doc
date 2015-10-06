===================
Shared File Systems
===================

The Shared File Systems service (manila) provides a set of services for
management of shared file systems in a multi-tenant cloud environment, similar
to how OpenStack provides for block-based storage management through the
OpenStack Block Storage service project. With the Shared File Systems service,
you can create a remote file system, mount the file system on your instances,
and then read and write data from your instances to and from your file system.

A large amount of existing software is designed around file-based storage. The
Shared File Systems service provides the management of file shares and works
with various storage providers that use following shared file system protocols:
NFS, CIFS, GlusterFS, and HDFS.

The Shared File Systems serves the same purpose as the Amazon Elastic File
System (EFS) offering does.

.. toctree::
   :maxdepth: 2

   shared-file-systems/intro.rst
   shared-file-systems/network-and-security-models.rst
   shared-file-systems/security-services.rst
   shared-file-systems/share-acl.rst
   shared-file-systems/share-type-acl.rst
   shared-file-systems/policies.rst
   shared-file-systems/checklist.rst
