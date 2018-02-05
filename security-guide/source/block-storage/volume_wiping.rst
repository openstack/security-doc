=============
Volume Wiping
=============

There are several ways to wipe a block storage device. The traditional way is
to set the ``lvm_type`` to ``thin``, and then use the ``volume_clear``
parameter if using the LVM backend. Alternatively, if the volume encryption
feature is used, then volume wiping is not necessary if the volume encryption
key is deleted. See the OpenStack Configuration Reference doc in the
`Volume Encryption
<https://docs.openstack.org/cinder/latest/configuration/block-storage/volume-encryption.html>`__
section for set up details and also the `Castellan usage
<https://docs.openstack.org/castellan/latest/user/index.html>`__ document
for key deletion.

.. note::

   In older OpenStack releases, ``lvm_type=default`` was used to signify a
   wipe. While this method still works, ``lvm_type=default`` is not
   recommended for setting secure delete.

The ``volume_clear`` parameter can be set to ``zero``. The ``zero`` argument
will write a single pass of zeroes to the device.

For more information about the ``lvm_type`` parameter, see sections
`LVM
<https://docs.openstack.org/cinder/latest/configuration/block-storage/drivers/lvm-volume-driver.html>`__
and `Oversubscription in thin provisioning
<https://docs.openstack.org/cinder/latest/admin/blockstorage-over-subscription.html>`__
of the *cinder* project documentation.

For more information about the ``volume_clear`` parameter, see section
`Cinder Configuration Options
<https://docs.openstack.org/cinder/latest/sample_config.html>`__
of the *cinder* project documentation.
