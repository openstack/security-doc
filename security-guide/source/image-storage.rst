=============
Image Storage
=============

OpenStack Image Storage (glance) is a service where users can upload and
discover data assets that are meant to be used with other services. This
currently includes images and metadata definitions.

Image services include discovering, registering, and retrieving virtual
machine images. Glance has a RESTful API that allows querying of VM image
metadata as well as retrieval of the actual image.

For more details on the service see the `OpenStack Glance documentation
<https://docs.openstack.org/glance/latest/>`__.

.. toctree::
   :maxdepth: 2

   image-storage/checklist.rst

.. note::

   Whilst this chapter is currently sparse on specific
   guidance, it is expected that standard hardening practices
   will be followed. This section will be expanded with relevant
   information.
