===============
Data encryption
===============


The option exists for implementers to encrypt tenant data wherever it is stored
on disk or transported over a network, such as the OpenStack volume encryption
feature described below. This is above and beyond the general recommendation
that users encrypt their own data before sending it to their provider.

The importance of encrypting data on behalf of tenants is largely related to
the risk assumed by a provider that an attacker could access tenant data. There
may be requirements here in government, as well as requirements per-policy, in
private contract, or even in case law in regard to private contracts for public
cloud providers. It is recommended that a risk assessment and legal consul
advised before choosing tenant encryption policies.

Per-instance or per-object encryption is preferable over, in descending order,
per-project, per-tenant, per-host, and per-cloud aggregations.  This
recommendation is inverse to the complexity and difficulty of implementation.
Presently, in some projects it is difficult or impossible to implement
encryption as loosely granular as even per-tenant. We recommend implementors
make a best-effort in encrypting tenant data.

Often, data encryption relates positively to the ability to reliably destroy
tenant and per-instance data, simply by throwing away the keys.  It should be
noted that in doing so, it becomes of great importance to destroy those keys in
a reliable and secure manner.

Opportunities to encrypt data for users are present:

-  Object Storage objects
-  Network data

Volume encryption
~~~~~~~~~~~~~~~~~

A volume encryption feature in OpenStack supports privacy on a per-tenant
basis. As of the Kilo release, the following features are supported:

-  Creation and usage of encrypted volume types, initiated through the
   dashboard or a command line interface

   -  Enable encryption and select parameters such as encryption
      algorithm and key size

-  Volume data contained within iSCSI packets is encrypted
-  Supports encrypted backups if the original volume is encrypted
-  Dashboard indication of volume encryption status. Includes indication
   that a volume is encrypted, and includes the encryption parameters
   such as algorithm and key size
-  Interface with the Key management service through a secure wrapper

   -  Volume encryption is supported by back-end key storage for
      enhanced security (for example, a Hardware Security Module (HSM)
      or a KMIP server can be used as a Barbican back-end secret store)

Ephemeral disk encryption
~~~~~~~~~~~~~~~~~~~~~~~~~

An ephemeral disk encryption feature addresses data privacy. The ephemeral disk
is a temporary work space used by the virtual host operating system. Without
encryption, sensitive user information could be accessed on this disk, and
vestigial information could remain after the disk is unmounted. As of the Kilo
release, the following ephemeral disk encryption features are supported:

-  Creation and usage of encrypted LVM ephemeral disks (note: At this time
   OpenStack Compute service only supports encrypting ephemeral disks in the
   LVM format)

   -  The compute configuration, ``nova.conf``, has the following default
      parameters within the "[ephemeral_storage_encryption]" section

      - **option**: 'cipher = aes-xts-plain64'

        - This field sets the cipher and mode used to encrypt ephemeral
          storage. AES-XTS is recommended by NIST_ specifically for disk
          storage, and the name is shorthand for AES encryption using the
          XTS encryption mode.  Available ciphers depend on kernel support.
          At the command line, type 'cyrptsetup benchmark' to determine the
          available options (and see benchmark results), or go to
          */proc/crypto*

      - **option**: 'enabled = false'

        - To use ephemeral disk encryption, set **option**: 'enabled = true'

      - **option**: 'key_size = 512'

        - Note that there may be a key size limitation from the backend key
          manager that could require the use of 'key_size = 256', which would
          only provide an AES key size of 128-bits. XTS requires it's own
          "tweak key" in addition to the encryption key AES requires.
          This is typically expressed as a single large key.  In this case,
          using the 512-bit setting, 256 bits will be used by AES and 256 bits
          by XTS. (see NIST_)

-  Interface with the Key management service through a secure wrapper

   -  Key management service will support data isolation by providing
      ephemeral disk encryption keys on a per-tenant basis

   -  Ephemeral disk encryption is supported by back-end key storage for
      enhanced security (for example, an HSM or a KMIP server can be
      used as a barbican back-end secret store)

   -  With the Key management service, when an ephemeral disk is no
      longer needed, simply deleting the key may take the place of
      overwriting the ephemeral disk storage area

.. _NIST: http://csrc.nist.gov/publications/nistpubs/800-38E/nist-sp-800-38E.pdf

Object Storage objects
~~~~~~~~~~~~~~~~~~~~~~

The ability to encrypt objects in Object Storage is presently limited to
disk-level encryption per node. However, there does exist third-party
extensions and modules for per-object encryption. These modules have been
proposed upstream, but have not per this writing been formally accepted. Below
are some pointers:

https://github.com/Mirantis/swift-encrypt

http://www.mirantis.com/blog/on-disk-encryption-prototype-for-openstack-swift/

Block Storage volumes and instance ephemeral filesystems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Block Storage supports a variety of mechanisms for supplying mountable volumes.
The ability to encrypt volumes on the storage host depends on the service back
ends chosen. Some back ends may not support this at all. It is outside the
scope of this guide to specify recommendations for each Block Storage back-end
driver.

For the purpose of performance, many storage protocols are unencrypted.  Some
protocols such as iSCSI can provide authentication and encrypted sessions, it
is our recommendation to enable these features.

As both block storage and compute support LVM backed storage, we can easily
provide an example applicable to both systems. In deployments using LVM,
encryption may be performed against the backing physical volumes. An encrypted
block device would be created using the standard Linux tools, with the LVM
physical volume (PV) created on top of the decrypted block device using
pvcreate. Then, the vgcreate or vgmodify tool may be used to add the encrypted
physical volume to an LVM volume group (VG).

Network data
~~~~~~~~~~~~

Tenant data for compute could be encrypted over IPsec or other tunnels.  This
is not functionality common or standard in OpenStack, but is an option
available to motivated and interested implementors.

Likewise, encrypted data will remain encrypted as it is transferred over the
network.
