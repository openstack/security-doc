=============
Volume Wiping
=============

There are several ways to wipe a block storage device. The recommended way is
to set the ``lvm_type`` to ``thin``, and then use the ``volume_clear``
parameter.

.. note::

   In older OpenStack releases, ``lvm_type=default`` was used to signify a
   wipe. While this method still works, ``lvm_type=default`` is not
   recommended for setting secure delete.

The ``volume_clear`` parameter can accept either ``zero`` or ``shred``
arguments. The ``zero`` argument will write a single pass of zeroes to the
device. The ``shred`` argument will write three passes of predetermined bit
patterns.

For more information about the ``lvm_type`` parameter, see
the `LVM Block Storage section
<http://docs.openstack.org/mitaka/config-reference/block-storage/drivers/lvm-volume-driver.html>`__
of OpenStack Configuration Reference and
the `Oversubscription in thin provisioning
<http://docs.openstack.org/admin-guide/blockstorage_over_subscription.html>`__
of OpenStack Administrator Guide.

For more information about the ``volume_clear`` parameter, see the
`Block Storage sample configuration files
<http://docs.openstack.org/mitaka/config-reference/block-storage/block-storage-sample-configuration-files.html>`__
of OpenStack Configuration Reference.
