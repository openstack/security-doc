=============
Block Storage
=============

OpenStack Block Storage (cinder) is a service that provides software
(services and libraries) to self-service manage persistent block-level
storage devices. This creates on-demand access to Block Storage
resources for use with OpenStack Compute (nova) instances. This
creates software-defined storage via abstraction by virtualizing pools
of block storage to a variety of back-end storage devices which can be
either software implementations or traditional hardware storage
products. The primary functions of this is to manage the creation,
attaching and detaching of the block devices. The consumer requires no
knowledge of the type of back-end storage equipment or where it is
located.

Compute instances store and retrieve block storage via
industry-standard storage protocols such as iSCSI, ATA over Ethernet,
or Fibre-Channel. These resources are managed and configured via
OpenStack native standard HTTP RESTful API. For more details on the
API see the `OpenStack Block Storage documentation
<https://docs.openstack.org/api-ref/block-storage/>`__.

.. toctree::
   :maxdepth: 2

   block-storage/volume_wiping.rst
   block-storage/checklist.rst

.. note::

   Whilst this chapter is currently sparse on specific
   guidance, it is expected that standard hardening practices
   will be followed. This section will be expanded with relevant
   information.
