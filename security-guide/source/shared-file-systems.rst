===================
Shared File Systems
===================

The Shared File Systems service (manila) provides a set of services for
management of shared file systems in a multi-tenant cloud environment. It is
done similar to how OpenStack provides block-based storage management through
the OpenStack Block Storage service project. With the Shared File Systems
service, you can create a shared file system and manage its properties such as
visibility, accessibility and usage quotas.

The Shared File Systems service works with various storage providers that use
the following shared file system protocols:
:term:`NFS <Network File System (NFS)>`,
:term:`CIFS <Common Internet File System (CIFS)>`, :term:`GlusterFS`, and
:term:`HDFS <Hadoop Distributed File System (HDFS)>`.

The Shared File Systems service serves the same purpose as Amazon Elastic File
System (EFS).

.. toctree::
   :maxdepth: 2

   shared-file-systems/intro.rst
   shared-file-systems/network-and-security-models.rst
   shared-file-systems/security-services.rst
   shared-file-systems/share-acl.rst
   shared-file-systems/share-type-acl.rst
   shared-file-systems/policies.rst
   shared-file-systems/checklist.rst
