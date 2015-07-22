============================
Instance security management
============================

One of the virtues of running instances in a virtualized environment
is that it opens up new opportunities for security controls that are
not typically available when deploying onto bare metal. There are
several technologies that can be applied to the virtualization stack
that bring improved information assurance for cloud tenants.

Deployers or users of OpenStack with strong security requirements
may want to consider deploying these technologies. Not all are
applicable in every situation, indeed in some cases technologies may
be ruled out for use in a cloud because of prescriptive business
requirements. Similarly some technologies inspect instance data such
as run state which may be undesirable to the users of the system.

In this chapter we explore these technologies and describe the
situations where they can be used to enhance security for instances
or underlying instances. We also seek to highlight where privacy
concerns may exist. These include data pass through, introspection,
or providing a source of entropy. In this section we highlight the
following additional security services:

* Entropy to instances
* Scheduling instances to nodes
* Trusted images
* Instance migrations
* Monitoring, alerting, and reporting
* Updates and patches
* Firewalls and other host-based security controls

.. toctree::
   :maxdepth: 2

   instance-management/security-services-for-instances.rst
   instance-management/case-studies.rst
