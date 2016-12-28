=====================
Data privacy concerns
=====================

Data residency
~~~~~~~~~~~~~~

The privacy and isolation of data has consistently been cited as the primary
barrier to cloud adoption over the past few years. Concerns over who owns data
in the cloud and whether the cloud operator can be ultimately trusted as a
custodian of this data have been significant issues in the past.

Numerous OpenStack services maintain data and metadata belonging to tenants or
reference tenant information.

Tenant data stored in an OpenStack cloud may include the following items:

-  Object Storage objects
-  Compute instance ephemeral filesystem storage
-  Compute instance memory
-  Block Storage volume data
-  Public keys for Compute access
-  Virtual machine images in the Image service
-  Machine snapshots
-  Data passed to OpenStack Compute's configuration-drive extension

Metadata stored by an OpenStack cloud includes the following non-exhaustive
items:

-  Organization name
-  User's "Real Name"
-  Number or size of running instances, buckets, objects, volumes, and
   other quota-related items
-  Number of hours running instances or storing data
-  IP addresses of users
-  Internally generated private keys for compute image bundling

Data disposal
~~~~~~~~~~~~~

OpenStack operators should strive to provide a certain level of tenant data
disposal assurance. Best practices suggest that the operator sanitize cloud
system media (digital and non-digital) prior to disposal, release out of
organization control or release for reuse. Sanitization methods should
implement an appropriate level of strength and integrity given the specific
security domain and sensitivity of the information.

    "The sanitization process removes information from the media such that the
    information cannot be retrieved or reconstructed. Sanitization
    techniques, including clearing, purging, cryptographic erase, and
    destruction, prevent the disclosure of information to unauthorized
    individuals when such media is reused or released for disposal." `NIST
    Special Publication 800-53 Revision 4 <http://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r4.pdf>`__

General data disposal and sanitization guidelines as adopted from NIST
recommended security controls. Cloud operators should:

1. Track, document and verify media sanitization and disposal actions.
2. Test sanitation equipment and procedures to verify proper
   performance.
3. Sanitize portable, removable storage devices prior to connecting such
   devices to the cloud infrastructure.
4. Destroy cloud system media that cannot be sanitized.

In an OpenStack deployment you will need to address the following:

-  Secure data erasure
-  Instance memory scrubbing
-  Block Storage volume data
-  Compute instance ephemeral storage
-  Bare metal server sanitization

Data not securely erased
------------------------

Within OpenStack some data may be deleted, but not securely erased in the
context of the NIST standards outlined above. This is generally applicable to
most or all of the above-defined metadata and information stored in the
database. This may be remediated with database and/or system configuration for
auto vacuuming and periodic free-space wiping.

Instance memory scrubbing
-------------------------

Specific to various hypervisors is the treatment of instance memory. This
behavior is not defined in OpenStack Compute, although it is generally expected
of hypervisors that they will make a best effort to scrub memory either upon
deletion of an instance, upon creation of an instance, or both.

Xen explicitly assigns dedicated memory regions to instances and scrubs data
upon the destruction of instances (or domains in Xen parlance). KVM depends
more greatly on Linux page management; A complex set of rules related to KVM
paging is defined in the `KVM documentation
<http://www.linux-kvm.org/page/Memory>`__.

It is important to note that use of the Xen memory balloon feature is likely to
result in information disclosure. We strongly recommended to avoid use of this
feature.

For these and other hypervisors, we recommend referring to hypervisor-specific
documentation.

Cinder volume data
------------------

Use of the OpenStack volume encryption feature is highly encouraged. This is
discussed below in the Data Encryption section under Volume Encryption. When
this feature is used, destruction of data is accomplished by securely deleting
the encryption key. The end user can select this feature while creating a
volume, but note that an admin must perform a one-time set up of the volume
encryption feature first. Instructions for this setup are in the block
storage section of the `Configuration Reference
<http://docs.openstack.org/newton/config-reference/block-storage/volume-encryption.html>`__
, under volume encryption.

If the OpenStack volume encryption feature is not used, then other approaches
generally would be more difficult to enable. If a back-end plug-in is being
used, there may be independent ways of doing encryption or non-standard
overwrite solutions. Plug-ins to OpenStack Block Storage will store data in
a variety of ways. Many plug-ins are specific to a vendor or technology,
whereas others are more DIY solutions around filesystems such as LVM or ZFS.
Methods to securely destroy data will vary from one plug-in to another, from
one vendor's solution to another, and from one filesystem to another.

Some back-ends such as ZFS will support copy-on-write to prevent data exposure.
In these cases, reads from unwritten blocks will always return zero. Other back
ends such as LVM may not natively support this, thus the Block Storage plug-in
takes the responsibility to override previously written blocks before handing
them to users. It is important to review what assurances your chosen volume
back-end provides and to see what mediations may be available for those
assurances not provided.

Image service delay delete feature
----------------------------------

OpenStack Image service has a delayed delete feature, which will pend the
deletion of an image for a defined time period. It is recommended to disable
this feature if it is a security concern, by editing the
``etc/glance/glance-api.conf`` file and setting the ``delayed_delete``
option as False.

Compute soft delete feature
---------------------------

OpenStack Compute has a soft-delete feature, which enables an instance that is
deleted to be in a soft-delete state for a defined time period. The instance
can be restored during this time period. To disable the soft-delete feature,
edit the ``etc/nova/nova.conf`` file and leave the
``reclaim_instance_interval`` option empty.

Compute instance ephemeral storage
----------------------------------

Note that the OpenStack `Ephemeral disk encryption
<http://docs.openstack.org/security-guide/tenant-data/data-encryption.html>`__
feature provides a means of improving ephemeral storage privacy and isolation,
during both active use as well as when the data is to be destroyed. As in the
case of encrypted block storage, one can simply delete the encryption key to
effectively destroy the data.

Alternate measures to provide data privacy, in the creation and destruction of
ephemeral storage, will be somewhat dependent on the chosen hypervisor and the
OpenStack Compute plug-in.

The libvirt plug-in for compute may maintain ephemeral storage directly on a
filesystem, or in LVM. Filesystem storage generally will not overwrite data
when it is removed, although there is a guarantee that dirty extents are not
provisioned to users.

When using LVM backed ephemeral storage, which is block-based, it is necessary
that the OpenStack Compute software securely erases blocks to prevent
information disclosure. There have in the past been information disclosure
vulnerabilities related to improperly erased ephemeral block storage devices.

Filesystem storage is a more secure solution for ephemeral block storage
devices than LVM as dirty extents cannot be provisioned to users. However, it
is important to be mindful that user data is not destroyed, so it is suggested
to encrypt the backing filesystem.

Bare metal server sanitization
------------------------------

A bare metal server driver for Compute was under development and has since
moved into a separate project called `ironic
<https://wiki.openstack.org/wiki/Ironic>`__. At the time of this writing,
ironic does not appear to address sanitization of tenant data resident the
physical hardware.

Additionally, it is possible for tenants of a bare metal system to modify
system firmware. TPM technology, described in ?, provides a solution for
detecting unauthorized firmware changes.
