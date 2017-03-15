=======
Compute
=======

The OpenStack Compute service (nova) is one of the more complex OpenStack
services. It runs in many locations throughout the cloud and interacts with a
variety of internal services. The OpenStack Compute service offers a variety
of configuration options which may be deployment specific. In this chapter
we will call out general best practice around Compute security as well as
specific known configurations that can lead to security issues. In general,
the ``nova.conf`` file and the ``/var/lib/nova`` locations should be
secured. Controls like centralized logging, the ``policy.json`` file, and
a mandatory access control framework should be implemented. Additionally,
there are environmental considerations to keep in mind, depending on what
functionality is desired for your cloud.

.. toctree::
   :maxdepth: 2

   compute/hypervisor-selection.rst
   compute/hardening-the-virtualization-layers.rst
   compute/hardening-deployments.rst
   compute/vulnerability-awareness.rst
   compute/how-to-select-virtual-consoles.rst
   compute/checklist.rst
