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

For more information about the ``lvm_type`` parameter, see the `Configuration
Reference
<http://docs.openstack.org/liberty/config-reference/content/lvm-volume-driver.html>__`
and the `Administrator Guide
<http://docs.openstack.org/admin-guide/blockstorage_over_subscription.html>__`.

For more information about the ``volume_clear`` parameter, see the `OpenStack
Configuration Reference
<http://docs.openstack.org/liberty/config-reference/content/section_cinder.conf.html>`__.
