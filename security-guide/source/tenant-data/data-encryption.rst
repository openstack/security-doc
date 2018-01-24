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
per-project, per-tenant, per-host, and per-cloud aggregations. This
recommendation is inverse to the complexity and difficulty of implementation.
Presently, in some projects it is difficult or impossible to implement
encryption as loosely granular as even per-tenant. We recommend implementors
make a best-effort in encrypting tenant data.

Often, data encryption relates positively to the ability to reliably destroy
tenant and per-instance data, simply by throwing away the keys. It should be
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
      or a KMIP server can be used as a barbican back-end secret store)

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
          XTS encryption mode. Available ciphers depend on kernel support.
          At the command line, type 'cryptsetup benchmark' to determine the
          available options (and see benchmark results), or go to
          */proc/crypto*

      - **option**: 'enabled = false'

        - To use ephemeral disk encryption, set **option**: 'enabled = true'

      - **option**: 'key_size = 512'

        - Note that there may be a key size limitation from the backend key
          manager that could require the use of 'key_size = 256', which would
          only provide an AES key size of 128-bits. XTS requires it's own
          "tweak key" in addition to the encryption key AES requires.
          This is typically expressed as a single large key. In this case,
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

Object Storage (swift) supports the optional encryption of object data at rest
on storage nodes. The encryption of object data is intended to mitigate the
risk of users’ data being read if an unauthorized party were to gain
physical access to a disk.

Encryption of data at rest is implemented by middleware that may be included in
the proxy server WSGI pipeline. The feature is internal to a swift cluster and
not exposed through the API. Clients are unaware that data is encrypted by
this feature internally to the swift service; internally encrypted data
should never be returned to clients through the swift API.

The following data are encrypted while at rest in swift:

- Object content. For example, the content of an object PUT request’s body
- The entity tag (ETag) of objects that have non-zero content
- All custom user object metadata values. For example, metadata sent using
  ``X-Object-Meta-`` prefixed headers with PUT or POST requests

Any data or metadata not included in the list above are not encrypted,
including:

- Account, container, and object names
- Account and container custom user metadata values
- All custom user metadata names
- Object Content-Type values
- Object size
- System metadata

For more information on the deployment, operation, or implementation of
Object Storage encryption, see the swift Developer Documentation on
`Object Encryption <https://docs.openstack.org/swift/latest/overview_encryption.html>`_.

Block Storage performance and backends
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When enabling the operating system, OpenStack Volume Encryption
performance can be enhanced by using the hardware acceleration features
currently available in both Intel and AMD processors. Both the OpenStack Volume
Encryption feature and the OpenStack Ephemeral Disk Encryption feature use
``dm-crypt`` to secure volume data. ``dm-crypt`` is a transparent disk
encryption capability in Linux kernel versions 2.6 and later.  When the Volume
Encryption is enabled, encrypted data is sent over iSCSI to Block Storage,
securing data in transit and data at rest simultaneously. When using hardware
acceleration, the performance impact of both of the encryption features is
minimized.

Although we recommend using the OpenStack Volume Encryption feature, Block
Storage supports a large variety of alternative back-ends for supplying
mountable volumes, and some of these may also provide volume encryption.
Since there are so many `back-ends
<https://docs.openstack.org/cinder/latest/drivers.html>`_, and since
information from each vendor must be obtained, it is outside the scope of this
guide to specify recommendations for implementing encryption in any of them.

Network data
~~~~~~~~~~~~

Tenant data for compute could be encrypted over IPsec or other tunnels. This
is not functionality common or standard in OpenStack, but is an option
available to motivated and interested implementors.

Likewise, encrypted data will remain encrypted as it is transferred over the
network.
