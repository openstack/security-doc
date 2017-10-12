=========
Dashboard
=========

The Dashboard (horizon) is the OpenStack dashboard that provides users a
self-service portal to provision their own resources within the limits set
by administrators. These include provisioning users, defining instance flavors,
uploading virtual machine (VM) images, managing networks, setting up security
groups, starting instances, and accessing the instances through a console.

The Dashboard is based on the Django web framework, ensuring secure deployment
practices for Django apply directly to horizon. This guide provides a
set of Django security recommendations. Further information can be found by
reading the `Django documentation <https://docs.djangoproject.com/>`_.

The Dashboard ships with default security settings, and has
`deployment and configuration documentation
<https://docs.openstack.org/horizon/latest/user/index.html>`_.

.. toctree::
   :maxdepth: 2

   dashboard/domains-dashboard-upgrades-basic-web-server-configuration.rst
   dashboard/https-hsts-xss-ssrf.rst
   dashboard/front-end-caching-session-back-end.rst
   dashboard/static-media.rst
   dashboard/passwords.rst
   dashboard/secret-key.rst
   dashboard/cookies.rst
   dashboard/cross-origin-resource-sharing-cors.rst
   dashboard/debug.rst
   dashboard/checklist.rst
.. case-studies/dashboard-case-studies.rst
