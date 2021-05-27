========================
OpenStack Security Guide
========================

Abstract
~~~~~~~~

This book provides best practices and conceptual information about
securing an OpenStack cloud.

.. important::

   This guide was last updated during the Train release, documenting
   the OpenStack Train, Stein, and Rocky releases. It may
   not apply to EOL releases (for example Newton).

   We advise that you read this at your own discretion when planning
   on implementing security measures for your OpenStack cloud.

   This guide is intended as advice only.

   The OpenStack Security team is based on voluntary contributions
   from the OpenStack community. You can contact the security community
   directly in the #openstack-security channel on OFTC IRC, or by
   sending mail to the openstack-discuss mailing list with the
   [security] prefix in the subject header.

Contents
~~~~~~~~

.. toctree::
   :maxdepth: 2

   common/conventions.rst
   introduction.rst
   documentation.rst
   management.rst
   secure-communication.rst
   api-endpoints.rst
   identity.rst
   dashboard.rst
   compute.rst
   block-storage.rst
   image-storage.rst
   shared-file-systems.rst
   networking.rst
   object-storage.rst
   secrets-management.rst
   messaging.rst
   data-processing.rst
   databases.rst
   tenant-data.rst
   instance-management.rst
   monitoring-logging.rst
   compliance.rst
   security-review.rst
   checklist.rst
   appendix.rst
