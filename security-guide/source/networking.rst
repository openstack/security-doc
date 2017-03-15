==========
Networking
==========

The OpenStack Networking service (neutron) enables the end-user or tenant to
define, utilize, and consume networking resources. OpenStack Networking
provides a tenant-facing API for defining network connectivity and IP
addressing for instances in the cloud, in addition to orchestrating the
network configuration. With the transition to an API-centric networking
service, cloud architects and administrators should take into consideration
best practices to secure physical and virtual network infrastructure and
services.

OpenStack Networking was designed with a plug-in architecture that provides
extensibility of the API through open source community or third-party services.
As you evaluate your architectural design requirements, it is important to
determine what features are available in OpenStack Networking core services,
any additional services that are provided by third-party products, and what
supplemental services are required to be implemented in the physical
infrastructure.

This section is a high-level overview of what processes and best practices
should be considered when implementing OpenStack Networking.

.. toctree::
   :maxdepth: 2

   networking/architecture.rst
   networking/services.rst
   networking/securing-services.rst
   networking/services-security-best-practices.rst
   networking/case-studies.rst
   networking/checklist.rst
